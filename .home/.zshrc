# =========================================
# === Enable plugins and init oh-my-zsh ===
# =========================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(git zaw zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# =================
# === Key Binds ===
# =================
# CTRL-R will pull up zaw-history (backwards zsh history search)
bindkey '^r' zaw-history
# CTRL-B will pull up zaw-git-branches which will search your current git branches and switch (git checkout) to the branch you select when you hit enter.
bindkey '^b' zaw-git-branches

# =======================
# === Load Alias File ===
# =======================
if [ -f ~/.aliasrc ]; then
  source ~/.aliasrc
fi

# ==================
# === Setup PATH ===
# ==================
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/bin/google-cloud-sdk/bin"
export PATH="$PATH:${KREW_ROOT:-$HOME/.krew}/bin"

# ===================================
# === Setup Application specifics ===
# ===================================
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"     # 1password ssh agent
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" # homebrew
export EDITOR=/usr/bin/vim                             # default editor
eval "$(direnv hook zsh)"                              # direnv hook

export USE_GKE_GCLOUD_AUTH_PLUGIN=True
if [ -f "$HOME/bin/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/bin/google-cloud-sdk/path.zsh.inc"; fi             # Updates PATH for the Google Cloud SDK.
if [ -f "$HOME/bin/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/bin/google-cloud-sdk/completion.zsh.inc"; fi # Enables shell command completion for gcloud.
