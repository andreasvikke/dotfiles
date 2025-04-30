#!/bin/bash

# Get all connected monitors
readarray -t monitors < <(hyprctl monitors | grep "Monitor" | awk '{print $2}')

# Bail if nothing is connected
[ ${#monitors[@]} -eq 0 ] && exit

# Assume the first is always internal (e.g., eDP-1)
internal=${monitors[0]}

# Use the second (if present) as external
if [ ${#monitors[@]} -gt 1 ]; then
    external=${monitors[1]}

    # Get width of external monitor
    width=$(hyprctl monitors -j | jq -r ".[] | select(.name==\"$external\") | .width")

    # If no width found, fallback to 1920
    width=${width:-1920}

    # Set external on the left
    hyprctl keyword monitor "$external,preferred,0x0,1"

    # Internal to the right of external
    hyprctl keyword monitor "$internal,preferred,${width}x0,1"

    # Move workspace 1 to external
    hyprctl dispatch moveworkspacetomonitor 1 "$external"
else
    # Only internal screen
    hyprctl keyword monitor "$internal,preferred,0x0,1"
fi