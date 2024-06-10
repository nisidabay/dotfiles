#    _               _
#   | |__   __ _ ___| |__  _ __ ___
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__
# (_)_.__/ \__,_|___/_| |_|_|  \___|
#
# by Stephan Raabe (2023)
# -----------------------------------------------------
# ~/.bashrc
# -----------------------------------------------------
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# -----------------------------------------------------
# PFETCH if on wm
# -----------------------------------------------------
echo ""
if [[ $(tty) == *"pts"* ]]; then
	# pfetch
	# read
	:
else
	if [ -f /bin/qtile ]; then
		echo "Start Qtile X11 with command Qtile"
	fi
	if [ -f /bin/hyprctl ]; then
		echo "Start Hyprland with command Hyprland"
	fi
fi

# Set the editor for Git
export VISUAL="nvim"

# Set NEOVIM PATH
export NEOVIM="$HOME/.config/nvim/init.lua"

# Set the rofi menu options
export RMENU="rofi -dmenu -p"

# Set the dmenu options
export DMENU="dmenu -i -l 20 -p"

# Set the default PDF viewer
export PDF_VIEWER="zathura"

# Set the default web browser
export DMBROWSER="firefox"
export BROWSER="firefox"

# Set the default terminal emulator
export TERMINAL="alacritty"

# Set the alternate terminal emulator
export ALTERNATE_TERMINAL="xfce4-terminal"

# Set the default terminal command for dmenu
export DMTERM="xfce4-terminal -e"

# Set the default editor command for dmenu
export DMEDITOR="${DMTERM} nvim"

# Set the default mail client command
export MAILCMD="neomutt"

# Set the default editor
export EDITOR="nvim"
export ALTERNATE_EDITOR="vim"

# Set the terminal colors
export TERM="xterm-256color"

# Set the LS_COLORS for directory listing
export LS_COLORS="di=34:ln=36:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# Set the history options
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTTIMEFORMAT="%F %T "
export CDPATH=$HOME:$HOME/Videos:$HOME/Music:$HOME/Desktop:$HOME:Pictures

# -----------------------------------------------------
# FZF
# -----------------------------------------------------
# Set the fzf menu options
export FMENU="fzf --border=rounded --margin=5% --color=dark --height 100% --reverse --header=$(basename "$0") --info=hidden --header-first --prompt"
# Set the default command for FZF
export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'

# Load FZF if it is installed
if [ -f ~/.fzf.bash ]; then
	# shellcheck source=/dev/null
	source ~/.fzf.bash
fi

# -----------------------------------------------------
# Set the SSH key password
# -----------------------------------------------------
export SSHPASS=Braveheart447

# -----------------------------------------------------
# PYWAL
# -----------------------------------------------------
# Apply pywal changes in new sessions
(cat ~/.cache/wal/sequences &) >/dev/null
# Export wal colors to use in scripts
source "$HOME/.cache/wal/colors.sh"

# Restore pywall settings
"$HOME"/.local/bin/wal -R >/dev/null

# -----------------------------------------------------
# Set "bat" as the man pager if available
# -----------------------------------------------------

if command -v bat &>/dev/null; then
	export MANPAGER="sh -c 'less -R | bat -l man -p'"
fi

# -----------------------------------------------------
# Set Vi Mode and key bindings
# -----------------------------------------------------
set -o vi

# -----------------------------------------------------
# Fix zsh errors when reloading bashrc
# -----------------------------------------------------
if [ -n "$BASH_VERSION" ]; then
	bind -m vi-command 'Control-l: clear-screen'
	bind -m vi-insert 'Control-l: clear-screen'
fi

# -----------------------------------------------------
# Set XDG_SESSION_TYPE for dm-note
# -----------------------------------------------------
export XDG_SESSION_TYPE="x11"

# -----------------------------------------------------
# Set the XDG directories
# -----------------------------------------------------
if [[ $(hostname) == "msi" ]]; then

	export XDG_CONFIG_HOME=~/.config
	export XDG_DOCUMENTS_DIR=/mnt/sata/Documents
	export XDG_MUSIC_DIR=/mnt/sata/Music
	export XDG_PICTURES_DIR=/mnt/sata/Pictures
	export XDG_DOWNLOAD_DIR=/mnt/sata/Downloads
	export XDG_VIDEOS_DIR=/mnt/sata/Movies
else

	export XDG_CONFIG_HOME=~/.config
	export XDG_DOCUMENTS_DIR=~/Documents
	export XDG_MUSIC_DIR=~/Music
	export XDG_PICTURES_DIR=~/Pictures
	export XDG_DOWNLOAD_DIR=~/Downloads
	export XDG_VIDEOS_DIR=~/Movies
fi

# -----------------------------------------------------
# Disable touchpad for MSI
# xinput disable 12
# -----------------------------------------------------

# -----------------------------------------------------
# Go configuration
# -----------------------------------------------------
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# -----------------------------------------------------
# START STARSHIP
# -----------------------------------------------------
#eval "$(starship init bash)"
. "$HOME/.cargo/env"

# -----------------------------------------------------
# Quotes file for fortune. A C program to show quotes
# -----------------------------------------------------
export QUOTE_FILE_PATH=/home/nisidabay/bin/fortune/Computer_Quotes.txt
#

# -----------------------------------------------------
# Quotes file for cnuggets. A C program to show nuggets
# -----------------------------------------------------
export NUGGETS_FILE_PATH=/home/nisidabay/bin/python_nuggets_univ

source /home/nisidabay/.config/broot/launcher/bash/br
