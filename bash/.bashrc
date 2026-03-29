#!/usr/bin/env bash

[[ $- != *i* ]] && return

# Set up line editor.
source -- /usr/share/blesh/ble.sh --attach=none --rcfile "$HOME/.config/blesh/init.sh"

# Set up prompt.
eval "$(starship init bash)"

[[ ! ${BLE_VERSION-} ]] || ble-attach

# Set up history

# TODO: move
HISTFILE="$HOME/.bash_history"
# Remove duplicates from the history.
HISTCONTROL=ignoredups:erasedups
# Append history when exiting the shell.
shopt -s histappend

# Aliases

alias cat='bat'
alias edit='$EDITOR'
alias ide='zeditor'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias open='xdg-open'
alias py='python3'
alias spawn='niri msg action spawn --'
alias trash='trash-put'
alias wm='niri'

function fm() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

[ "$TERM" = 'xterm-kitty' ] && alias ssh='kitten ssh'

# Safety aliases

alias cp='cp -i'
alias mv='mv -i'
alias rm='sl'

# Fun aliases

# like `sl` but for `cd`
alias cs='cowsay'

# Colours

eval "$(dircolors)"

# Ensure a success status
:
