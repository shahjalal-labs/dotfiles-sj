export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="/usr/bin:$PATH"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

[[ -o interactive ]] || return #p: in ubuntu, neovim not found npm, node. So fixed by chatgpt (perhaps working, not sure)

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"  # Or any other theme of your choice

source /home/sj/dotfiles-sj/zshScript/customFunction.sh
source /home/sj/dotfiles-sj/zshScript/alias.sh
source /home/sj/dotfiles-sj/zshScript/enviromentVariable.sh

# source /mnt/fed/secret.sh


plugins=(
  git
	zsh-syntax-highlighting 
  zsh-autosuggestions
	#zsh-z
	dirhistory	
	sudo
  globalias
  zsh-completions
  fzf-tab
  # zsh-vi-mode
  # copybuffer 
  # alias-finder
)
source $ZSH/oh-my-zsh.sh
#w: make the neovim as default editor
 export EDITOR='nvim'
#w: enable zsh vi mode
bindkey -v
#w: bindkey "'" autosuggest-accept
bindkey "'" autosuggest-accept



cf() {
  $@ | fzf
}



# source ~/fzf-git.sh/fzf-git.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Created by `pipx` on 2025-06-20 12:28:10
export PATH="$PATH:/home/sj/.local/bin"

# bun completions
[ -s "/home/sj/.bun/_bun" ] && source "/home/sj/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export WAYLAND_DISPLAY=wayland-1
export PATH=~/.npm-global/bin:$PATH
export PATH=~/.npm-global/bin:$PATH

# OpenClaw Completion
[ -f "/home/sj/.openclaw/completions/openclaw.zsh" ] && source "/home/sj/.openclaw/completions/openclaw.zsh"

# >>> localcan >>>
export PATH="/home/sj/.localcan/bin:$PATH"
# <<< localcan <<<

# opencode
export PATH=/home/sj/.opencode/bin:$PATH


# Added by Antigravity CLI installer
export PATH="/home/sj/.local/bin:$PATH"

# Zoxide initialization
eval "$(zoxide init zsh)"
export GEMINI_API_KEY="AIzaSyCTuTXZB__binAROvalrqiwgScgF0jWttA"
export GTK_USE_PORTAL=1
