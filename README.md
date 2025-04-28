# dotfiles

This repository contains configuration files and scripts to set up a development environment on Linux systems, specifically tailored for Manjaro and Ubuntu distributions. It includes dotfiles, package requirements, and installation scripts for various tools and applications.

## Features
- **Dotfiles**: Configuration files for tools like `zsh`, `git`, `kitty`, `starship`, and `btop`.
- **Package Management**: Lists of required packages for both Manjaro and Ubuntu, including GUI and CLI tools.
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
   ./install.sh -i -g
   ```
   - `-i`: Install packages and set up the environment.
   - `-g`: Install GUI-related packages and configurations.
   - `-m`: Install GNOME extensions and set up keybindings
4. If 1password SSH is used for git enable it by adding following to `~/.gitconfig`
   ```bash
   [gpg "ssh"]
	   program = /opt/1Password/op-ssh-sign
   ```

## How To Test
### Test on Manjaro
1. Navigate to the `test` directory:
   ```
   cd test
   ```
2. Run the test script:
   ```
   ./test.sh
   ```

### Test on Ubuntu
1. Navigate to the `test` directory:
   ```
   cd test
   ```
2. Run the test script with the `-u` flag:
   ```
   ./test.sh -u
   ```

## Repository Structure
- `.home/`: Contains dotfiles and configuration files for various tools.
  - `.zshrc`: ZSH configuration with plugins and aliases.
  - `.gitconfig`: Git configuration with aliases and signing setup.
  - `.config/`: Configuration files for `btop`, `kitty`, and `starship`.
- `.extra/`: Lists of required packages for different distributions and package managers.
  - `req.apt`: Packages for Ubuntu.
  - `req.pacman`: Packages for Manjaro.
  - `req.gnome`: GNOME extensions.
  - `req.snap`: Snap packages.
  - `req.aur`: AUR packages for Manjaro.
- `install.sh`: Main installation script for setting up the environment.
- `install-gnome.sh`: Script to install GNOME extensions and configure keybindings.
- `install-zsh.sh`: Script to configure ZSH with plugins.
- `install-repo.sh`: Script to add third-party repositories for Ubuntu.
- `test/`: Contains scripts to test the setup in Docker containers.

## Key Scripts
- **`install.sh`**: Automates the installation of packages, GUI tools, and GNOME extensions. It also sets up ZSH and firewall rules.
- **`install-gnome.sh`**: Installs GNOME extensions and sets up keybindings for improved productivity.
- **`install-zsh.sh`**: Installs Oh My Zsh and plugins like `zaw` and `zsh-syntax-highlighting`.
- **`test.sh`**: Runs the installation scripts in a Docker container to validate the setup on Manjaro or Ubuntu.

## Customizations
- **ZSH**: Includes aliases, keybindings, and plugins for enhanced shell experience.
- **Git**: Configured with aliases, signing keys, and credential storage.
- **Kitty**: Customized terminal with the Nord theme.
- **Starship**: Configured prompt with a custom format and color palette.
- **GNOME**: Extensions and keybindings for workspace management and productivity.

## Notes
- The scripts are designed to be idempotent, meaning they can be run multiple times without causing issues.
- Some scripts require `sudo` privileges to install system-wide packages and configurations.

## License
This repository is licensed under the MIT License. See the LICENSE file for details.
