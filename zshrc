# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"  # Or any other theme of your choice

 source /run/media/sj/developer/zshScript/customFunction.sh
 source /run/media/sj/developer/zshScript/alias.sh
 source /run/media/sj/developer/zshScript/enviromentVariable.sh
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

# for enabling ranger as file picker
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland
