# ~/.bashrc


eval `dircolors ~/.dircolors/solarized.dark`

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# tmux
if which tmux >/dev/null 2>&1; then
    # if no session is started, start a new session
    test -z ${TMUX} && tmux

    # when quitting tmux, try to attach
    while test -z ${TMUX}; do
        tmux attach || break
    done
fi

export PATH="$PATH:~/.bin"

alias g='git'
alias le='ls -al'
alias mutt='sh ~/.bin/muttstarter.sh'
alias pond='client -cli'
