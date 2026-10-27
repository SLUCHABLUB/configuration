#!/usr/bin/env bash

[[ $- != *i* ]] && return

# Set up prompt.
# Starship ignores XDG_CACHE_HOME and writes its logs to ~/.cache/starship otherwise.
export STARSHIP_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/starship"
eval "$(starship init bash)"

if [[ ! ${BASH_COMPLETION_VERSINFO:-} &&
     -f /usr/share/bash-completion/bash_completion ]]
then
    source /usr/share/bash-completion/bash_completion
fi

# Set up history

# TODO: move
HISTFILE="$HOME/.bash_history"
# Remove duplicates from the history.
HISTCONTROL=ignoredups:erasedups
# Append history when exiting the shell.
shopt -s histappend

# Aliases

alias ..='cd ..'
alias cat='bat --paging=never'
alias du='dust'
alias fetch='fastfetch'
alias icat='kitten icat'
alias ide='zeditor'
alias grep='grep --color=auto'
alias ls='eza'
alias open='xdg-open'
alias rg='rg -S'

function fm() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

[ "$TERM" = 'xterm-kitty' ] && alias ssh='kitten ssh'

# Evil aliases

alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lhA'
alias py='python3'

# Safety aliases

alias cp='cp -i'
alias mv='mv -i'
alias rm='sl'

# Fun aliases

# like `sl` but for `cd`
alias cs='cowsay'

# Ensure a success status
:
