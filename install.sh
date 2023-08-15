#!/bin/bash

while getopts icg flag
do
  case "${flag}" in
    i) install=true;;
    c) cli=true;;
    g) gui=true;;
  esac
done

# Install packages
if [ ! -z "$install" ]; then
  # Install necessary packages for repositories
  sudo apt update
  sudo apt install -y apt-transport-https curl gpg lsb-release

  sudo ./install-repo.sh

  sudo apt update
  sudo apt upgrade -y

  # Install apt packages
  sudo xargs apt install -y < ./.extra/req.apt

  # Install Oh My ZSH
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  ## Install Powerlevel10k
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

  # Install Homebrew
  yes '' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Install Brew packages
  xargs brew install < ./.extra/req.brew

  # # Install snap packages
  if [ ! -z "$gui" ]; then
  echo "Installing snap packages"
    while read s; do
      snap install $s
    done < ./.extra/req.snap
  fi

  if [ ! -z "$cli" ]; then
    ./install-cli.sh
  fi

  echo "Installation Complete!"
fi

# Setup dotfiles
cp -TR ./.home /home/vikke/
cp -TR ./.config /home/vikke/.config

# Setup docker groups
groupadd docker
gpasswd -a $USER docker

# setup ubuntu
dconf load / < .extra/.dconf

echo "Install Script Complete!"
