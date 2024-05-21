#!/bin/bash
set -e

while getopts igm flag
do
  case "${flag}" in
    i) install=true;;
    g) gui=true;;
    m) manjaro=true;;
  esac
done

# Install packages
if [ "$install" ]; then
  if [ "$manjaro" ]; then
    sudo pacman -Syyu --noconfirm git

    git clone https://github.com/aurutils/aurutils.git
    cd aurutils/makepkg
    sudo makepkg -srci --noconfirm
    cd ../..
    rm -rf aurutils
    
    sudo pacman -Syyu --noconfirm - < ./.extra/req.pacman
  else
    # Install necessary packages for repositories
    sudo apt update
    sudo apt install -y apt-transport-https curl gpg lsb-release

    sudo ./install-repo.sh

    sudo apt update
    sudo apt upgrade -y

    # Install apt packages
    sudo xargs apt install -y < ./.extra/req.apt
  fi

  # Install ZSH
  echo "Installing zsh"
  ./install-zsh.sh

  # Install Homebrew
  yes '' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  # Install Brew packages
  xargs brew install < ./.extra/req.brew

  # Install snap packages
  if [ "$gui" ]; then
    if [ "$manjaro" ]; then
      echo "Installing flatpak packages"
      while read f; do
        sudo flatpak install -y --noninteractive $f
      done < ./.extra/req.flatpak
    else
      echo "Installing snap packages"
      while read s; do
        sudo snap install $s
      done < ./.extra/req.snap
    fi

    echo "Installing gnome extensions"
    ./install-gnome.sh
  fi
  
  echo "Installation Complete!"
fi

# Setup dotfiles
cp -TR ./.home /home/vikke/

echo "Install Script Complete!"
