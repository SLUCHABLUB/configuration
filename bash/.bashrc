#!/usr/bin/env bash

[[ $- != *i* ]] && return

# Set up prompt.
eval "$(starship init bash)"

# [[ ! ${BLE_VERSION-} ]] || ble-attach

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

alias cat='bat'
alias du='dust'
alias edit='$EDITOR'
alias fetch='fastfetch'
alias icat='kitten icat'
alias ide='zeditor'
alias grep='grep --color=auto'
alias ls='eza'
alias open='xdg-open'
alias rg='rg -S'
alias spawn='niri msg action spawn --'

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
