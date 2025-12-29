#!/usr/bin/env bash

[[ $- != *i* ]] && return

# Set up line editor.
source -- /usr/share/blesh/ble.sh --attach=none --rcfile "$HOME/.config/blesh/init.sh"
[[ ! ${BLE_VERSION-} ]] || ble-attach

# Set up prompt.
eval "$(starship init bash)"

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
alias spawn='niri msg action spawn --'

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
alias rm='rm -i'

# Fun aliases

# like `sl` but for `cd`
alias cs='cowsay'

# Set up tools

# TODO: remove
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Colours

eval "$(dircolors)"

# Ensure a success status
:
