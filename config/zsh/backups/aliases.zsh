alias reload!='RELOAD=1 source ~/.zshrc'

alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias update="sudo pacman -Syu --noconfirm"
alias dotfiles="$EDITOR $DOTFILES"

# use exa if available
if [[ -x "$(command -v exa)" ]]; then
  alias ll="exa -lA --group-directories-first --icons --git --git-repos --no-filesize --no-permissions --no-user --no-time"
  alias l="exa -lA --group-directories-first --icons --git --git-repos"
else
  alias l="ls -lah --color=auto"
  alias ll="ls -lFh --color=auto"
fi

alias lld="ls -l | grep ^d"

alias grep='grep --color=auto'

alias c="clear"
alias q="exit"
alias d="ranger"
alias cat="bat"

alias mkd='mkdir -p'
alias rm='rm -rf'

alias path='echo $PATH | tr ":" "\n"'

alias installed="grep -i installed /var/log/pacman.log"


if [[ -x "$(command -v nvim)" ]]; then
  alias v="nvim"
elif [[ -x "$(command -v vim)" ]]; then
  alias v="vim"
fi
