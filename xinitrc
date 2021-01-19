#!/bin/bash
#
# ~/.xinitrc
#
# Below function runs files in /etc/X11/xinit/xinit.d/ catelog for startup at
# X11 boot
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
fi

# loads settings from .Xresources into xterm
xrdb -merge ~/.Xresources

# enabels background transparency in terminals
picom &

clipmenud &                 # Clipboard manager
setxkbmap se                # sets the kayboard layout to swedish in X11
xset m 1/1 4                # sets the mouse sensitivity and acceliration
xset r rate 300 50 &        # speed up xrate
nvidia-settings --load-config-only
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' # Turn Caps Lock into ESC
# xbindkeys &

# Set background
feh --bg-fill ~/downloads/pictures/Mountains_Landscapes_Nature2.jpg

# Start a window manager
## dwm settings and launch
while true
do
   # DATE=$(date '+%b %d %H:%M:%S')
   DATE=$(date '+%b %d %H:%M')
   VOL=$(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')
   IP=$(for i in `ip r`; do echo $i; done | grep -A 1 src | tail -n1)
   TEMP=$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))C
   CPULOAD=$(uptime | sed 's/.*: //')
   MEM=$(free | awk '/Minne/ {printf "%d MiB\n", $3 / 1024.0, $2 / 1024.0}')
   #KERNEL=$(uname -r | sed 's/\([0-9]\.[0-9]\.[0-9]*\).*/\1/')
   KERNEL=$(uname -r | awk -F '-' '{ print $1 }')

  xsetroot -name " $MEM | $CPULOAD | $KERNEL | [$VOL] $DATE "

  sleep 60
done &

exec ~/bin/dwm
