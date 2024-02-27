#!/usr/bin/bash
#
# Change the theme of i3

# Check for required commands
command -v fzf >/dev/null || { echo "fzf is not installed"; exit 1; }
command -v bat >/dev/null || { echo "bat is not installed"; exit 1; }
command -v notify-send >/dev/null || { echo "notify-send is not installed"; exit 1; }

THEMES_PATH="$HOME/.config/i3/themes"
THEME_CONFIG="$HOME/.config/i3/theme.conf"
ICON="/home/$USER/.config/i3/scripts/resources/theme.png"

# Use fzf to choose a theme, with preview using bat
 choose_theme=$(find "$THEMES_PATH" -type f | fzf --header-first --header="Choose theme: " --preview 'bat --style=numbers --color=always {}')

# Check if the chosen theme file exists and then copy it to the theme config
if [ -e "$choose_theme" ]; then
    if cp "$choose_theme" "$THEME_CONFIG"; then
        theme_name=$(basename "$choose_theme")
        notify-send -i "$ICON" "i3 theme" "Theme changed to $theme_name" 
    else
        echo "Failed to apply theme."
    fi
else
    echo "Theme does not exist."
fi

