#!/bin/bash

# Check if kitty is already running
if pgrep -x kitty > /dev/null; then
    # Just switch to workspace 4
    hyprctl dispatch workspace 4
else
    # Start kitty and send it to workspace 3 using workspace rules
    # Launch with a unique window title to apply a rule
    kitty --title "Terminal" &
fi
