#!/bin/bash

# Install Oh My ZSH
sudo rm -rf /home/vikke/.oh-my-zsh
0>/dev/null sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## == Plugins ==
# Install ZAW
rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zaw
git clone --depth=1 https://github.com/zsh-users/zaw.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zaw

# Install zsh-syntax-highlighting
rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install zsh-autosuggestions
rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install Powerlevel10k
rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install ata plugin
wget https://github.com/rikhuijzer/ata/releases/latest/download/ata-x86_64-unknown-linux-gnu
sudo mv ata-x86_64-unknown-linux-gnu /usr/local/bin/ata
sudo chmod +x /usr/local/bin/ata
