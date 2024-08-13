#!/bin/bash
set -e

while getopts ig flag
do
  case "${flag}" in
    i) install=true;;
    g) gui=true;;
  esac
done

# Install packages
if [ "$install" ]; then
  distro=$(cat /etc/os-release | grep -w ID | cut -d= -f2)

  if [ "$distro" == "manjaro" ]; then
    # Install necessary packages for repositories   
    sudo pacman -Syyu --noconfirm - < ./.extra/req.pacman
    yay -Syyu --noconfirm - < ./.extra/req.aur

    # Install gui packages
    if [ "$gui" ]; then
      echo "Installing flatpak packages"
      while read f; do
        sudo flatpak install -y --noninteractive $f
      done < ./.extra/req.flatpak

      echo "Installing gnome extensions and setting up gnome keybindings"
      ./install-gnome.sh

      echo "Setting GTK theme"
      GTK='GTK_THEME="Nordic"'
      if ! grep -Fxq "$GTK" /etc/environment; then
        echo "$GTK" | sudo tee -a /etc/environment
      fi
    fi
  elif [ "$distro" == "ubuntu" ]; then
    # Install necessary packages for repositories
    sudo apt update
    sudo apt install -y apt-transport-https curl gpg lsb-release

    sudo ./install-repo.sh

    sudo apt update
    sudo apt upgrade -y

    # Install apt packages
    sudo xargs apt install -y < ./.extra/req.apt

    # Install gui packages
    if [ "$gui" ]; then
      echo "Installing snap packages"
      while read s; do
        sudo snap install $s
      done < ./.extra/req.snap

      echo "Installing gnome extensions and setting up gnome keybindings"
      ./install-gnome.sh
    fi
  else
    echo "Unsupported distro: $distro"
    exit 1
  fi

  # Install ZSH
  echo "Installing zsh"
  ./install-zsh.sh

  # Install Homebrew
  yes '' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  # Install Brew packages
  xargs brew install < ./.extra/req.brew
  
  echo "Installation Complete!"
fi

# Setup dotfiles
cp -TR ./.home ~/

echo "Install Script Complete!"
