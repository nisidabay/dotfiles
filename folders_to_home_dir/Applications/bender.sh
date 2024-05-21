#!/bin/bash
#!/bin/bash

# Lock screen with random images
# Idea from: Internet
# Author: 
# Modified by CLM and ChatGPT
# Date: mar 17 ene 2023 01:35:18 CET
# Dependencies:
##############################################################################

# Declare variables for directory path and file types
img_dir=$HOME/Templates
file_types=(jpg png)

# Declare an empty array for images
images=()

# Function to delete the screenshot
delete_screenshot() {
    unlink /tmp/locking_screen.png
    unlink /tmp/screen_blur.png
    unlink /tmp/screen.png

    # Deactivate screen saver and restore DPMS settings
    xset s off
    xset +dpms
}

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
    i3lock -i /tmp/screen.png
}

# Function to put the computer in standby mode
standby_mode() {
    sleep 5m
    xset s on
    xset +dpms
}

# Get a list of all image files in the directory
get_images

# Capture and blur the desktop image
capture_desktop

# Composite a random image on top of the blurred desktop image
composite_image

# Lock the screen with the new image
lock_screen

# Put the computer in standby mode
standby_mode

# Delete the screenshot
delete_screenshot

