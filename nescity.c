#include "neslib.h"

//#link "city_tiles_chr_direct.s"
//#link "city_draw_direct_vblank6_asm.s"

/*
  Hybrid version:
    - simulation code is kept in C, based on nes_city_260518.c
    - display uses direct-tile CHR and VBlank-split ASM redraw
    - city_compute_asm_fixed.s is intentionally NOT linked, to reduce PRG ROM size
*/

/*
  NES City Cellular Automaton for 8bitworkshop / NES C

  This version does NOT upload CHR data at runtime.
  Instead, custom tiles are linked as CHR ROM via:


  Visual policy:
    - Sea is a fixed simulation cell, drawn as a blue sprite.
    - The upper-left 4 sprite tiles show step_count % 10000.
    - Background uses only four shared colors:
        color 0: dark green
        color 1: yellow green
        color 2: light brown
        color 3: gray
    - All 4 background palettes are identical, so attribute-table boundaries
      should not create visible color mismatches.
    - Houses, shops, apartments, and buildings are distinguished mostly by shape.

  Conditions:
    - 32 x 30 cells
    - 8-bit integer state per cell
    - 5 x 5 weighted neighborhood
    - torus boundary
    - simultaneous update using 3 rolling next rows
    - sea cells are fixed
    - no station, no rail, no factory
*/

#define W 32
#define H 30
#define N 960

#define SEA 0
#define MOUNTAIN 1

#define FORCE_THRESHOLD 20
#define FORCE_SCALE 20
#define MAX_RISE 1
#define MAX_FALL 3

#define DECLINE_STRENGTH 1
#define NATURE_DECAY 1
#define NATURE_RECOVERY 1

#define CAPACITY_LIMIT 55
#define CAPACITY_SCALE 3
#define OVERCROWDING_DECAY 4

#define WATER_PER_SEA 12
#define WATER_PENALTY_SCALE 20

#define FRAME_DELAY 6

unsigned char grid[N];
unsigned char next_rows[3][W];
unsigned char top_rows[2][W];

unsigned int seed16;
unsigned int step_count;
unsigned char water_penalty;

/*
  Background palette:
    All four BG palettes are identical, so attribute-table color changes are invisible.

    NES colors:
      0x09 dark green
      0x19 yellow green
      0x27 light brown / tan -> 0x17 brown
      0x10 gray
*/
const unsigned char pal_bg_city[16] = {
  0x09, 0x19, 0x17, 0x10,
  0x09, 0x19, 0x17, 0x10,
  0x09, 0x19, 0x17, 0x10,
  0x09, 0x19, 0x17, 0x10
};

/* Sprite palette 0 is reserved for sea. Sprite color 0 is transparent. */
const unsigned char pal_spr_city[16] = {
  0x0f, 0x01, 0x11, 0x21,
  0x0f, 0x00, 0x10, 0x30,
  0x0f, 0x00, 0x10, 0x30,
  0x0f, 0x00, 0x10, 0x30
};

#define TILE_GROUND    0
#define TILE_MOUNTAIN  1
#define TILE_FOREST    2
#define TILE_FIELD     3
#define TILE_HOUSE     4
#define TILE_APT       5
#define TILE_SHOP      6
#define TILE_BUILDING  7
#define TILE_SEA_SPR   120
#define TILE_DIGIT_0    121
#define SPR_PAL_SEA     0
#define SPR_PAL_DIGIT   1

unsigned char rng8(void) {
  seed16 = seed16 * 251u + 13849u;
  return (unsigned char)(seed16 >> 8);
}

unsigned char wrap_x(signed char x) {
  return ((unsigned char)x) & 31;
}

unsigned char wrap_y(signed char y) {
  while (y < 0) y += H;
  while (y >= H) y -= H;
  return (unsigned char)y;
}

unsigned int map_idx(signed char x, signed char y) {
  return ((unsigned int)wrap_y(y)) * W + wrap_x(x);
}

unsigned char clamp_u8(signed int v, unsigned char lo, unsigned char hi) {
  if (v < lo) return lo;
  if (v > hi) return hi;
  return (unsigned char)v;
}

unsigned char is_urban(unsigned char v) {
  return (v >= 35 && v <= 100);
}

unsigned char is_house(unsigned char v) {
  return (v >= 35 && v <= 62);
}

unsigned char is_shop(unsigned char v) {
  return (v >= 63 && v <= 78);
}

unsigned char is_tall(unsigned char v) {
  return (v >= 79 && v <= 100);
}

unsigned char is_natural(unsigned char v) {
  return (v >= 1 && v <= 24);
}

