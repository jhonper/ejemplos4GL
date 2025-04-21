
#############################################################################
# Copyright 1993 Advanced DataTools Corporation
# Module: @(#)termtest.4gl 1.4 Date: 05/10/1993
# Author: Lester B. Knutsen
# Description: Program to test the Informix 4GL capabilities of a terminal
#############################################################################
main
define ans char(1)

# Test if border line graphics are displayed correctly
open window test_box at 5,10 with 16 rows, 60 columns
attribute ( border , prompt line last )
display "Terminal Color, Graphics and Function key Test" at 1,7

# Test color and display attributes
display "Line 1 - reverse" at 2,1 attribute( reverse )
display "Line 2 - bold" at 3,1 attribute( bold )
display "Line 3 - dim" at 4,1 attribute( dim )
display "Line 4 - underline" at 5,1 attribute( underline )
display "Line 5 - white" at 6,1 attribute( white )
display "Line 6 - yellow" at 7,1 attribute( yellow )
display "Line 7 - magenta" at 8,1 attribute( magenta )
display "Line 8 - red" at 9,1 attribute( red )
display "Line 9 - cyan" at 10,1 attribute( cyan )
display "Line 10 - green" at 11,1 attribute( green )
display "Line 11 - blue" at 12,1 attribute( blue )
display "Line 12 - black" at 13,1 attribute( black ) # invsible line

# Test Function keys F1 to F10
while ( true )
    prompt "Press a Function Key [F1-F10] or Q to quit" for char ans
        on key (F1) error "F1 Function key pressed"
        on key (F2) error "F2 Function key pressed"
        on key (F3) error "F3 Function key pressed"
        on key (F4) error "F4 Function key pressed"
        on key (F5) error "F5 Function key pressed"
        on key (F6) error "F6 Function key pressed"
        on key (F7) error "F7 Function key pressed"
        on key (F8) error "F8 Function key pressed"
        on key (F9) error "F9 Function key pressed"
        on key (F10) error "F10 Function key pressed"
    end prompt
    if ans = "q" or ans = "Q" then exit while end if
end while
end main

