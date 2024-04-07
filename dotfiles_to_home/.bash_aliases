# -----------------------------------------------------
# Aliases Section
# -----------------------------------------------------

# Aliases for mac
if [[ $(uname -s) == "Darwin" ]]; then
	alias alacritty="~/bin/alacritty.sh"
	alias cat="/opt/local/bin/bat"
	alias ls="/opt/local/bin/lsd"
elif [[ $(uname -s) == "Linux" ]]; then
	alias cat="/usr/bin/bat"
	alias ls="/usr/bin/lsd"
fi
if [[ $(hostname) == "msi" ]]; then

	# Move to preferred folders
	alias des="echo --- Downloads;cd /mnt/Downloads"
	alias down="echo --- Downloads;cd /mnt/Downloads"
	alias doc="echo --- Documents;cd /mnt/Documents"
	alias mov="echo --- Movies;cd /mnt/Movies"
	alias mus="echo --- Music;cd /mnt/Music"
	alias pic="echo --- Pictures;cd /mnt/Pictures"
	alias ref="echo --- Refactor;cd /mnt/Downloads/Refactor"
else
	# Move to preferred folders
	alias des="echo --- Downloads;cd ~/Downloads"
	alias down="echo --- Downloads;cd ~/Downloads"
	alias doc="echo --- Documents;cd ~/Documents"
	alias mov="echo --- Movies;cd ~/Movies"
	alias mus="echo --- Music;cd ~/Music"
	alias pic="echo --- Pictures;cd ~/Pictures"
	alias ref="echo --- Refactor;cd ~/Downloads/Refactor"
fi

alias sudo='sudo '
alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -l"
alias la="ls -latr"
alias ~="cd ~"
alias bin="echo --- bin;cd ~/bin"

# Virtural Environments
alias ve="echo --- virtual env; source ~/bin/venv_toogle.sh"

# Valgrind
alias vg="echo --- valgrind; valgrind --leack-check=full --show-leak-kinds=all main"

# Chezmoi
alias cza="echo --- chezmoi add;chezmoi add"
alias czap="echo --- chezmoi apply;chezmoi -v apply"
alias czd="echo --- chezmoi diff;chezmoi diff -v"
alias czu="echo --- chezmoi update;chezmoi update"

# Git
alias gaa="echo --- git add;git add -A"
alias gb="echo --- git branch;git branch"
alias gbr="echo --- git branch --remote;git branch --remote"
alias gc="echo --- git commit;commit_each"
alias gca="echo --- git commit --amend;git add --all && git commit --amend --no-edit"
alias gco="echo --- git checkout;git checkout"
alias gec="echo --- git edit configuration;git config --global -e"
alias gd='echo --- git diff;pretty_diff'
alias gds='echo --- git diff staged status;git diff --staged --name-status'
alias gf="echo --- git fetch;git fetch --all -p"
alias gl="echo --- git log;git log --oneline --graph --all"
alias gls="echo --- git ls-files;git ls-files"
alias gpc="echo --- git log;preview_changes"
alias gpl="echo --- git pull;git pull --rebase --autostash"
alias gps="echo --- git push;git push"
alias gpsf="echo --- git push force-with-lease;git push --force-with-lease"
alias grc="echo --- repo compact; git gc"
alias grf="echo --- repo fix; git fsck ."
alias grk="echo --- git prune -n; git prune -n"
alias grs="echo --- repo size; du -shc .git"
alias grp="echo --- git prune; git prune "
alias gs="echo --- git switch;git switch"
alias gss="echo --- git stash save;git stash save -m 'work in progress'"
alias gsl="echo --- git stash list;git stash list"
alias gst="echo --- git status;git status"
alias remote-info='git for-each-ref --sort=authordate --format="%(color:cyan)%(authordate:format:%m/%d/%Y %I:%M %p)%(align:25,left)%(color:yellow) %(authorname)%(end)%(color:reset)%(refname:strip=3)" refs/remotes'
alias wta="echo --- worktree add;git worktree add"
alias wtl="echo --- worktree list;git worktree list"
alias wtr="echo --- worktree remove;git worktree remove"