/* 5x5 Manhattan-distance weight.
   center=5, distance1=4, distance2=3, distance3=2, distance4=1 */
unsigned char weight5(signed char dx, signed char dy) {
  signed char d;
  d = dx;
  if (d < 0) d = -d;
  if (dy < 0) d += -dy;
  else d += dy;
  if (d >= 4) return 1;
  return (unsigned char)(5 - d);
}

signed int influence_of(unsigned char v, unsigned char w) {
  
//  if (v == SEA) return -3 * (signed int)w;
//  if (v <= 1) return -3 * (signed int)w;   /* mountain */
//  if (v <= 14) return -1 * (signed int)w;  /* forest */
//  if (v <= 24) return 0;                   /* grass */
//  if (v <= 34) return 1 * (signed int)w;   /* field */
//  if (v <= 49) return 2 * (signed int)w;   /* house */
//  if (v <= 62) return 3 * (signed int)w;   /* apartment */
//  if (v <= 78) return 4 * (signed int)w;   /* shop */
//  return 5 * (signed int)w;                /* building */

  if (v == SEA) return 3 * (signed int)w;
  if (v <= 1) return -2 * (signed int)w;   /* mountain */
  if (v <= 14) return -2 * (signed int)w;  /* forest */
  if (v <= 24) return 2;                   /* grass */
  if (v <= 34) return 1 * (signed int)w;   /* field */
  if (v <= 49) return 2 * (signed int)w;   /* house */
  if (v <= 62) return 3 * (signed int)w;   /* apartment */
  if (v <= 78) return 2 * (signed int)w;   /* shop */
  return 1 * (signed int)w;                /* building */
}

unsigned char bg_tile_for_value(unsigned char v) {
  /* Direct-tile CHR layout: simulation values 0..100 are also BG tile IDs. */
  return v;
}

void copy_row_to(unsigned char *dst, unsigned char row) {
  unsigned char x;
  unsigned int base;
  base = ((unsigned int)row) * W;
  for (x = 0; x < W; ++x) dst[x] = grid[base + x];
}

void copy_row_from(unsigned char row, unsigned char *src) {
  unsigned char x;
  unsigned int base;
  base = ((unsigned int)row) * W;
  for (x = 0; x < W; ++x) grid[base + x] = src[x];
}

/* Read previous-step value while rows are being overwritten.
   When computing bottom rows, row 0 and row 1 may already have been overwritten,
   so read saved copies from top_rows. */
unsigned char get_old_cell(signed char x, signed char y, unsigned char current_y) {
  unsigned char xx;
  unsigned char yy;
  xx = wrap_x(x);
  yy = wrap_y(y);
  if (current_y >= H - 2 && yy < 2) {
    return top_rows[yy][xx];
  }
  return grid[((unsigned int)yy) * W + xx];
}

void set_cell(signed char x, signed char y, unsigned char v) {
  unsigned int i;
  i = map_idx(x, y);
  if (grid[i] != SEA) grid[i] = v;
}

void add_town(signed char cx, signed char cy, unsigned char radius, unsigned char core) {
  signed char dx, dy;
  unsigned char d;
  signed int v;
  for (dy = -3; dy <= 3; ++dy) {
    for (dx = -3; dx <= 3; ++dx) {
      d = (dx < 0 ? -dx : dx) + (dy < 0 ? -dy : dy);
      if (d <= radius + 1) {
        v = (signed int)core - (signed int)d * 3 + (rng8() & 1);
        set_cell(cx + dx, cy + dy, clamp_u8(v, 35, 58));
      }
    }
  }
}

void make_initial(void) {
  unsigned int i;
  unsigned char y;
  signed char cx;
  unsigned char r;

  seed16 = 6502u;
  step_count = 0;

  for (i = 0; i < N; ++i) {
    r = rng8();
    if (r < 38) grid[i] = 8 + (rng8() % 6);        /* forest */
    else if (r < 90) grid[i] = 25 + (rng8() % 8);  /* field */
    else grid[i] = 17 + (rng8() % 6);              /* grass */
  }

  /* Fixed sea: winding coastline / river.
     Keep it mostly vertical, so sprite-per-scanline pressure stays low. */
  cx = 5;
  for (y = 0; y < H; ++y) {
    r = rng8();
    if (r < 92) --cx;
    else if (r > 174) ++cx;
    if (cx < 1) cx = 1;
    if (cx > 8) cx = 8;
    grid[map_idx(cx, y)] = SEA;
    if ((y % 3) != 0) grid[map_idx(cx + 1, y)] = SEA;
  }

  /* Mountains: mutable, but hard to develop. */
  set_cell(29, 4, MOUNTAIN);
  set_cell(30, 5, MOUNTAIN);
  set_cell(28, 5, MOUNTAIN);
  set_cell(30, 6, MOUNTAIN);
  set_cell(3, 26, MOUNTAIN);
  set_cell(4, 27, MOUNTAIN);
  set_cell(5, 27, MOUNTAIN);

  /* Several residential neighborhoods. */
  add_town(16, 15, 2, 48);
  add_town(21, 18, 2, 52);
  add_town(7, 23, 2, 45);
  add_town(27, 10, 2, 43);
  add_town(12, 8, 1, 41);

  /* Tiny shop seeds. No station, no rail, no factory. */
  set_cell(17, 15, 64);
  set_cell(22, 18, 66);
  set_cell(27, 10, 63);
}

