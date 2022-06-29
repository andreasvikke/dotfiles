sudo apt update
sudo apt upgrade

# Install apt packages
sudo apt install -y zsh kitty build-essential git apt-transport-https ca-certificates curl traceroute tig

# Install Kubectl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# Install Oh My ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install Homebrew
yes '' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Brew packages
brew install gcc tfswitch docker kubectx fzf helm derailed/k9s/k9s

# Install snap packagesawscli
sudo snap install slack

# Install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip
rm -rf aws

# Setup dotfiles
cp .p10k.zsh ~/
cp .zshrc ~/
cp .gitconfig ~/
cp -TR kitty ~/.config/kitty
cp -TR fonts ~/.local/share/fonts