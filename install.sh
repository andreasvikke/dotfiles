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
  # Install necessary packages for repositories
  sudo apt update
  sudo apt install -y apt-transport-https curl gpg lsb-release

  sudo ./install-repo.sh

  sudo apt update
  sudo apt upgrade -y

  # Install apt packages
  sudo xargs apt install -y < ./.extra/req.apt

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
    echo "Installing snap packages"
    while read s; do
      sudo snap install $s
    done < ./.extra/req.snap

    echo "Installing gnome extensions"
    ./install-gnome.sh
  fi

  # Install Kubescape
  kubectl krew install kubescape
  
  echo "Installation Complete!"
fi

# Setup dotfiles
cp -TR ./.home /home/vikke/
sudo cp -TR ./.extra/common-auth /etc/pam.d/common-auth

# # Setup docker groups
# sudo getent group docker || sudo groupadd docker 
# sudo gpasswd -a $USER docker

# setup ubuntu
# if [ "$gui" ]; then
#   dconf load / < .extra/.dconf
# fi

echo "Install Script Complete!"