void compute_water_penalty(void) {
  unsigned int i;
  unsigned int sea_count;
  unsigned int demand;
  unsigned int capacity;
  unsigned char v;

  sea_count = 0;
  demand = 0;

  for (i = 0; i < N; ++i) {
    v = grid[i];
    if (v == SEA) ++sea_count;
    else if (v >= 35 && v <= 49) demand += 1;
    else if (v >= 50 && v <= 62) demand += 2;
    else if (v >= 63 && v <= 78) demand += 3;
    else if (v >= 79) demand += 6;
  }

  capacity = sea_count * WATER_PER_SEA;
  if (demand > capacity) water_penalty = (unsigned char)((demand - capacity) / WATER_PENALTY_SCALE);
  else water_penalty = 0;
}

void compute_next_row(unsigned char y, unsigned char *out) {
  unsigned char x;
  signed char dx, dy;
  unsigned char self, v, w;
  signed int raw_force;
  signed int weighted_sum;
  signed int weight_sum;
  signed int avg;
  signed int bias;
  signed int delta;
  signed int newv;
  unsigned char sea, mountain, natural, urban, house, shop, tall;
  unsigned char isolation, natural_pressure;
  signed int over_capacity;

  for (x = 0; x < W; ++x) {
    self = get_old_cell((signed char)x, (signed char)y, y);
    if (self == SEA) {
      out[x] = SEA;
      continue;
    }

    raw_force = 0;
    weighted_sum = 0;
    weight_sum = 0;
    sea = mountain = natural = urban = house = shop = tall = 0;

    for (dy = -2; dy <= 2; ++dy) {
      for (dx = -2; dx <= 2; ++dx) {
        v = get_old_cell((signed char)x + dx, (signed char)y + dy, y);
        w = weight5(dx, dy);
        raw_force += influence_of(v, w);
        weighted_sum += (signed int)v * (signed int)w;
        weight_sum += w;

        if (v == SEA) ++sea;
        if (v <= 1 && v != SEA) ++mountain;
        if (is_natural(v)) ++natural;
        if (is_urban(v)) ++urban;
        if (is_house(v)) ++house;
        if (is_shop(v)) ++shop;
        if (is_tall(v)) ++tall;
      }
    }

    avg = weighted_sum / weight_sum;
    bias = 0;

    if (self <= 1) bias -= 4;

    /* Natural land develops only when nearby housing exists. */
    if (self >= 1 && self <= 34) {
      if (house >= 2) bias += 2;
      if (house >= 4) bias += 2;
      if (house >= 7) bias += 2;
      if (shop >= 1 && house >= 3) bias += 1;
      if (sea >= 4) bias -= 2;
      if (mountain >= 3 && house < 4) bias -= 3;
      if (house < 2) bias -= 3;
    }

    if (self >= 35 && self <= 62) {
      if (shop >= 1) bias += 2;
      if (tall >= 2) bias += 1;
    }

    if (self >= 63) {
      if (shop + tall >= 4) bias += 2;
    }

    /* Decline: isolation, nature, water shortage. */
    if (self >= 35) {
      isolation = (urban < 5) ? (5 - urban) : 0;
      natural_pressure = natural + sea * 2 + mountain * 2;
      bias -= DECLINE_STRENGTH * isolation;
      bias -= NATURE_DECAY * (natural_pressure / 16);
      bias -= water_penalty;
    }

    /* Generic overcrowding pressure, not a building-specific rule. */
    over_capacity = avg - CAPACITY_LIMIT;
    if (over_capacity > 0) {
      bias -= (over_capacity / CAPACITY_SCALE) * OVERCROWDING_DECAY;
    }

    if (self >= 25 && self < 35 && urban < 3 && raw_force < 12) {
      bias -= NATURE_RECOVERY;
    }
    if (raw_force < 15 && self < 35) bias -= 1;

    delta = (raw_force - FORCE_THRESHOLD) / FORCE_SCALE + bias;
    if (avg > (signed int)self + 12) ++delta;
    if (avg < (signed int)self - 20) --delta;

    if (delta > MAX_RISE) delta = MAX_RISE;
    if (delta < -MAX_FALL) delta = -MAX_FALL;

    newv = (signed int)self + delta;
    if (newv < 1) newv = 1;
    if (newv > 100) newv = 100;

    /* Mountain can develop only slowly. */
    if (self <= 1 && newv > 8) newv = 8;

    out[x] = (unsigned char)newv;
  }
}

