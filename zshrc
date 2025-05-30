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
plugins=(git
	 zsh-syntax-highlighting 
  zsh-autosuggestions
  # zsh-syntax-highlighting 
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



source ~/fzf-git.sh/fzf-git.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# for yazi file picker
export XDG_DESKTOP_PORTAL_FILE_CHOOSER="$HOME/.config/xdg-portal-filechooser/yazi-wrapper.sh"

export GTK_FILE_CHOOSER_SCRIPT=~/.local/bin/yazi-picker.sh

# bun completions
[ -s "/home/sj/.bun/_bun" ] && source "/home/sj/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# make firefox default
export BROWSER=firefox


# Created by `pipx` on 2025-03-01 13:00:48
export PATH="$PATH:/home/sj/.local/bin"
