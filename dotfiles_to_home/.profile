#!/bin/bash

# Source .bashrc or .zshrc
if [ -n "$BASH_VERSION" ]; then
    [[ -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"
else
    [[ -f "$HOME/.zshrc" ]] && . "$HOME/.zshrc"
fi

# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$PATH:$HOME/.local/bin"
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$PATH:$HOME/bin"
fi

if [ -d "$HOME/bin/dmenu" ] ; then
    PATH="$PATH:$HOME/bin/dmenu"
fi

if [ -d "$HOME/Applications" ] ; then 
    PATH="$PATH:$HOME/Applications"
fi

# Set American keyboard layout if Xwayland is not running
if ! pgrep Xwayland; then
    setxkbmap -layout us
fi
# Restore pywal settings
wal -R

# Apply transparency
picom &

# Load cargo environment
. "$HOME/.cargo/env"

# Source .xinitrc to start dwm and other components
    if [ -f "$HOME/.xinitrc" ]; then
        . "$HOME/.xinitrc"
    fi

