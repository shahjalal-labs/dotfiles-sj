 #
 #
 # gh repo list shahjalal-labs --json name --jq '.[].name' --limit 400 | \
 # fzf --prompt="Select a repo: " --height=80% \
 #     --preview="gh repo view shahjalal-labs/{}" --preview-window=right:60% \
 #     --bind "enter:execute-silent(echo -n {} | xclip -selection clipboard)" \
 #     --bind "ctrl-o:execute(gh repo view shahjalal-labs/{} --web)" \
 #     --bind "ctrl-d:execute(git clone https://github.com/shahjalal-labs/{})" \
 #     --bind "ctrl-x:execute-silent(gh repo delete shahjalal-labs/{} --yes)"\
 #     --bind "ctrl-r:execute-silent(gh repo rename shahjalal-labs/{} --yes)"\
 #     --bind "ctrl-i:execute(git clone git@github.com:shahjalal-labs/{}.git)"
 #



 gh repo list shahjalal-labs --json name --jq '.[].name' --limit 400 | \
fzf --prompt="Select a repo: " --height=80% \
    --preview="gh repo view shahjalal-labs/{}" --preview-window=right:60% \
    --bind "enter:execute-silent(echo -n {} | xclip -selection clipboard)" \
    --bind "ctrl-o:execute(gh repo view shahjalal-labs/{} --web)" \
    --bind "ctrl-d:execute(git clone https://github.com/shahjalal-labs/{})" \
    --bind "ctrl-x:execute-silent(gh repo delete shahjalal-labs/{} --yes)" \
    --bind "ctrl-r:execute( \
      bash -c ' \
        read -p \"New repo name for {}: \" newname && \
        gh repo rename \"$newname\" --repo shahjalal-labs/{} \
      ' \
    )" \
    --bind "ctrl-i:execute(git clone git@github.com:shahjalal-labs/{}.git)"

