#!/bin/bash
set -e

while getopts igm flag; do
  case "${flag}" in
  i) install=true ;;
  g) gui=true ;;
  m) gnome=true ;;
  esac
done

# Install packages
distro=$(cat /etc/os-release | grep -w ID | cut -d= -f2)
if [ "$install" ]; then
  if [ "$distro" == "manjaro" ]; then
    sudo pacman-mirrors --geoip && sudo pacman -Syyu --noconfirm
    # Install necessary packages for repositories
    sudo pacman -S --needed --noconfirm - <./.extra/req.pacman
    echo "Test"
    # yay -S --needed --noconfirm - <./.extra/req.aur
  elif [ "$distro" == "ubuntu" ]; then
    # Install necessary packages for repositories
    sudo apt update
    sudo apt install -y apt-transport-https curl gpg lsb-release

    sudo ./install-repo.sh

    sudo apt update
    sudo apt upgrade -y

    # Install apt packages
    sudo xargs apt install -y <./.extra/req.apt
  else
    echo "Unsupported distro: $distro"
    exit 1
  fi

  # Install gui packages
  if [ "$gui" ]; then
    if [ "$distro" == "manjaro" ]; then
      echo "Installing GUI aur"
      sudo pacman -S --needed --noconfirm - <./.extra/req.pacman.gui
      yay -S --needed --noconfirm - <./.extra/req.aur.gui
    elif [ "$distro" == "ubuntu" ]; then
      echo "Installing snap packages"
      while read s; do
        sudo snap install $s
      done <./.extra/req.snap
    fi

    if [ "$gnome" ]; then
      echo "Installing gnome extensions and setting up gnome keybindings"
      ./install-gnome.sh

      echo "Setting GTK theme"
      GTK='GTK_THEME="Nordic"'
      if ! grep -Fxq "$GTK" /etc/environment; then
        echo "$GTK" | sudo tee -a /etc/environment
      fi
    fi
  fi
fi

# Non distro specific
if [ "$install" ]; then
  # Install ZSH
  echo "Installing zsh"
  ./install-zsh.sh

  echo "Setting up default ufw"
  sudo ufw enable
  sudo ufw default deny incoming
  sudo ufw default allow outgoing

  sudo mkdir -p /etc/docker
  echo '{"iptables":false}' | sudo tee /etc/docker/daemon.json

  echo "Installation Complete!"
fi

# Setup dotfiles
cp -TR ./.home ~/

echo "Install Script Complete!"
