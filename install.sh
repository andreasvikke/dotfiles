while getopts i: flag
do
  case "${flag}" in
    i) install=${OPTARG};;
  esac
done

# Install packages
if [ ! -z "$install" ]; then
  sudo apt update
  sudo apt upgrade -y

  # Install apt packages
  sudo apt install -y zsh kitty build-essential git apt-transport-https ca-certificates \
    curl traceroute tig gnupg lsb-release network-manager-l2tp-gnome rofi picom pip polybar make

  # Install Docker
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --batch --yes -o /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
  sudo groupadd docker
  sudo gpasswd -a $USER docker

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
  brew install gcc tfswitch kubectx fzf helm derailed/k9s/k9s

  # Install snap packagesawscli
  sudo snap install slack

  # Install aws cli
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  rm awscliv2.zip
  rm -rf aws

  # Install gcloud cli
  curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-400.0.0-linux-x86_64.tar.gz
  tar -xf google-cloud-cli-400.0.0-linux-x86_64.tar.gz
  sudo cp -r ./google-cloud-sdk ~/bin/
  sudo bash ~/bin/google-cloud-sdk/install.sh --usage-reporting false --command-completion false --path-update false
  sudo ~/bin/google-cloud-sdk/bin/gcloud components install gke-gcloud-auth-plugin --quiet
  rm google-cloud-cli-400.0.0-linux-x86_64.tar.gz
  rm -rf google-cloud-sdk

  # Install Polybar Themes
  pip install pywal
  curl "https://raw.githubusercontent.com/firecat53/networkmanager-dmenu/main/networkmanager_dmenu" -o "networkmanager_dmenu"
  sudo mv networkmanager_dmenu /usr/local/bin/networkmanager_dmenu
  git clone --depth=1 https://github.com/adi1090x/polybar-themes.git
  cd polybar-themes
  chmod +x setup.sh
  printf "1" | sudo bash setup.sh
  cd ..
  rm -rf polybar-themes

  # Install Bspwm & Sxhkd
  git clone https://github.com/phuhl/bspwm-rounded.git
  git clone https://github.com/baskerville/sxhkd.git
  cd bspwm-rounded && make && sudo make install
  cd ../sxhkd && make && sudo make install
  cd ..
  rm -rf bspwm-rounded
  rm -rf sxhkd

  echo "Installation Complete!"
fi

# Setup dotfiles
cp .p10k.zsh ~/
cp .zshrc ~/
cp .gitconfig ~/
cp -TR ./.config ~/.config
cp -TR fonts ~/.local/share/fonts

echo "Install Script Complete!"
newgrp docker
