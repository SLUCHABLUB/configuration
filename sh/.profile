#!/bin/sh

export XDG_STATE_HOME="$HOME/State"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export BROWSER="helium-browser"
export EDITOR="textadept-curses"
export PAGER="bat --style header-filename"

# Make 'roff' emit plain text so bat can do the highlighting.
export MANROFFOPT="-P-cbou"
export MANPAGER="bat --plain --language man"

export MICRO_TRUECOLOR=1
