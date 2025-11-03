#!/bin/sh

# use openjdk over `/usr/bin/java`
export PATH="/usr/lib/jvm/java-21-openjdk/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/share/coursier/bin"

# TODO: replace with mili
export EDITOR="codium --wait"

export MICRO_TRUECOLOR=1
export ELECTRON_OZONE_PLATFORM_HINT=auto
