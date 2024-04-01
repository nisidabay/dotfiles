#!/bin/bash
# Idea from: Internet
# i3 screen-lock with a clock
# Modified by CLM and ChatGPT
# Description: Lock screen with the a clock
# Date: mar 17 ene 2023 01:35:18 CET
# Modified date: dom 31 dic 2023 08:25:51 CET
# Dependencies: yay -S i3lock-color
##############################################################################


# Function to capture and blur the desktop image
capture_desktop() {
    scrot -d 1 /tmp/locking_screen.png
    convert -blur 0x8 /tmp/locking_screen.png /tmp/screen_blur.png
}

# Function to lock the screen 
lock_screen() {
    style_lock
}

style_lock() {
# Configure the appearance of the lock
    
BLANK='#00000000'
CLEAR='#ffffff22'
DEFAULT='#00897bE6'
TEXT='#00897bE6'
WRONG='#880000bb'
VERIFYING='#00564dE6'

i3lock \
--insidever-color=$CLEAR     \
--ringver-color=$VERIFYING   \
\
--insidewrong-color=$CLEAR   \
--ringwrong-color=$WRONG     \
\
--inside-color=$BLANK        \
--ring-color=$DEFAULT        \
--line-color=$BLANK          \
--separator-color=$DEFAULT   \
\
--verif-color=$TEXT          \
--wrong-color=$TEXT          \
--time-color=$TEXT           \
--date-color=$TEXT           \
--layout-color=$TEXT         \
--keyhl-color=$WRONG         \
--bshl-color=$WRONG          \
\
--screen 1                   \
--blur 9                     \
--clock                      \
--indicator                  \
--time-str="%H:%M:%S"        \
--date-str="%A, %Y-%m-%d"       \
--keylayout 1                
}

capture_desktop
lock_screen


