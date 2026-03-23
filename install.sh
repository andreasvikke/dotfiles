#!/bin/bash
set -e

while getopts igmhp flag; do
  case "${flag}" in
  i) install=true ;;     # Install CLI applications
  g) gui=true ;;         # Install GUI applications
  h) hyprland=true ;;    # Install hyprland as window manage
  p) onepassword=true ;; # Remove 1Password as SSH Agent
  esac
done

# Install packages
distro=$(cat /etc/os-release | grep -w ID_LIKE | cut -d= -f2)
if [ "$distro" == "arch" ]; then
  # Install cli packages
  if [ "$install" ]; then
    echo "Installing CLI packages"
    sudo pacman-mirrors -c Denmark
    sudo pacman -Syyu --noconfirm

    sudo pacman -S --needed --noconfirm - <./.extra/req.pacman
    yay -S --needed --noconfirm - <./.extra/req.aur

    yay -Syyu --noconfirm
  fi

  # Install gui packages
  if [ "$gui" ]; then
    echo "Installing GUI packages"
    sudo pacman -S --needed --noconfirm - <./.extra/req.pacman.gui
    yay -S --needed --noconfirm - <./.extra/req.aur.gui
  fi

  # Install hyprland
  if [ "$hyprland" ]; then
    echo "Installing Hyperland and dependencies"
    sudo pacman -S --needed --noconfirm - <./.extra/req.pacman.hypr
    yay -S --needed --noconfirm - <./.extra/req.aur.hypr

    # Setup PAM hook (login + SDDM)"
    sudo sed -i \
      '/^auth[[:space:]]\+include[[:space:]]\+system-auth/ a auth       optional   pam_gnome_keyring.so' \
      /etc/pam.d/system-login

    sudo sed -i \
      '/^session[[:space:]]\+include[[:space:]]\+system-auth/ a session    optional   pam_gnome_keyring.so auto_start' \
      /etc/pam.d/system-login
  fi
else
  echo "Unsupported distro: $distro"
  exit 1
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

  echo "Installation Complete!"
fi

# Setup dotfiles
cp -TR ./.home ~/

# Remove 1password agent from services if disabled
if [ "$onepassword" ]; then
  sed -i '/^\[gpg "ssh"\]$/,+1d' ~/.gitconfig
  sed -i '/^export SSH_AUTH_SOCK/d' ~/.zshrc
fi

echo "Install Script Complete!"
