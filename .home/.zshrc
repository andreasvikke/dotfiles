# =========================================
# === Enable plugins and init oh-my-zsh ===
# =========================================
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
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

# =======================
# === Load Extra File ===
# =======================
if [ -f ~/.extrarc ]; then
  source ~/.extrarc
fi

# ==================
# === Setup PATH ===
# ==================
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:${KREW_ROOT:-$HOME/.krew}/bin"

# ===================================
# === Setup Application specifics ===
# ===================================
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"     # 1password ssh agent
export EDITOR=/usr/bin/nvim                            # default editor
export KUBECONFIG=./.kube/config                       # default kube config to current folder
eval "$(direnv hook zsh)"                              # direnv hook
eval "$(starship init zsh)"