# Utils
alias k="echo --- kill;kill -9"
alias sh='echo ---take snapshot;grim -g "$(slurp)" - | wl-copy'

# Emacs
alias e="echo --- emacs client;emacsclient -c -a 'emacs' &"
alias ed="echo --- emacs daemon;/usr/bin/emacs --daemon &"

# IP address
alias myip="ip addr | awk '/192/ {print "$1"}' | cut -d' ' -f6 | cut -d'/' -f1"

# Neovim dir
alias nvdir="echo --- neovim dir;cd ~/.config/nvim"

# Network interface down
alias netdown="echo --- eth0 down;sudo ip link set dev enp3s0 down"

# Network interface up
alias netup="echo --- eth0 down;sudo ip link set dev enp3s0 up"

# Show interfaces
alias netshow="echo --- show net intefaces;ip link show"

# Wifi interface down
alias wifidown="echo --- wifidown;sudo ip link set dev wlp2s0 down"

# Wifi interface up
alias wifiup="echo --- wifiup;sudo ip link set dev wlp2s0 up"

# Refresh .bashrc
alias refresh='echo --- refresh .bashrc;source ~/.bashrc'

# Refresh .zshrc
alias zs='echo --- refresh .zshrc;source ~/.zshrc && echo ".zshrc refreshed!"'

# restart sshd
alias rs="echo --- restart sshd;sudo systemctl restart sshd.service"

# valgrind with specific options
alias valgrind='sudo -E DEBUGINFOD_URLS="https://debuginfod.archlinux.org" G_SLICE=always-malloc valgrind --leak-check=full ./main'

# grep output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# Disk usage with human-readable sizes
alias df='df -h'

# Memory usage
alias free='free -m'

# Process viewer
alias psa="ps auxf"
alias pscpu='ps auxf | sort -nr -k 3'
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'

# Get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Download media from YouTube with different audio formats
alias yta-aac="yt-dlp --extract-audio --audio-format aac"
alias yta-best="yt-dlp --extract-audio --audio-format best --embed-thumbnail --add-metadata"
alias yta-flac="yt-dlp --extract-audio --audio-format flac"
alias yta-m4a="yt-dlp --extract-audio --audio-format m4a"
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3"
alias yta-opus="yt-dlp --extract-audio --audio-format opus"
alias yta-vorbis="yt-dlp --extract-audio --audio-format vorbis"
alias yta-wav="yt-dlp --extract-audio --audio-format wav"
alias ytv-best="yt-dlp -f bestvideo+bestaudio"

# -----------------------------------------------------
# Aliases from ML4WK
# -----------------------------------------------------
alias c='clear'
alias nf='neofetch'
alias pf='pfetch'
alias shutdown='systemctl poweroff'
alias matrix='cmatrix'
alias wifi='nmtui'
alias rw='~/dotfiles/waybar/reload.sh'
alias winclass="xprop | grep 'CLASS'"
alias dot="cd ~/dotfiles"
alias cleanup='~/dotfiles/scripts/cleanup.sh'
alias ml4w='~/dotfiles/apps/ML4W_Welcome-x86_64.AppImage'

# -----------------------------------------------------
# Window Managers
# -----------------------------------------------------

alias Qtile='startx'
# Hyprland with Hyprland

# -----------------------------------------------------
# SCRIPTS
# -----------------------------------------------------

alias ascii='~/dotfiles/scripts/figlet.sh'

# -----------------------------------------------------
# EDIT NOTES
# -----------------------------------------------------

alias notes='$EDITOR ~/notes.txt'

# -----------------------------------------------------
# SYSTEM
# -----------------------------------------------------

alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias setkb='setxkbmap es;echo "Keyboard set back to es."'
alias update-system='sudo ~/dotfiles/scripts/installupdates.sh'
alias unlock-packman='~/dotfiles/scripts/unlock-pacman.sh'

# -----------------------------------------------------
# SCREEN RESOLUTIONS
# -----------------------------------------------------

# Qtile
alias res1='xrandr --output DisplayPort-0 --mode 2560x1440 --rate 120'
alias res2='xrandr --output DisplayPort-0 --mode 1920x1080 --rate 120'

# -----------------------------------------------------
# Functions Section
# -----------------------------------------------------

# -----------------------------------------------------
# Function to display reminders
# -----------------------------------------------------
function remind() {
	local SOUND=$HOME/bin/Bell.mp3
	local COUNT="$#"
	local COMMAND="$1"
	local MESSAGE="$1"
	local OP="$2"
	shift 2
	local WHEN="$@"
	# Display help if no parameters or help command
	if [[ $COUNT -eq 0 || "$COMMAND" == "help" || "$COMMAND" == "--help" || "$COMMAND" == "-h" ]]; then
		echo "COMMAND"
		echo "    remind <message> <time>"
		echo "    remind <command>"
		echo
		echo "DESCRIPTION"
		echo "    Displays notification at specified time"
		echo
		echo "EXAMPLES"
		echo '    remind "Hi there" now'
		echo '    remind "Time to wake up" in 5 minutes'
		echo '    remind "Dinner" in 1 hour'
		echo '    remind "Take a break" at noon'
		echo '    remind "Are you ready?" at 13:00'
		echo '    remind list'
		echo '    remind clear'
		echo '    remind help'
		echo
		return
	fi
	# Check presence of AT command
	if ! which at >/dev/null; then
		echo "remind: AT utility is required but not installed on your system. Install it with your package manager of choice, for example 'sudo apt install at'."
		return
	fi
	# Run commands: list, clear
	if [[ $COUNT -eq 1 ]]; then
		if [[ "$COMMAND" == "list" ]]; then
			at -l
		elif [[ "$COMMAND" == "clear" ]]; then
			at -r $(atq | cut -f1)
		else
			echo "remind: unknown command $COMMAND. Type 'remind' without any parameters to see syntax."
		fi
		return
	fi
	# Determine time of notification
	if [[ "$OP" == "in" ]]; then
		local TIME="now + $WHEN"
	elif [[ "$OP" == "at" ]]; then
		local TIME="$WHEN"
	elif [[ "$OP" == "now" ]]; then
		local TIME="now"
	else
		echo "remind: invalid time operator $OP"
		return
	fi

	# Schedule the notification with sound
	notify-send "Reminder scheduled at $TIME"
	echo "/usr/bin/paplay '$SOUND' && notify-send '$MESSAGE'" | at "$TIME"
	# # Schedule the notification
	# notify-send "Reminder scheduled at $TIME"
	# echo "notify-send '$MESSAGE'" | at "$TIME" && /usr/bin/paplay "$SOUND"
}
if [ -n "$BASH_VERSION" ]; then
	export -f remind
fi

# -----------------------------------------------------
# Function for archive extraction
# -----------------------------------------------------
function ex() {
	if [ -f "$1" ]; then
		case $1 in
		*.tar.bz2) tar xjf "$1" ;;
		*.tar.gz) tar xzf "$1" ;;
		*.bz2) bunzip2 "$1" ;;
		*.rar) unrar x "$1" ;;
		*.gz) gunzip "$1" ;;
		*.tar) tar xf "$1" ;;
		*.tbz2) tar xjf "$1" ;;
		*.tgz) tar xzf "$1" ;;
		*.zip) unzip "$1" ;;
		*.Z) uncompress "$1" ;;
		*.7z) 7z x "$1" ;;
		*.deb) ar x "$1" ;;
		*.tar.xz) tar xf "$1" ;;
		*.tar.zst) unzstd "$1" ;;
		*) echo "'$1' cannot be extracted via ex()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

if [ -n "$BASH_VERSION" ]; then
	export -f ex
fi

# -----------------------------------------------------
# Function to search files with fzf and edit with Vim
# -----------------------------------------------------
function sf() {
	# Save current directory
	current_directory=$(pwd)
	local oldIFS="$IFS"

	# Use 'fd' and 'fzf' to select a file in $HOME
	files=$(fd . --hidden --exclude .git --full-path "$HOME" 2>/dev/null | fzf --preview 'bat --color=always --style=plain --line-range=:100 {}' --ansi --reverse)

	IFS="$oldIFS"

	if [[ -n "$files" ]]; then
		# Edit each selected file with Vim
		for file in $files; do
			vim "$file"
		done
	fi

	# Restore original directory
	cd "$current_directory" || return

}
if [ -n "$BASH_VERSION" ]; then
	export -f sf
