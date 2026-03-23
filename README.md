# dotfiles

This repository contains configuration files and scripts to set up a development environment on Linux systems, specifically tailored for Manjaro distribution. It includes dotfiles, package requirements, and installation scripts for various tools and applications.

## Features
- **Dotfiles**: Configuration files for tools like `zsh`, `git`, `kitty`, `starship`, and `btop`.
- **Package Management**: Lists of required packages for Manjaro, including GUI and CLI tools.
- **Automation**: Scripts to automate the installation of packages, repositories, and configurations.
- **GNOME Customization**: Scripts to install GNOME extensions and set up keybindings if needed.
- **Testing**: Docker-based testing scripts to validate the setup on different distributions.

## How To Install
1. Download the repository as a ZIP file manually or clone it using Git:
   ```
   git clone https://github.com/andreasvikke/dotfiles.git
   ```
2. Extract the ZIP file or navigate to the cloned repository.
3. Run the install script with the desired flags:
   ```
   ./install.sh -i -g -h
   ```
   - `-i`: Install packages and set up the environment.
   - `-g`: Install GUI-related packages and configurations.
   - `-h`: Install Hyperland packages and configurations.

## Repository Structure
- `.home/`: Contains dotfiles and configuration files for various tools.
  - `.zshrc`: ZSH configuration with plugins and aliases.
  - `.gitconfig`: Git configuration with aliases and signing setup.
  - `.config/`: Configuration files for `btop`, `kitty`, and `starship`.
- `.extra/`: Lists of required packages for different distributions and package managers.
  - `req.aur`: AUR packages for Manjaro.
  - `req.aur.gui`: AUR GUI packages for Manjaro.
  - `req.aur.hypr`: AUR packages for Manjaro to setup hyprland.
  - `req.pacman`: Packages for Manjaro.
  - `req.pacman.gui`: GUI packages for Manjaro.
  - `req.pacman.hypr`: Packages for Manjaro to setup hyprland.
- `install.sh`: Main installation script for setting up the environment.
- `install-zsh.sh`: Script to configure ZSH with plugins.

## Key Scripts
- **`install.sh`**: Automates the installation of packages, GUI tools, and GNOME extensions. It also sets up ZSH and firewall rules.
- **`install-zsh.sh`**: Installs Oh My Zsh and plugins like `zaw` and `zsh-syntax-highlighting`.

## Customizations
- **ZSH**: Includes aliases, keybindings, and plugins for enhanced shell experience.
- **Git**: Configured with aliases, signing keys, and credential storage.
- **Kitty**: Customized terminal with the Nord theme.
- **Starship**: Configured prompt with a custom format and color palette.

## Notes
- The scripts are designed to be idempotent, meaning they can be run multiple times without causing issues.
- Some scripts require `sudo` privileges to install system-wide packages and configurations.
