#!/bin/bash

backup_dir="/run/media/sj/developer/allDotfilesBackupEndeavourOs"
mkdir -p "$backup_dir"

rsync -a --delete ~/.tmux.conf "$backup_dir/tmux.conf"
rsync -a --delete ~/.zshrc "$backup_dir/zshrc"
rsync -a --delete ~/.config/nvim/ "$backup_dir/nvim/"
rsync -a --delete /etc/keyd/ "$backup_dir/keyd/"
rsync -a --delete ~/.config/yazi/ "$backup_dir/yazi/"
rsync -a --delete ~/.config/hypr/ "$backup_dir/hypr/"
rsync -a --delete /run/media/sj/developer/zshScript/ "$backup_dir/zshScript/"
rsync -a --delete /home/sj/.config/tmux/ "$backup_dir/tmux/"

# Notify tmux that backup is complete
tmux display-message "🎉 Dotfiles backup done!"