fi

# -----------------------------------------------------
# Function to search diary files in vimwiki
# -----------------------------------------------------
function wi() {
	# Store the current directory and change to the diary location.
	pushd $(pwd) >/dev/null
	cd ~/vimwiki/diary || exit

	# Store the result of the 'ag' command in the 'file' variable using 'fzf' for interactive selection.
	local file
	local oldIFS="$IFS"
	IFS=$'\n'

	# Prompt user to enter a search term.
	read -r -p "Enter the word to search for in the diary: " word

	# Use 'rg' to search for the word and 'cut' to extract filenames, then 'fzf' for interactive selection.
	file=$(rg --files-with-matches "$word" ~/vimwiki/diary | fzf --ansi --preview 'bat --color=always --style=plain --line-range=:100 {}' --reverse)

	IFS="$oldIFS"

	# If a file is selected, open it in Vim.
	if [[ -n "$file" ]]; then
		vim "$file"
	fi

	# Return to the original directory.
	popd >/dev/null || exit
}
if [ -n "$BASH_VERSION" ]; then
	export -f wi
fi

# -----------------------------------------------------
# Function to search inside vimwiki files
# -----------------------------------------------------
function ws() {
	pushd "$(pwd)" || exit
	cd ~/vimwiki || exit

	# Store the result of the 'ag' command in the 'file' variable using 'fzf' for interactive selection.
	local file
	local oldIFS="$IFS"
	IFS=$'\n'

	# Use 'rg' to search for the word and 'cut' to extract filenames, then 'fzf' for interactive selection.
	file=$(rg --files ~/vimwiki/ | fzf --header="Type to search" --ansi --preview 'bat --color=always --style=plain --line-range=:100 {}' --reverse)

	IFS="$oldIFS"

	# If a file is selected, open it in Vim.
	if [[ -n "$file" ]]; then
		vim "$file"
	fi

	# Return to the original directory.
	popd >/dev/null || exit
}
if [ -n "$BASH_VERSION" ]; then
	export -f ws
fi

# -----------------------------------------------------
# Function to run the selected command from history
# -----------------------------------------------------
function hs() {
	selected=$(fc -rln 1 | fzf --header="History search")
	if [[ -n "$selected" ]]; then
		command=$(echo "$selected" | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]*[0-9-]+[[:space:]]*[0-9:]+//')
		history -s "!$command"
		eval "$command"
	fi
}
if [ -n "$BASH_VERSION" ]; then
	export -f hs
fi

# -----------------------------------------------------
# Function to open vimwiki
# -----------------------------------------------------
function ww() {
	# Store the current directory and change to the diary location.
	pushd "$(pwd)" >/dev/null || exit
	cd "$HOME/vimwiki/" || exit

	vim index.md

	# Return to the original directory.
	popd >/dev/null || exit
}
if [ -n "$BASH_VERSION" ]; then
	export -f ww
fi

# -----------------------------------------------------
# Function to select directory to move into
# -----------------------------------------------------
function cdc() {
	home_dir="$HOME"
	working_dir=$(pwd)

	# Change to home directory if the current working directory is not home
	if [ "$home_dir" != "$working_dir" ]; then
		cd "$home_dir" || exit
	fi

	# Display directory to change to, starting from the home directory
	change_to=$(ls -ad ~ */ | fzf --header="Choose directory to move into")
	cd "$change_to" || exit
}

if [ -n "$BASH_VERSION" ]; then
	export -f cdc
fi

# -----------------------------------------------------
# Function to preview changes in Git
# -----------------------------------------------------
function preview_changes() {

	# Check if git-delta is installed
	if ! command -v delta &>/dev/null; then
		echo "git-delta is not installed. Attempting to install it using yay..."
		if ! yay -S git-delta --noconfirm; then
			echo "Failed to install git-delta. Please install it manually."
			return 1
		fi
	fi

	local file=$(git -c color.status=always status --short |
		fzf --height 100% --ansi \
			--preview '(git diff HEAD --color=always -- {-1} | sed 1,4d | delta --hunk-header-style=omit)' \
			--preview-window right:65% |
		cut -c4- |
		sed 's/.* -> //' |
		tr -d '\n')

	if [[ -n "$file" ]]; then
		vim "$file"
	else
		echo "No file selected or found."
	fi
}

