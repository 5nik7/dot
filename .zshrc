#     ____  ______ _____  _____
#    /_  / / __/ // / _ \/ ___/
#   _ / /__\ \/ _  / , _/ /__
#  (_)___/___/_//_/_/|_|\___/

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
 [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
 [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
 source "${ZINIT_HOME}/zinit.zsh"

zinit load zdharma-continuum/fast-syntax-highlighting
zinit load zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-completions
zinit load zsh-users/zsh-history-substring-search

 autoload -Uz _zinit
 (( ${+_comps} )) && _comps[zinit]=_zinit

zle_highlight=('paste:none')

export WIN="/mnt/c"
export WOME="$WIN/Users/njen"
export SUDO_PROMPT="passwd: "

function extend_path() {
  [[ -d "$1" ]] || return

  if ! echo "$PATH" | tr ":" "\n" | grep -qx "$1"; then
    export PATH="$PATH:$1"
  fi
}

function prepend_path() {
  [[ -d "$1" ]] || return

  if ! echo "$PATH" | tr ":" "\n" | grep -qx "$1"; then
    export PATH="$1:$PATH"
  fi
}

function so() {
  if [ -f "$1" ]; then
    # shellcheck source=/dev/null
    source "$1"
  fi
}

function command_exists() {
  command -v "$@" &>/dev/null
}

prepend_path "$HOME/.local/share/bob/nvim-bin"
prepend_path "$HOME/.fzf/bin"
prepend_path "$HOME/.cargo/bin"
prepend_path "$HOME/.local/bin"
prepend_path "$HOME/.bin"
extend_path "$WOME/scoop/apps/win32yank/0.1.1"
extend_path "$WIN/vscode/bin"
extend_path "$WIN/Windows/System32"
extend_path "$WIN/Windows"

# History
HISTSIZE=2500
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt appendhistory
setopt sharehistory

# Aliases
alias upd='sudo pacman -Syu'
alias uninst='sudo pacman -Rs'
alias inst='sudo pacman -S'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

function gup() {
  if [ -d .git ]; then
  commitDate=$(date +"%m-%d-%Y %H:%M")
    echo -e ""
    git add .
    git commit -m "Update @ $commitDate"
    git push
    echo -e ""
  else 
    echo -e "This directory does not contain a .git directory"
  fi
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
alias d='y'

alias c='clear'
alias q='exit'

alias v='$EDITOR'

alias g='git'

alias path='echo $PATH | tr ":" "\n"'

alias ".."="cd .."
alias "..."="cd ../.."
alias "...."="cd ../../.."
alias "....."="cd ../../../.."
alias "......"="cd ../../../../.."
alias "......."="cd ../../../../../.."
alias "........"="cd ../../../../../../.."

function dd {
  if [ -z "$1" ]; then
    explorer.exe .
  else
    explorer.exe "$1"
  fi
}

alias ll='echo -e "" && eza -lA --git --git-repos --icons --group-directories-first --no-quotes && echo -e ""'
alias l='echo -e "" && eza -lA --git --git-repos --icons --group-directories-first --no-quotes --no-permissions --no-filesize --no-user --no-time && echo -e ""'

alias cargo="RUSTFLAGS='-Z threads=8' cargo +nightly"

function google {
    open "https://www.google.com/search?q=$*"
}

command_exists fzf && command_exists bat && alias preview="fzf --preview 'bat --color \"always\" {}'"

# Prompt
eval "$(starship init zsh)"