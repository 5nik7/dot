
HOSTNAME="$HOST"
HISTFILE="${ZDATADIR}/zsh_history"
HISTSIZE=10000                    # Number of histories in memory
SAVEHIST=100000                   # Number of histories to be saved
HISTORY_IGNORE="(ls|cd|pwd|zsh|exit|cd ..)"
LISTMAX=100

WORDCHARS='*?_-[]~&;!#$%^(){}<>|'

cdpath=("$HOME" .. $HOME/*(N-/) $HOME/.config)

ulimit -c unlimited

umask 022

export DISABLE_DEVICONS=false