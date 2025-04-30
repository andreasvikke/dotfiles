#!/bin/bash

set -e

mode="${1:-auto}"

readarray -t monitors < <(hyprctl monitors | grep "Monitor" | awk '{print $2}')
[ ${#monitors[@]} -eq 0 ] && exit

internal=${monitors[0]}
external=${monitors[1]:-}

if [ "$mode" = "mirror" ]; then
    if [ -n "$external" ]; then
        hyprctl keyword monitor "$internal,preferred,0x0,1"
        hyprctl keyword monitor "$external,preferred,0x0,1,mirror,$internal"
    fi
else
    # auto (extended)
    if [ -n "$external" ]; then
        # Get width of external
        width=$(hyprctl monitors -j | jq -r ".[] | select(.name==\"$external\") | .width")
        width=${width:-1920}

        hyprctl keyword monitor "$external,preferred,0x0,1"
        hyprctl keyword monitor "$internal,preferred,${width}x0,1,auto"

        hyprctl dispatch moveworkspacetomonitor 1 "$external"
    else
        hyprctl keyword monitor "$internal,preferred,0x0,1"
    fi
fi
