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

fpath=("$HOME/.local/share/scalacli/completions/zsh" $fpath)
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

PROMPT="[%F{13}%n%f] %F{12}%~%f > "

alias cat='bat'
alias edit=$EDITOR
alias ide='zeditor'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias spawn='niri msg action spawn --'

# TODO: remove
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

function fm() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

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

eval "$(starship init zsh)"

true
