.segment "CHARS"

; Direct-tile CHR layout.
; BG tiles 0..100 match simulation values, so grid[] can be copied directly to the nametable.
; 101..119 are padding. Tile 120 is sea sprite. Tiles 121..130 are digit sprites.

; Tile 0: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 1: mountain
.byte $20,$70,$fa,$ff,$2f,$3f,$22,$02
.byte $00,$00,$00,$00,$20,$20,$22,$02

; Tile 2: forest
.byte $00,$10,$38,$38,$7c,$10,$10,$00
.byte $00,$00,$00,$00,$00,$10,$10,$00

; Tile 3: forest
.byte $00,$10,$38,$38,$7c,$10,$10,$00
.byte $00,$00,$00,$00,$00,$10,$10,$00

; Tile 4: forest
.byte $00,$10,$38,$38,$7c,$10,$10,$00
.byte $00,$00,$00,$00,$00,$10,$10,$00

; Tile 5: forest
.byte $00,$10,$38,$38,$7c,$10,$10,$00
.byte $00,$00,$00,$00,$00,$10,$10,$00

; Tile 6: forest
.byte $00,$10,$38,$38,$7c,$10,$10,$00
.byte $00,$00,$00,$00,$00,$10,$10,$00

; Tile 7: forest
.byte $00,$10,$38,$38,$7c,$10,$10,$00
.byte $00,$00,$00,$00,$00,$10,$10,$00

; Tile 8: forest
.byte $00,$10,$38,$38,$7c,$10,$10,$00
.byte $00,$00,$00,$00,$00,$10,$10,$00

; Tile 9: forest
.byte $00,$10,$38,$38,$7c,$10,$10,$00
.byte $00,$00,$00,$00,$00,$10,$10,$00

; Tile 10: forest
.byte $00,$10,$38,$38,$7c,$10,$10,$00
.byte $00,$00,$00,$00,$00,$10,$10,$00

; Tile 11: forest
.byte $00,$10,$38,$38,$7c,$10,$10,$00
.byte $00,$00,$00,$00,$00,$10,$10,$00

; Tile 12: forest
.byte $00,$10,$38,$38,$7c,$10,$10,$00
.byte $00,$00,$00,$00,$00,$10,$10,$00

; Tile 13: forest
.byte $00,$10,$38,$38,$7c,$10,$10,$00
.byte $00,$00,$00,$00,$00,$10,$10,$00

; Tile 14: forest
.byte $00,$10,$38,$38,$7c,$10,$10,$00
.byte $00,$00,$00,$00,$00,$10,$10,$00

; Tile 15: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 16: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 17: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 18: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 19: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 20: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 21: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 22: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 23: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 24: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 25: field
.byte $00,$40,$a4,$0a,$00,$20,$52,$05
.byte $ff,$bf,$5b,$f5,$ff,$df,$ad,$fa

; Tile 26: field
.byte $00,$40,$a4,$0a,$00,$20,$52,$05
.byte $ff,$bf,$5b,$f5,$ff,$df,$ad,$fa

; Tile 27: field
.byte $00,$40,$a4,$0a,$00,$20,$52,$05
.byte $ff,$bf,$5b,$f5,$ff,$df,$ad,$fa

; Tile 28: field
.byte $00,$40,$a4,$0a,$00,$20,$52,$05
.byte $ff,$bf,$5b,$f5,$ff,$df,$ad,$fa

; Tile 29: field
.byte $00,$40,$a4,$0a,$00,$20,$52,$05
.byte $ff,$bf,$5b,$f5,$ff,$df,$ad,$fa

; Tile 30: field
.byte $00,$40,$a4,$0a,$00,$20,$52,$05
.byte $ff,$bf,$5b,$f5,$ff,$df,$ad,$fa

; Tile 31: field
.byte $00,$40,$a4,$0a,$00,$20,$52,$05
.byte $ff,$bf,$5b,$f5,$ff,$df,$ad,$fa

; Tile 32: field
.byte $00,$40,$a4,$0a,$00,$20,$52,$05
.byte $ff,$bf,$5b,$f5,$ff,$df,$ad,$fa

; Tile 33: field
.byte $00,$40,$a4,$0a,$00,$20,$52,$05
.byte $ff,$bf,$5b,$f5,$ff,$df,$ad,$fa

; Tile 34: field
.byte $00,$40,$a4,$0a,$00,$20,$52,$05
.byte $ff,$bf,$5b,$f5,$ff,$df,$ad,$fa

; Tile 35: house
.byte $00,$00,$00,$00,$3c,$24,$24,$00
.byte $00,$18,$3c,$7e,$3c,$3c,$3c,$00

; Tile 36: house
.byte $00,$00,$00,$00,$3c,$24,$24,$00
.byte $00,$18,$3c,$7e,$3c,$3c,$3c,$00

; Tile 37: house
.byte $00,$00,$00,$00,$3c,$24,$24,$00
.byte $00,$18,$3c,$7e,$3c,$3c,$3c,$00

