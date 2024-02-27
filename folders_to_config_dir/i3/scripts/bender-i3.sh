#!/usr/bin/bash
# Idea from: Internet
# i3 screen-lock with random images
# Modified by CLM and ChatGPT
# Description: Lock screen with random images
# Date: mar 17 ene 2023 01:35:18 CET
# Modified date: dom 31 dic 2023 08:25:51 CET
# Dependencies: yay -S i3lock-color
##############################################################################

# Declare variables for directory path and file types
img_dir=~/Templates/
file_types=(jpg png)

# Declare an empty array for images
images=()

# Function to delete the screenshot
delete_screenshot() {
    unlink /tmp/locking_screen.png
    unlink /tmp/screen_blur.png
    unlink /tmp/screen.png
}

# Trap to delete the screenshot when the script is interrupted
trap delete_screenshot SIGINT SIGHUP

# Function to get a list of all image files in the directory
get_images() {
    for file in "$img_dir"/*."${file_types[@]}"; do
        if [ -f "$file" ]; then
            images+=("$file")
        fi
    done

    if [ ${#images[@]} -eq 0 ]; then
        echo "No image files found in $img_dir"
        exit 1
    fi
}

# Function to capture and blur the desktop image
capture_desktop() {
    scrot -d 1 /tmp/locking_screen.png
    convert -blur 0x8 /tmp/locking_screen.png /tmp/screen_blur.png
}

# Function to composite a random image on top of the blurred desktop image
composite_image() {
    random_image=$(shuf -n 1 -e "${images[@]}")
    convert -composite /tmp/screen_blur.png "$random_image" -gravity Center -geometry -20x1200 /tmp/screen.png
}

# Function to lock the screen with the new image
lock_screen() {
    # Comment the line below and uncomment the i3lock -i /tmp/screen.png to
    # screen an image on top of the lock screen
    style_lock
    # i3lock -i /tmp/screen.png
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

# Get a list of all image files in the directory
get_images

# Capture and blur the desktop image
capture_desktop

# Composite a random image on top of the blurred desktop image
composite_image

# Lock the screen with the new image
lock_screen

# Delete the screenshot
delete_screenshot

