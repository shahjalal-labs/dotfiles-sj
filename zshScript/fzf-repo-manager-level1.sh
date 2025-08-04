
 # fzf-based GitHub repo manager
# full copy with commit history and all branches
  # gh repo list ProgrammingHero1  --json name --jq '.[].name' --limit 2200 | \
  # fzf --prompt="Select a repo: " --height=80% \
  #     --preview="gh repo view ProgrammingHero1/{}" --preview-window=right:60% \
  #     --bind "enter:execute-silent(echo -n {} | xclip -selection clipboard)" \
  #     --bind "ctrl-o:execute(gh repo view ProgrammingHero1/{} --web)" \
  #     --bind "ctrl-r:execute(git clone https://github.com/ProgrammingHero1/{})"\
  #     --bind "ctrl-i:execute(git clone git@github.com:ProgrammingHero1/{}.git)"
  #


# for ProgrammingHero1 (shallow clone mode no commit history and only default branch)
gh repo list ProgrammingHero1 --json name --jq '.[].name' --limit 2200 | \
fzf --prompt="Select a repo: " --height=80% \
    --preview="gh repo view ProgrammingHero1/{}" --preview-window=right:60% \
    --bind "enter:execute-silent(echo -n {} | xclip -selection clipboard)" \
    --bind "ctrl-o:execute(gh repo view ProgrammingHero1/{} --web)" \
    --bind "ctrl-r:execute(git clone --depth=1 --single-branch https://github.com/ProgrammingHero1/{}.git)" \
    --bind "ctrl-i:execute(git clone --depth=1 --single-branch git@github.com:ProgrammingHero1/{}.git)"

