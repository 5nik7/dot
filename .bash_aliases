if command -v exa > /dev/null 2>&1; then
  alias ll="exa -lA --group-directories-first --icons --git --git-repos --no-filesize --no-permissions --no-user --no-time"
  alias l="exa -lA --group-directories-first --icons --git --git-repos"
else
  alias l="ls -lah --color=auto"
  alias ll="ls -lFh --color=auto"
fi
# alias l="exa -lA --group-directories-first --icons --git --git-repos --no-filesize --no-permissions --no-user --no-time"
# alias ll="exa -lA --group-directories-first --icons --git --git-repos"

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias c="clear"
alias q="exit"

if command -v bat > /dev/null 2>&1; then
	alias cat='bat'
fi

if command -v lazygit > /dev/null 2>&1; then
	alias lg='lazygit'
fi

if command -v ranger > /dev/null 2>&1; then
	alias d="ranger"
	alias dd='cd $DOTFILES && ranger'
	alias dz='cd $DOTFILES/config/zsh && ranger'
fi

alias ".."="cd .."
alias "..."="cd ../.."
alias "...."="cd ../../.."
alias "....."="cd ../../../.."
alias "......"="cd ../../../../.."
alias "......."="cd ../../../../../.."
alias "........"="cd ../../../../../../.."

alias mkd='mkdir -p'
alias rm='rm -rf'

alias path='echo $PATH | tr ":" "\n"'

alias installed="grep -i installed /var/log/pacman.log"

alias v="$EDITOR"
alias vi="$EDITOR"
alias sv="sudo $EDITOR"
alias svi="sudo $EDITOR"
alias dotfiles="$EDITOR $DOTFILES"

if [ -f /etc/arch-release ] ;then
	alias lg='lazygit'
	# install
	alias pacin="pacman -Slq | fzf -m --preview 'cat <(pacman -Si {1}) <(pacman -Fl {1} | awk \"{print \$2}\")' | xargs -ro sudo pacman -S"
	alias pacrem="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
	alias pac-update='sudo pacman -Sy'
	alias pac-upgrade='sudo pacman -Syu'
	alias pac-upgrade-force='sudo pacman -Syyu'
	alias pac-install='sudo pacman -S'
	alias pac-remove='sudo pacman -Rs'
	# search remote package
	alias pac-search='pacman -Ss'
	alias pac-package-info='pacman -Si'
	# search local package
	alias pac-installed-list='pacman -Qs'
	alias pac-installed-package-info='pacman -Qi'
	alias pac-installed-list-export='pacman -Qqen' # import: sudo pacman -S - < pkglist.txt
	alias pac-installed-files='pacman -Ql'
	alias pac-unused-list='pacman -Qtdq'
	alias pac-search-from-path='pacman -Qqo'
	# search package from filename
	alias pac-included-files='pacman -Fl'
	alias pac-search-by-filename='pkgfile'
	# log
	alias pac-log='cat /var/log/pacman.log | \grep "installed\|removed\|upgraded"'
	alias pac-aur-packages='pacman -Qm'
	# etc
	alias pac-clean='sudo pacman -Scc'
	alias pac-get-update-pkg='pacman -Si $(pacman -Su --print --print-format %n)'
	alias pac-dependency='pacman -Qoq '
	# aur
	if builtin command -v paru > /dev/null 2>&1; then
		alias paruin="paru -Slq | fzf -m --preview 'cat <(paru -Si {1}) <(paru -Fl {1} | awk \"{print \$2}\")' | xargs -ro  paru -S"
		alias parucom="paru -Gc"
		alias parupd="paru -Qua"
		alias parucheck="paru -Gp"
		alias paru-installed-list='paru -Qm'
		alias paru-clean='paru -Sc'
	fi
fi
