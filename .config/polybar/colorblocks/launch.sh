#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/colorblocks"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

dp_monitor=$(xrandr | grep ' connected' | cut -d ' ' -f1 | tail -n 1)

# Set Primary Screen to Second monitor if present
if [ $dp_monitor != "eDP-1" ]; then
    MONITOR=$dp_monitor
else
    MONITOR="eDP-1"
fi
# Insert monitor name in config.ini
sed -i "s/monitor = .*/monitor = $MONITOR/g" $DIR/config.ini

# Launch the bar
polybar -q main -c "$DIR"/config.ini &
