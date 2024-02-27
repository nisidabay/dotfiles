#!/usr/bin/bash
# Author: Carlos Lacaci Moya
# Change keyboard layout with zenity
# Date: lun 11 sep 2023 05:45:00 CEST
############################################################################### 

#!/bin/bash
#
# This script allows the user to select a keyboard layout using Zenity.
#

# Declare an array of available keyboard layouts
declare -a switch_keyboard=("es" "us")
current_keyboard=$(/usr/bin/xkblayout-state print '%s')

# Display the current keyboard layout
zenity --info \
       --title="Current keyboard layout" \
       --width 500 \
       --height 100 \
       --text "Current keyboard layout: ${current_keyboard^^}"

# Show the list of available layouts and capture the selection
selection=$(zenity --list \
    --title="Select keyboard layout" \
    --column="Available layouts" \
    --width 100 \
    --height 300 \
    "${switch_keyboard[@]}" \
)

# Check the exit code to see if the user clicked "Cancel"
if [ $? -eq 1 ]; then
    zenity --info \
       --title="Operation canceled" \
       --width 500 \
       --height 100 \
       --text "Keyboard layout selection canceled."
    exit 1  # Exit the script with an error code
fi

# Set the selected keyboard layout using setxkbmap
setxkbmap -layout "$selection"

# Display a message confirming the change
zenity --info \
       --title="Keyboard changed" \
       --width 500 \
       --height 100 \
       --text "Keyboard changed to: ${selection^^}"
