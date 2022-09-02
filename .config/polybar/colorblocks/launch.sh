#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/colorblocks"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Find Primary Monitor
MONITOR=$(polybar -m | grep primary | cut -d":" -f1)
# Snsert monitor name in config.ini
sed -i "s/monitor = .*/monitor = $MONITOR/" $DIR/config.ini

# Launch the bar
polybar -q main -c "$DIR"/config.ini &
