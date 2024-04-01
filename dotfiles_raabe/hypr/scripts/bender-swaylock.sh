#!/bin/bash
# Idea from: Internet
# screenlock with swaylock
# Modified by CLM and ChatGPT
# Description: Lock screen with swayloc
# Date: sáb 23 mar 2024 21:34:35 CET
# Dependencies: pacman -S swaylock grim ImageMagick
##############################################################################

# Function to capture and blur the desktop image
capture_desktop() {
    # Use grim to capture the screen
    grim /tmp/locking_screen.png
    # Use ImageMagick to blur the image
    convert /tmp/locking_screen.png -blur 0x8 /tmp/screen_blur.png
}

# Function to lock the screen using swaylock
lock_screen() {
    # Use the blurred screenshot as the background for swaylock
    swaylock -i /tmp/screen_blur.png
}

capture_desktop
lock_screen

