#
# ~/.bashrc
#

[[ $- != *i* ]] && return

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s checkwinsize

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

export EDITOR="nvim"
export VISUAL="$EDITOR"
export TTY=$(tty)
export BROWSER="firefox"

export WIN="/mnt/c"
export DOTFILES="$HOME/.dotfiles"

if command -v nvim > /dev/null 2>&1; then
	export EDITOR="nvim"
  	export MANPAGER="nvim +Man!"
elif
	command -v vim > /dev/null 2>&1; then
	export EDITOR="vim"
else
	export EDITOR="nano"
fi
export SYSTEMD_EDITOR=$EDITOR
export VISUAL="$EDITOR"

if command -v fzf > /dev/null 2>&1; then
  FZF_COLORS="bg+:-1,\
  fg:gray,\
  fg+:white,\
  border:black,\
  spinner:0,\
  hl:yellow,\
  header:blue,\
  info:green,\
  pointer:red,\
  marker:blue,\
  prompt:gray,\
  hl+:red"

  export FZF_DEFAULT_OPTS="--height 60% \
  --border sharp \
  --layout reverse \
  --color '$FZF_COLORS' \
  --prompt '∷ ' \
  --pointer ▶ \
  --marker ⇒"
fi

if command -v fzf > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

function source_file() {
  if [ -r "$1" ]; then
    source "$1"
  fi
}

source_file "$HOME/.bash_functions"
source_file "$HOME/.bash_aliases"
source_file "$HOME/.bash_prompt"
source_file "$HOME/.cargo/env"

export PATH="/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

extend_path "$HOME/.local/bin"

prepend_path "$WIN/vscode/bin"
prepend_path "$XDG_DATA_HOME/bob/nvim-bin"

source_file "/usr/share/bash-completion/bash_completion"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# eval "$(starship init bash)"
