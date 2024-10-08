#!/bin/bash

GN_CMD_OUTPUT=$(gnome-shell --version)
GN_SHELL=${GN_CMD_OUTPUT:12:2}

while read i; do
    VERSION_LIST_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=${i}" | jq '.extensions[] | select(.uuid=="'${i}'")')
    VERSION_TAG="$(echo "$VERSION_LIST_TAG" | jq '.shell_version_map |."'"${GN_SHELL}"'" | ."pk"')"
    wget -O ${i}.zip "https://extensions.gnome.org/download-extension/${i}.shell-extension.zip?version_tag=$VERSION_TAG"
    gnome-extensions install --force ${i}.zip
    if ! gnome-extensions list | grep --quiet ${i}; then
        busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${i}
    fi
    gnome-extensions enable ${i}
    rm ${i}.zip
done < ./.extra/req.gnome

for i in {1..5}
do
    gsettings set "org.gnome.desktop.wm.keybindings" "switch-to-workspace-$i" "['<Alt>$i']"
    gsettings set "org.gnome.desktop.wm.keybindings" "move-to-workspace-$i" "['<Shift><Alt>$i']"
done

gsettings set "org.gnome.desktop.wm.keybindings" "close" "['<Alt>c']"
gsettings set "org.gnome.settings-daemon.plugins.media-keys" "home" "['<Super>e']"
