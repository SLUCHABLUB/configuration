# Load plugins

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]
then
    mkdir -p "$(dirname ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

fpath=("/home/nelli/.local/share/scalacli/completions/zsh" $fpath)
autoload -U compinit && compinit

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

unsetopt autocd
bindkey -e

# Make completion non case-sensitive.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# Make completions have colour
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# use openjdk over `/usr/bin/java`
export PATH="/usr/lib/jvm/java-21-openjdk/bin:$PATH"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/share/coursier/bin"

PROMPT="[%F{13}%n%f] %F{12}%~%f > "

export EDITOR="micro"

export MICRO_TRUECOLOR=1
export ELECTRON_OZONE_PLATFORM_HINT=auto

alias cat='bat'
alias code='codium'
alias edit='$EDITOR'
alias grep='grep --color=auto'
alias ls='ls --color=auto'

[ "$TERM" = 'xterm-kitty' ] && alias ssh='kitten ssh'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# like `sl` but for `cd`
alias cs='cowsay'

# alt+left/right
bindkey "\e[1;3C" forward-word
bindkey "\e[1;3D" backward-word

# ctrl+left/right
bindkey "\e[1;5C" end-of-line
bindkey "\e[1;5D" beginning-of-line
