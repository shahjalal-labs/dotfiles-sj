#!/bin/bash 

#p: copy backup files in backup dir & push to GitHub

backup_dir="/run/media/sj/developer/allDotfilesBackupEndeavourOs"
mkdir -p "$backup_dir"

# 🔄 Backup dotfiles
rsync -a --delete ~/.tmux.conf "$backup_dir/tmux.conf"
rsync -a --delete ~/.zshrc "$backup_dir/zshrc"
rsync -a --delete ~/.config/nvim/ "$backup_dir/nvim/"
rsync -a --delete /etc/keyd/ "$backup_dir/keyd/"
rsync -a --delete ~/.config/yazi/ "$backup_dir/yazi/"
rsync -a --delete ~/.config/hypr/ "$backup_dir/hypr/"
rsync -a --delete /run/media/sj/developer/zshScript/ "$backup_dir/zshScript/"
rsync -a --delete ~/.config/tmux/ "$backup_dir/tmuxModule/"
rsync -a --delete ~/.config/ranger/ "$backup_dir/ranger/"

# ✅ Use commit message from the argument
commit_msg="$1"

if [[ -z "$commit_msg" ]]; then
  tmux display-message "❌ Empty commit message. Aborting push."
  exit 1
fi

# 🚀 Git push
git -C "$backup_dir" add .
git -C "$backup_dir" commit -m "$commit_msg"
git -C "$backup_dir" push

# 🎉 Notify
tmux display-message "✅ Dotfiles pushed to GitHub!"

# 🌐 Open GitHub repo in browser
gh repo view shahjalal-labs/allDotfilesBackupEndeavourOs --web