if [ -n "$BASH_VERSION" ]; then
	export -f preview_changes
fi

function pretty_diff() {
	# Check if git-delta is installed
	if ! command -v delta &>/dev/null; then
		echo "git-delta is not installed. Attempting to install it using yay..."
		if ! yay -S git-delta --noconfirm; then
			echo "Failed to install git-delta. Please install it manually."
			return 1
		fi
	fi

	# Use fzf to select a file from the Git repository and preview changes with delta
	local file=$(git -c color.status=always status --short |
		fzf --height 100% --ansi \
			--preview '(git diff HEAD --color=always -- {-1} | sed 1,4d | delta --hunk-header-style=omit)' \
			--preview-window right:65% |
		cut -c4- |
		sed 's/.* -> //' |
		tr -d '\n')

	# Check if a file was selected
	if [[ -n "$file" ]]; then
		vim "$file"
	else
		echo "No file selected or found."
	fi
}

if [ -n "$BASH_VERSION" ]; then
	export -f pretty_diff
fi

function commit_each() {
	# Check if there are files to commit
	if [ "$(git diff --cached --name-only | wc -l)" -eq 0 ]; then
		echo "No files to commit."
		return 0
	fi

	# Loop through each file that is staged for commit
	for file in $(git diff --cached --name-only); do
		_status=$(git diff --cached --name-status "$file")
		echo -e "Committing: ${file} with status: $_status"
		sleep 2

		# Create a temporary file for the commit message
		TMPFILE=$(mktemp)

		# Open the TMPFILE in Vim and insert the file name at the top
		${EDITOR:-vim} +"normal iCommitting: $file" "$TMPFILE"
		commit_msg=$(cat "${TMPFILE}")
		echo "$commit_msg"
		sleep 2

		# Commit the file with the user's message
		git commit -m "$commit_msg" "$file"
		rm -f "$TMPFILE" >/dev/null

	done

	if [ "$(git diff --cached --name-only | wc -l)" -eq 0 ]; then
		echo "All files committed."
	fi
}

if [ -n "$BASH_VERSION" ]; then
	export -f commit_each
fi

function _mkdir() {
    # Create a directory

	USAGE="Usage: makedir 'dirname' [octal:permission]"
	local d="$1"
	local p=${2:-0755}

	[ $# -eq 0 ] && {
		echo $USAGE
		exit 1
	}

	[ ! -d "$d" ] && mkdir -v -m "$p" -p "$d"

}

if [ -n "$BASH_VERSION" ]; then
	export -f _mkdir
fi

function sr() {
    # Show resources at ~/bin/python_nuggets_univ/resources 
    pushd "$(pwd)" || exit
    cd ~/bin/python_nuggets_univ/resources || exit

    local file
    local oldIFS="$IFS"
    IFS=$'\n'

    # Use 'rg' to list files, filtering for PDF and image files, then 'fzf' for interactive selection.
    file=$(rg --files . | grep -Ei '\.(pdf|jpg|jpeg|png|gif)$' | fzf --header="Type to search for PDFs/Images" --ansi --preview '
    case {} in
        *.pdf|*.jpg|*.jpeg|*.png|*.gif) echo "Preview not available for graphical files." ;;
        *) echo "File type not supported for preview." ;;
    esac
    ' --preview-window=right:70%:wrap --reverse)

    IFS="$oldIFS"

    # Determine how to open the file based on its extension.
    if [[ -n "$file" ]]; then
        case "$file" in
            *.pdf)
                zathura "$file" >/dev/null 2>&1 &
                ;;
            *.jpg|*.jpeg|*.png|*.gif)
                sxiv "$file" >/dev/null 2>&1 &
                ;;
            *)
                echo "File type not supported for viewing."
                ;;
        esac
    fi

    popd >/dev/null || exit
}

if [ -n "$BASH_VERSION" ]; then
    export -f sr
fi

