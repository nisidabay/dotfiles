#!/usr/bin/bash

# if running bash
if [ -n "$BASH_VERSION" ]; then
    [[ -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"
else
    [[ -f "$HOME/.zshrc" ]] && . "$HOME/.zshrc"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH=$PATH:"$HOME/.local/bin"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH=$PATH:"$HOME/bin"
fi

# set PATH so it includes user's private bin/dmenu if it exists
if [ -d "$HOME/bin/dmenu" ] ; then
    PATH=$PATH:"$HOME/bin/dmenu"
fi


# set PATH so it includes user's private Applications if it exists
if [ -d "$HOME/Applications" ] ; then 
      PATH=$PATH:"$HOME/Applications"
fi
#
if ! pgrep Xwayland; then
    # Set american keyboard layout
    setxkbmap -layout us
fi

# Restore pywall settings
wal -R

# Apply transparency
picom &
#~/bin/start_xcompmgr.sh
