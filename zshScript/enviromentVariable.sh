#w: Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
 zstyle ':omz:update' mode auto      # update automatically without asking


 #w: for nvm node js manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

#w:make chrome browser default
export BROWSER=google-chrome-stable

