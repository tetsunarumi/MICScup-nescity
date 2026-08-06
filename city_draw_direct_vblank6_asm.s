; Direct-tile VBlank full-screen redraw for NES City.
;
; Exports:
;   void draw_full_map_asm(void);
;   void redraw_full_vblank_asm(void);
;
; draw_full_map_asm:
;   Rendering must be OFF. Copies all 960 grid bytes to $2000..$23BF.
;
; redraw_full_vblank_asm:
;   Rendering stays ON. Waits for VBlank internally and copies 6 rows per
;   VBlank.  A full 30-row screen takes 5 VBlanks.
;
; Direct-tile contract:
;   grid[] values 0..100 are already valid background tile IDs.

.import _grid
.import _ppu_wait_nmi

.export _draw_full_map_asm
.export _redraw_full_vblank_asm

PPUSTATUS = $2002
PPUADDR   = $2006
PPUDATA   = $2007
PPUSCROLL = $2005

.segment "CODE"

.macro SET_NT_ADDR row
    lda #>($2000 + (row) * 32)
    sta PPUADDR
    lda #<($2000 + (row) * 32)
    sta PPUADDR
.endmacro

.macro COPY_GRID_ROW row
    SET_NT_ADDR row
    lda _grid + ((row) * 32) + 0
    sta PPUDATA
    lda _grid + ((row) * 32) + 1
    sta PPUDATA
    lda _grid + ((row) * 32) + 2
    sta PPUDATA
    lda _grid + ((row) * 32) + 3
    sta PPUDATA
    lda _grid + ((row) * 32) + 4
    sta PPUDATA
    lda _grid + ((row) * 32) + 5
    sta PPUDATA
    lda _grid + ((row) * 32) + 6
    sta PPUDATA
    lda _grid + ((row) * 32) + 7
    sta PPUDATA
    lda _grid + ((row) * 32) + 8
    sta PPUDATA
    lda _grid + ((row) * 32) + 9
    sta PPUDATA
    lda _grid + ((row) * 32) + 10
    sta PPUDATA
    lda _grid + ((row) * 32) + 11
    sta PPUDATA
    lda _grid + ((row) * 32) + 12
    sta PPUDATA
    lda _grid + ((row) * 32) + 13
    sta PPUDATA
    lda _grid + ((row) * 32) + 14
    sta PPUDATA
    lda _grid + ((row) * 32) + 15
    sta PPUDATA
    lda _grid + ((row) * 32) + 16
    sta PPUDATA
    lda _grid + ((row) * 32) + 17
    sta PPUDATA
    lda _grid + ((row) * 32) + 18
    sta PPUDATA
    lda _grid + ((row) * 32) + 19
    sta PPUDATA
    lda _grid + ((row) * 32) + 20
    sta PPUDATA
    lda _grid + ((row) * 32) + 21
    sta PPUDATA
    lda _grid + ((row) * 32) + 22
    sta PPUDATA
    lda _grid + ((row) * 32) + 23
    sta PPUDATA
    lda _grid + ((row) * 32) + 24
    sta PPUDATA
    lda _grid + ((row) * 32) + 25
    sta PPUDATA
    lda _grid + ((row) * 32) + 26
    sta PPUDATA
    lda _grid + ((row) * 32) + 27
    sta PPUDATA
    lda _grid + ((row) * 32) + 28
    sta PPUDATA
    lda _grid + ((row) * 32) + 29
    sta PPUDATA
    lda _grid + ((row) * 32) + 30
    sta PPUDATA
    lda _grid + ((row) * 32) + 31
    sta PPUDATA
.endmacro

.macro RESTORE_SCROLL0
    bit PPUSTATUS
    lda #$00
    sta PPUSCROLL
    sta PPUSCROLL
.endmacro

.proc _draw_full_map_asm
    bit PPUSTATUS
    lda #$20
    sta PPUADDR
    lda #$00
    sta PPUADDR

    ldx #$00
@page0:
    lda _grid,x
    sta PPUDATA
    inx
    bne @page0

    ldx #$00
@page1:
    lda _grid+$0100,x
    sta PPUDATA
    inx
    bne @page1

    ldx #$00
@page2:
    lda _grid+$0200,x
    sta PPUDATA
    inx
    bne @page2

    ldx #$00
@tail:
    lda _grid+$0300,x
    sta PPUDATA
    inx
    cpx #$C0
    bne @tail

    rts
.endproc

.proc _redraw_full_vblank_asm
    ; VBlank chunk 0: rows 0..5
    jsr _ppu_wait_nmi
    bit PPUSTATUS
    COPY_GRID_ROW 0
    COPY_GRID_ROW 1
    COPY_GRID_ROW 2
    COPY_GRID_ROW 3
    COPY_GRID_ROW 4
    COPY_GRID_ROW 5
    RESTORE_SCROLL0

    ; VBlank chunk 1: rows 6..11
    jsr _ppu_wait_nmi
    bit PPUSTATUS
    COPY_GRID_ROW 6
    COPY_GRID_ROW 7
    COPY_GRID_ROW 8
    COPY_GRID_ROW 9
    COPY_GRID_ROW 10
    COPY_GRID_ROW 11
    RESTORE_SCROLL0

    ; VBlank chunk 2: rows 12..17
    jsr _ppu_wait_nmi
    bit PPUSTATUS
    COPY_GRID_ROW 12
    COPY_GRID_ROW 13
    COPY_GRID_ROW 14
    COPY_GRID_ROW 15
    COPY_GRID_ROW 16
    COPY_GRID_ROW 17
    RESTORE_SCROLL0

    ; VBlank chunk 3: rows 18..23
    jsr _ppu_wait_nmi
    bit PPUSTATUS
    COPY_GRID_ROW 18
    COPY_GRID_ROW 19
    COPY_GRID_ROW 20
    COPY_GRID_ROW 21
    COPY_GRID_ROW 22
    COPY_GRID_ROW 23
    RESTORE_SCROLL0

    ; VBlank chunk 4: rows 24..29
    jsr _ppu_wait_nmi
    bit PPUSTATUS
    COPY_GRID_ROW 24
    COPY_GRID_ROW 25
    COPY_GRID_ROW 26
    COPY_GRID_ROW 27
    COPY_GRID_ROW 28
    COPY_GRID_ROW 29
    RESTORE_SCROLL0

    rts
.endproc


