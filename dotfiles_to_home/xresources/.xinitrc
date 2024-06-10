# Executed by startx (run your window manager from here)
                                                     

 #_ __  __            
#(_)  \/  | __ _  ___ 
#| | |\/| |/ _` |/ __|
#| | |  | | (_| | (__ 
#|_|_|  |_|\__,_|\___|
                     

xhost +local:

# Set the path to user-specific X resources
userresources="$HOME/.Xresources"

# Set the path to user-specific Xmodmap
usermodmap="$HOME/.Xmodmap"

# Set the path to system X resources
sysresources="/etc/X11/xinit/.Xresources"

# Set the path to system Xmodmap
sysmodmap="/etc/X11/xinit/.Xmodmap"

# Merge system X resources if the file exists
if [ -f "$sysresources" ]; then
    xrdb -merge "$sysresources"
fi

# Load system Xmodmap if the file exists
if [ -f "$sysmodmap" ]; then
    xmodmap "$sysmodmap"
fi

# Merge user X resources if the file exists
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# Load user Xmodmap if the file exists
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi


# Prevent wayland to block the notification daemon dunst
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$UID/bus"
systemctl --user stop mako
export XDG_SESSION_TYPE="x11"
# Start the dunst notification daemon
dunst &

# Start the clipmenu daemon
clipmenud &

# Apply transparency
# xcompmgr -c -C -ts -l -s -r4.2 -o.55 &

# Start dwmblocks
dwmblocks &

# Start dwm as the window manager and keep restarting it
# if it crashes or exits
while true; do
     exec dwm > /dev/null 2>&1
done
                 
