#!/bin/bash

# Script by https://github.com/metafates/ChromiumPywal/

wal -i ~/.config/hypr/assets/wallpaper.png --cols16 lighten --contrast 3

. ~/.cache/wal/colors.sh # import colors from pywal

THEME_NAME="Pywal"


DIR=$(dirname "${BASH_SOURCE[0]}")
THEME_DIR="$DIR/$THEME_NAME"

# Converts hex colors into rgb joined with comma
# #fff -> 255, 255, 255
hexToRgb() {
    # Remove '#' character from hex color #fff -> fff
    plain=${1#*#}
    printf "%d, %d, %d" 0x${plain:0:2} 0x${plain:2:2} 0x${plain:4:2}
}

prepare() {
    if [ -d $THEME_DIR ]; then
        rm -rf $THEME_DIR
    fi
    
    mkdir $THEME_DIR
    mkdir "$THEME_DIR/images"
}


background=$(hexToRgb $background)
foreground=$(hexToRgb $foreground)
accent=$(hexToRgb $color8)
secondary=$(hexToRgb $color8)

generate() {
    # Theme template
    cat > "$THEME_DIR/manifest.json" << EOF
    {
      "manifest_version": 3,
      "version": "1.0",
      "name": "$THEME_NAME Theme",
      "theme": {
        "colors": {
          "frame": [$accent],
          "frame_inactive": [$accent],
          "toolbar": [$background],
          "ntp_text": [$foreground],
          "ntp_link": [$accent],
          "ntp_section": [$secondary],
          "button_background": [$foreground],
          "toolbar_button_icon": [$foreground],
          "toolbar_text": [$foreground],
          "omnibox_background": [$background],
          "omnibox_text": [$foreground]
        },
        "properties": {
          "ntp_background_alignment": "bottom"
        }
      }
    }
EOF
}

prepare
generate
echo "Pywal Chrome theme generated at $THEME_DIR"
