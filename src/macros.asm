
macro a8()
    SEP #$20
endmacro

macro a16()
    REP #$20
endmacro

macro i8()
    SEP #$10
endmacro

macro ai8()
    SEP #$30
endmacro

macro ai16()
    REP #$30
endmacro

macro i16()
    REP #$10
endmacro

macro item_index_to_vram_index()
    ; Find screen position from Y (item number)
    TYA : ASL #5
    CLC : ADC #$0146 : TAX
endmacro


; ----------------
; Main Menu Macros
; ----------------

macro cm_header(title)
    db !PALETTE_HEADER, "<title>", #$FF
endmacro

macro cm_footer(title)
    dw #$F007 : db !PALETTE_HEADER, "<title>", #$FF
endmacro

macro cm_version_header(title, major, minor, build, rev_1, rev_2)
if !VERSION_REV_1 ;              ^ = lowercase v
    db !PALETTE_HEADER, "<title> ^<major>.<minor>.<build>"
if !DEV_BUILD
    db #$FF
else
    db ".<rev_1><rev_2>", #$FF
endif
else
if !VERSION_REV_2
    db !PALETTE_HEADER, "<title> ^<major>.<minor>.<build>"
if !DEV_BUILD
    db #$FF
else
    db ".<rev_2>", #$FF
endif
else
    db !PALETTE_HEADER, "<title> ^<major>.<minor>.<build>", #$FF
endif
endif
endmacro

macro cm_numfield(title, addr, min, max, increment, heldincrement, jsltarget)
    dw !ACTION_NUMFIELD
    dl <addr>
    db <min>, <max>, <increment>, <heldincrement>
    dw <jsltarget>
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro cm_numfield_8bit(title, addr, min, max, increment, heldincrement, jsltarget)
    dw !ACTION_NUMFIELD_8BIT
    dl <addr>
    db <min>, <max>, <increment>, <heldincrement>
    dw <jsltarget>
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro cm_numfield_decimal(title, addr, min, max, increment, heldincrement, jsltarget)
    dw !ACTION_NUMFIELD_DECIMAL
    dl <addr>
    db <min>, <max>, <increment>, <heldincrement>
    dw <jsltarget>
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro cm_numfield_word(title, addr, min, max, increment, heldincrement, jsltarget)
    dw !ACTION_NUMFIELD_WORD
    dl <addr>
    dw <min>, <max>, <increment>, <heldincrement>
    dw <jsltarget>
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro cm_numfield_hex(title, addr, min, max, increment, heldincrement, jsltarget)
    dw !ACTION_NUMFIELD_HEX
    dl <addr>
    db <min>, <max>, <increment>, <heldincrement>
    dw <jsltarget>
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro cm_numfield_hex_word(title, addr, bitmask, jsltarget)
; Displays a 16-bit value in hexadecimal
    dw !ACTION_NUMFIELD_HEX_WORD
    dl <addr> ; 24bit RAM address to display/manipulate
    dw <bitmask> ; 16bit mask to cap value (for colors)
    dw <jsltarget> ; 16bit address to code in the same bank as current menu/submenu
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro cm_numfield_time(title, addr, routine, argument)
    dw !ACTION_NUMFIELD_TIME
    dl <addr>
    dw <routine>
    dw <argument>
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro cm_numfield_color(title, addr, jsltarget)
    dw !ACTION_NUMFIELD_COLOR
    dl <addr>
    dw <jsltarget>
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro cm_numfield_sound(title, addr, min, max, increment, heldincrement, jsltarget)
    dw !ACTION_NUMFIELD_SOUND
    dl <addr>
    db <min>, <max>, <increment>, <heldincrement>
    dw <jsltarget>
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro cm_toggle(title, addr, value, jsltarget)
    dw !ACTION_TOGGLE
    dl <addr>
    db <value>
    dw <jsltarget>
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro cm_toggle_inverted(title, addr, value, jsltarget)
    dw !ACTION_TOGGLE_INVERTED
    dl <addr>
    db <value>
    dw <jsltarget>
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro cm_toggle_bit(title, addr, mask, jsltarget)
    dw !ACTION_TOGGLE_BIT
    dl <addr>
    dw <mask>
    dw <jsltarget>
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro cm_toggle_bit_inverted(title, addr, mask, jsltarget)
    dw !ACTION_TOGGLE_BIT_INVERTED
    dl <addr>
    dw <mask>
    dw <jsltarget>
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro cm_jsl(title, routine, argument)
    dw !ACTION_JSL
    dw <routine>
    dw <argument>
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro cm_jsl_submenu(title, routine, argument)
    dw !ACTION_JSL_SUBMENU
    dw <routine>
    dw <argument>
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro cm_mainmenu(title, target)
    %cm_jsl("<title>", #action_mainmenu, <target>)
endmacro

macro cm_submenu(title, target)
    %cm_jsl_submenu("<title>", #action_submenu, <target>)
endmacro

macro cm_ctrl_shortcut(title, addr)
    dw !ACTION_CTRL_SHORTCUT
    dl <addr>
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro cm_ctrl_input(title, addr, routine, argument)
    dw !ACTION_CTRL_INPUT
    dl <addr>
    dw <routine>
    dw <argument>
    db !PALETTE_TEXT, "<title>", #$FF
endmacro

macro palettemenu(title, pointer, addr)
    %cm_submenu("<title>", <pointer>)
    
<pointer>:
    dw #palettes_hex_red
    dw #palettes_hex_green
    dw #palettes_hex_blue
    dw #$FFFF
    dw #palettes_dec_red
    dw #palettes_dec_green
    dw #palettes_dec_blue
    dw #$FFFF
    dw #<pointer>_hex_hi
    dw #<pointer>_hex_lo
    dw #$0000
    %cm_header("<title>")
    %cm_footer("THREE WAYS TO EDIT COLORS")

<pointer>_hex_hi:
    %cm_numfield_hex("SNES BGR - HI BYTE", !ram_pal_hi, 0, 255, 1, 8, .routine)
  .routine
    %a8() ; ram_pal_hi already in A
    XBA : LDA !ram_pal_lo
    %a16()
    STA <addr>
    JML MixBGR

<pointer>_hex_lo:
    %cm_numfield_hex("SNES BGR - LO BYTE", !ram_pal_lo, 0, 255, 1, 8, .routine)
  .routine
    %a8() ; ram_pal_lo already in A
    XBA : LDA !ram_pal_hi : XBA
    %a16()
    STA <addr>
    JML MixBGR
}
endmacro

macro setupRGB(addr)
    LDA.w #<addr> : STA !DP_Temp ; addr
    LDA.w #<addr>>>16 : STA !DP_Temp+2 ; bank
    JSL cm_setup_RGB
    RTS
endmacro

macro setmenubank()
    PHK : PHK : PLA
    STA !ram_cm_menu_bank
endmacro

macro cm_fixdp()
    PHD
    PEA $0000 : PLD
endmacro

macro SDE_add(label, value, mask, inverse)
cm_SDE_add_<label>:
; subroutine to add to a specific hex digit, used in cm_edit_digits
    AND <mask> : CMP <mask> : BEQ .inc2zero
    CLC : ADC <value> : BRA .store
  .inc2zero
    LDA #$0000
  .store
    STA !DP_DigitValue
    ; return original value with edited digit masked away
    LDA [!DP_DigitAddress] : AND <inverse>
    RTS
endmacro

macro SDE_sub(label, value, mask, inverse)
cm_SDE_sub_<label>:
; subroutine to subtract from a specific hex digit, used in cm_edit_digits
    AND <mask> : BEQ .set2max
    SEC : SBC <value> : BRA .store
  .set2max
    LDA <mask>
  .store
    STA !DP_DigitValue
    ; return original value with edited digit masked away
    LDA [!DP_DigitAddress] : AND <inverse>
    RTS
endmacro

macro SDE_dec(label, address)
; increments or decrements an address based on controller input, used in cm_edit_decimal_digits
    LDA !LK_Controller_Current : BIT !CTRL_UP : BNE .<label>_inc
    ; dec
    LDA <address> : DEC : BPL .store_<label>
    LDA #$0009 : BRA .store_<label>
  .<label>_inc
    LDA <address> : INC
    CMP #$000A : BMI .store_<label>
    LDA #$0000
  .store_<label>
    STA <address>
endmacro
