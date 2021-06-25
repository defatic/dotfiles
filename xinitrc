#!/bin/bash
#
# ~/.xinitrc
#
# Below function runs files in /etc/X11/xinit/xinit.d/ catelog for startup at
# X11 boot
if test -d /etc/X11/xinit/xinitrc.d; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    test -x "${f}"  && . "${f}"
  done
fi

# loads settings from .Xresources into xterm
test -f "$HOME/.Xresources" && xrdb -merge -I"$HOME $HOME/.Xresources"
# Clipboard manager
clipmenud &
# Sets the keyboard layout to Swedish in X11
setxkbmap se
# Sets the mouse sensitivity and acceleration
xset m 1/1 4
# Speed up xrate
xset r rate 300 50
# Turn Caps Lock into ESC
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

# Set wallpaper
feh --no-fehbg --bg-fill "$HOME/Documents/wallpapers/jungle.jpg"

# Start a window manager
## dwm settings and launch
while true; do
  MEM=$(free | awk '/Mem/ {printf "%d MiB\n", $3 / 1024.0}')
  CPULOAD=$(uptime)
  KERNEL=$(uname -r)
  VOL=$(pulsemixer --get-volume)
  DATE=$(date '+%b %d %H:%M')
#   IP=$(for i in $(ip r); do echo "$i"; done | grep -A 1 src | tail -n1)
#   TEMP=$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))C

  xsetroot -name " ${MEM} / ${CPULOAD##*:} / ${KERNEL%%-*} / [${VOL#* }] ${DATE} "

  sleep 60
done &

exec "$HOME/.local/bin/dwm"
# exec "$HOME/repos/suckless/dwm/dwm" # for testing new builds
