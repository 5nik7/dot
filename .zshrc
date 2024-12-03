# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Add items to PATH
if [ -d '~/.bin' ]; then
  PATH="~/.bin:$PATH"
fi

if [ -d '~/.local/bin' ]; then
  PATH="~/.local/bin:$PATH"
fi

if [ -d '~/.cargo/bin' ]; then
  PATH="~/.cargo/bin:$PATH"
fi

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

# Prompt
eval "$(starship init zsh)"