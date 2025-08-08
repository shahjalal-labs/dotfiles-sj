/home/sj/.venvs/browserctl/bin/activate
`if not work run for the first time:`
source ~/.venvs/browserctl/bin/activate
`1. run browser with`
google-chrome-canary --remote-debugging-port=9222 --user-data-dir=/tmp/chrome-remote &
`2.  run python script with:`
python close_linkedin_tabs.py
