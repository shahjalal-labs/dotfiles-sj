alias l="nvim ~/.config/nvim/init.lua"
alias y="yazi"
alias ss="sudo systemctl restart keyd"
alias n="nvim"
alias v='nvim ~/.zshrc'

alias e='exec zsh'
alias cc="code "

#tmux related
alias t="tmux attach || tmux new"
alias tt="nvim /home/sj/.tmux.conf"
alias tl='tmux ls'
alias tn='tmux new -s '
alias ta='tmux attach -t '
alias tk='tmux kill-session -t '

# alias a="exit"

alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
# alias ,='nvim .'
alias c="/home/sj/.config/nvim"
alias p='systemctl --user restart pipewire && systemctl --user restart pipewire-pulse && systemctl --user daemon-reload'
alias gi="git_push"
alias d='nmcli device disconnect enp1s0'
# Alias to disconnect modem
alias ms="nmcli device disconnect enp0s20f0u1"

# Alias to reconnect modem
alias mc="nmcli device connect enp0s20f0u1"

alias de='nmcli device connect enp1s0'
# alias alt="setxkbmap -option altwin:meta_alt"
# alias fp="$(tmux ls | fzf | awk '{print $1}' | sed 's/://')"
# alias ff ="$(  | fzf | awk '{print $1}' | sed 's/://')"
alias -g nano="nvim "
alias gn='gh gd'
# alias cd="z"

# alias aj='/mnt/fed/web/L1B6UpdatedTo9'
# alias ak='/mnt/fed/web/L2B1'
# alias al='/mnt/fed/web/L2B4'
#
alias r='history | fzf | sed "s/^[ ]*[0-9]\+[ ]*//" | xargs -I {} bash -c "{}"'

# alias yay='paru'

alias aa="npm install gh-pages --save-dev   &&  npx gh-pages -d .  && gh repo view --web"
alias h="nvim ~/.config/hypr/hyprland.conf"
alias a="nvim /run/media/sj/developer/zshScript/alias.sh"
alias m="sudo systemctl start mongodb"
alias s="nvim /run/media/sj/developer/zshScript/.surfingkeys.js"
alias bd="bun dev"
alias ba="bun add"
alias nvl="NVIM_APPNAME=nvim-learn nvim"