; Tile 38: house
.byte $00,$00,$00,$00,$3c,$24,$24,$00
.byte $00,$18,$3c,$7e,$3c,$3c,$3c,$00

; Tile 39: house
.byte $00,$00,$00,$00,$3c,$24,$24,$00
.byte $00,$18,$3c,$7e,$3c,$3c,$3c,$00

; Tile 40: house
.byte $00,$00,$00,$00,$3c,$24,$24,$00
.byte $00,$18,$3c,$7e,$3c,$3c,$3c,$00

; Tile 41: house
.byte $00,$00,$00,$00,$3c,$24,$24,$00
.byte $00,$18,$3c,$7e,$3c,$3c,$3c,$00

; Tile 42: house
.byte $00,$00,$00,$00,$3c,$24,$24,$00
.byte $00,$18,$3c,$7e,$3c,$3c,$3c,$00

; Tile 43: house
.byte $00,$00,$00,$00,$3c,$24,$24,$00
.byte $00,$18,$3c,$7e,$3c,$3c,$3c,$00

; Tile 44: house
.byte $00,$00,$00,$00,$3c,$24,$24,$00
.byte $00,$18,$3c,$7e,$3c,$3c,$3c,$00

; Tile 45: house
.byte $00,$00,$00,$00,$3c,$24,$24,$00
.byte $00,$18,$3c,$7e,$3c,$3c,$3c,$00

; Tile 46: house
.byte $00,$00,$00,$00,$3c,$24,$24,$00
.byte $00,$18,$3c,$7e,$3c,$3c,$3c,$00

; Tile 47: house
.byte $00,$00,$00,$00,$3c,$24,$24,$00
.byte $00,$18,$3c,$7e,$3c,$3c,$3c,$00

; Tile 48: house
.byte $00,$00,$00,$00,$3c,$24,$24,$00
.byte $00,$18,$3c,$7e,$3c,$3c,$3c,$00

; Tile 49: house
.byte $00,$00,$00,$00,$3c,$24,$24,$00
.byte $00,$18,$3c,$7e,$3c,$3c,$3c,$00

; Tile 50: apt
.byte $00,$00,$1c,$14,$00,$00,$77,$55
.byte $1c,$3e,$1c,$7e,$ff,$ff,$77,$77

; Tile 51: apt
.byte $00,$00,$1c,$14,$00,$00,$77,$55
.byte $1c,$3e,$1c,$7e,$ff,$ff,$77,$77

; Tile 52: apt
.byte $00,$00,$1c,$14,$00,$00,$77,$55
.byte $1c,$3e,$1c,$7e,$ff,$ff,$77,$77

; Tile 53: apt
.byte $00,$00,$1c,$14,$00,$00,$77,$55
.byte $1c,$3e,$1c,$7e,$ff,$ff,$77,$77

; Tile 54: apt
.byte $00,$00,$1c,$14,$00,$00,$77,$55
.byte $1c,$3e,$1c,$7e,$ff,$ff,$77,$77

; Tile 55: apt
.byte $00,$00,$1c,$14,$00,$00,$77,$55
.byte $1c,$3e,$1c,$7e,$ff,$ff,$77,$77

; Tile 56: apt
.byte $00,$00,$1c,$14,$00,$00,$77,$55
.byte $1c,$3e,$1c,$7e,$ff,$ff,$77,$77

; Tile 57: apt
.byte $00,$00,$1c,$14,$00,$00,$77,$55
.byte $1c,$3e,$1c,$7e,$ff,$ff,$77,$77

; Tile 58: apt
.byte $00,$00,$1c,$14,$00,$00,$77,$55
.byte $1c,$3e,$1c,$7e,$ff,$ff,$77,$77

; Tile 59: apt
.byte $00,$00,$1c,$14,$00,$00,$77,$55
.byte $1c,$3e,$1c,$7e,$ff,$ff,$77,$77

; Tile 60: apt
.byte $00,$00,$1c,$14,$00,$00,$77,$55
.byte $1c,$3e,$1c,$7e,$ff,$ff,$77,$77

; Tile 61: apt
.byte $00,$00,$1c,$14,$00,$00,$77,$55
.byte $1c,$3e,$1c,$7e,$ff,$ff,$77,$77

; Tile 62: apt
.byte $00,$00,$1c,$14,$00,$00,$77,$55
.byte $1c,$3e,$1c,$7e,$ff,$ff,$77,$77

; Tile 63: shop
.byte $00,$00,$39,$ff,$ff,$99,$99,$00
.byte $7f,$ff,$ff,$ff,$ff,$ff,$ff,$00

; Tile 64: shop
.byte $00,$00,$39,$ff,$ff,$99,$99,$00
.byte $7f,$ff,$ff,$ff,$ff,$ff,$ff,$00

; Tile 65: shop
.byte $00,$00,$39,$ff,$ff,$99,$99,$00
.byte $7f,$ff,$ff,$ff,$ff,$ff,$ff,$00

; Tile 66: shop
.byte $00,$00,$39,$ff,$ff,$99,$99,$00
.byte $7f,$ff,$ff,$ff,$ff,$ff,$ff,$00

; Tile 67: shop
.byte $00,$00,$39,$ff,$ff,$99,$99,$00
.byte $7f,$ff,$ff,$ff,$ff,$ff,$ff,$00

; Tile 68: shop
.byte $00,$00,$39,$ff,$ff,$99,$99,$00
.byte $7f,$ff,$ff,$ff,$ff,$ff,$ff,$00

; Tile 69: shop
.byte $00,$00,$39,$ff,$ff,$99,$99,$00
.byte $7f,$ff,$ff,$ff,$ff,$ff,$ff,$00

; Tile 70: shop
.byte $00,$00,$39,$ff,$ff,$99,$99,$00
.byte $7f,$ff,$ff,$ff,$ff,$ff,$ff,$00

; Tile 71: shop
.byte $00,$00,$39,$ff,$ff,$99,$99,$00
.byte $7f,$ff,$ff,$ff,$ff,$ff,$ff,$00

; Tile 72: shop
.byte $00,$00,$39,$ff,$ff,$99,$99,$00
.byte $7f,$ff,$ff,$ff,$ff,$ff,$ff,$00

; Tile 73: shop
.byte $00,$00,$39,$ff,$ff,$99,$99,$00
.byte $7f,$ff,$ff,$ff,$ff,$ff,$ff,$00

; Tile 74: shop
.byte $00,$00,$39,$ff,$ff,$99,$99,$00
.byte $7f,$ff,$ff,$ff,$ff,$ff,$ff,$00

; Tile 75: shop
.byte $00,$00,$39,$ff,$ff,$99,$99,$00
.byte $7f,$ff,$ff,$ff,$ff,$ff,$ff,$00

; Tile 76: shop
.byte $00,$00,$39,$ff,$ff,$99,$99,$00
.byte $7f,$ff,$ff,$ff,$ff,$ff,$ff,$00

; Tile 77: shop
.byte $00,$00,$39,$ff,$ff,$99,$99,$00
.byte $7f,$ff,$ff,$ff,$ff,$ff,$ff,$00

; Tile 78: shop
.byte $00,$00,$39,$ff,$ff,$99,$99,$00
.byte $7f,$ff,$ff,$ff,$ff,$ff,$ff,$00

; Tile 79: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 80: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 81: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 82: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 83: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 84: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 85: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 86: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 87: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 88: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 89: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 90: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 91: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 92: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 93: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 94: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 95: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 96: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 97: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 98: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 99: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 100: building
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa
.byte $ff,$aa,$ff,$aa,$ff,$aa,$ff,$aa

; Tile 101: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 102: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 103: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 104: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 105: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 106: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 107: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 108: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 109: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 110: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 111: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 112: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 113: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 114: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 115: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 116: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 117: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 118: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 119: ground
.byte $00,$44,$10,$22,$00,$88,$00,$20
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Tile 120: sea_spr
.byte $ff,$ef,$93,$ff,$ff,$f7,$c9,$ff
.byte $00,$10,$6c,$00,$00,$08,$36,$00

; Tile 121: DIGIT_0
.byte $3c,$66,$6e,$76,$66,$66,$3c,$00
.byte $3c,$66,$6e,$76,$66,$66,$3c,$00

; Tile 122: DIGIT_1
.byte $18,$38,$18,$18,$18,$18,$7e,$00
.byte $18,$38,$18,$18,$18,$18,$7e,$00

; Tile 123: DIGIT_2
.byte $3c,$66,$06,$1c,$30,$60,$7e,$00
.byte $3c,$66,$06,$1c,$30,$60,$7e,$00

; Tile 124: DIGIT_3
.byte $3c,$66,$06,$1c,$06,$66,$3c,$00
.byte $3c,$66,$06,$1c,$06,$66,$3c,$00

; Tile 125: DIGIT_4
.byte $0c,$1c,$3c,$6c,$7e,$0c,$0c,$00
.byte $0c,$1c,$3c,$6c,$7e,$0c,$0c,$00

; Tile 126: DIGIT_5
.byte $7e,$60,$7c,$06,$06,$66,$3c,$00
.byte $7e,$60,$7c,$06,$06,$66,$3c,$00

; Tile 127: DIGIT_6
.byte $1c,$30,$60,$7c,$66,$66,$3c,$00
.byte $1c,$30,$60,$7c,$66,$66,$3c,$00

; Tile 128: DIGIT_7
.byte $7e,$06,$0c,$18,$30,$30,$30,$00
.byte $7e,$06,$0c,$18,$30,$30,$30,$00

; Tile 129: DIGIT_8
.byte $3c,$66,$66,$3c,$66,$66,$3c,$00
.byte $3c,$66,$66,$3c,$66,$66,$3c,$00

; Tile 130: DIGIT_9
.byte $3c,$66,$66,$3e,$06,$0c,$38,$00
.byte $3c,$66,$66,$3e,$06,$0c,$38,$00