void sim_step(void) {
  unsigned char y;

//  compute_water_penalty();

  /* Save top rows before any writeback, for vertical wraparound near the bottom. */
  copy_row_to(top_rows[0], 0);
  copy_row_to(top_rows[1], 1);

  for (y = 0; y < H; ++y) {
    compute_next_row(y, next_rows[y % 3]);

    /* Row y-2 will never again be needed as an old row, except rows 0/1 at bottom,
       and those are already saved in top_rows. */
    if (y >= 2) {
      copy_row_from(y - 2, next_rows[(y - 2) % 3]);
    }
  }

  /* Flush remaining bottom rows. */
  copy_row_from(28, next_rows[28 % 3]);
  copy_row_from(29, next_rows[29 % 3]);

  ++step_count;
}

unsigned char draw_step_sprites(unsigned char sprid) {
  unsigned int n;
  unsigned char d0, d1, d2, d3;

  n = step_count % 10000u;
  d0 = (unsigned char)(n / 1000u);
  n = n % 1000u;
  d1 = (unsigned char)(n / 100u);
  n = n % 100u;
  d2 = (unsigned char)(n / 10u);
  d3 = (unsigned char)(n % 10u);

  /* First four OAM entries have highest sprite priority.
     They occupy the upper-left 4 tiles: x=0..31, y=0..7. */
  sprid = oam_spr(8,  8, TILE_DIGIT_0 + d0, SPR_PAL_DIGIT, sprid);
  sprid = oam_spr(16, 8, TILE_DIGIT_0 + d1, SPR_PAL_DIGIT, sprid);
  sprid = oam_spr(24, 8, TILE_DIGIT_0 + d2, SPR_PAL_DIGIT, sprid);
  sprid = oam_spr(32, 8, TILE_DIGIT_0 + d3, SPR_PAL_DIGIT, sprid);
  return sprid;
}

void update_digit_sprites(void) {
  draw_step_sprites(0);
}

void init_static_sprites(void) {
  unsigned char x, y;
  unsigned char sprid;
  unsigned int i;

  /* Sea sprites never move because SEA cells are fixed.
     Build the OAM buffer once, then update only the first four digit sprites. */
  oam_clear();
  sprid = draw_step_sprites(0);

  for (y = 0; y < H; ++y) {
    for (x = 0; x < W; ++x) {
      i = ((unsigned int)y) * W + x;
      if (grid[i] == SEA) {
        if (sprid >= 252) return; /* 63 sprites. Keep one slot margin. */
        sprid = oam_spr(x << 3, y << 3, TILE_SEA_SPR, SPR_PAL_SEA, sprid);
      }
    }
  }
}

void draw_full_map_asm(void);
void redraw_full_vblank_asm(void);

void clear_attr_table(void) {
  vram_adr(0x23c0);
  vram_fill(0x00, 64);
}

void main(void) {
  unsigned char frame;

  /* No runtime CHR upload here. city_tiles_chr_direct.s provides CHR ROM. */
  ppu_off();
  pal_bg(pal_bg_city);
  pal_spr(pal_spr_city);
  make_initial();

  /* Direct-tile display:
     grid[] values 0..100 are valid BG tile IDs, so the ASM renderer can copy
     grid[] directly to the nametable without calling bg_tile_for_value().
     Attribute table is constant because all four BG palettes are identical.
     Sea sprites are fixed, so initialize OAM once and update only step digits. */
  clear_attr_table();
  init_static_sprites();
  draw_full_map_asm();
  scroll(0, 0);
  ppu_on_all();

  frame = 0;

  while (1) {
    ppu_wait_nmi();
    update_digit_sprites();

    ++frame;
    if (frame >= FRAME_DELAY) {
      frame = 0;
      sim_step();

      /* step_count changed in sim_step(). Prepare digit sprites before the
         redraw routine waits for its first VBlank. */
      update_digit_sprites();

      /* Keep rendering ON. The ASM routine waits for VBlank internally and
         transfers 6 rows per VBlank; the whole 32x30 map updates in 5 VBlanks. */
      redraw_full_vblank_asm();
    }
  }
}
