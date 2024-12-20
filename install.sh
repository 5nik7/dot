#!/bin/bash

DOTS=$HOME/dot

# Import OS info as variables
. /etc/os-release

# ==== Check if running Arch ==== #

if [[ $ID != 'arch' ]]; then
  echo 'Arch Linux not detected.'
  echo 'This script only works on Arch or Arch based distros.'
  exit 1
fi

printf '\033[1;33mDOT INSTALLER \033[0m \n'
read -p 'Continue? (y/N) ' confirmation
confirmation=$(echo "$confirmation" | tr '[:lower:]' '[:upper:]')
if [[ "$confirmation" == 'N' ]] || [[ "$confirmation" == '' ]]; then
  exit 0
fi

# ==== Back up function ==== #

error() {
  printf "\033[0;31mERROR: \033[0m $1"
  exit 1
}

backUp() {
  # SYNTAX: Backup-path:string items:array
  backupPath="$1"
  shift  # Shift args to the left (removes $1 from $@)
  items=("$@")

  if [[ ! -e "$backupPath"/.backup ]]; then mkdir "$backupPath"/.backup; fi
  local backedUp=false
  for item in "${items[@]}"; do
    if [[ -e "$backupPath"/"$item" ]]; then
      echo "Backing up ${backupPath}/${item}"
      mv ${backupPath}/${item} ${backupPath}/.backup  || error "Failed to back up: ${backupPath}/${item}"
      backedUp=true
    fi
  done
  if [[ "$backedUp" = true ]]; then
    echo "Backed up items have been stored in ${backupPath}/.backup"
  elif [[ -z $(ls ${backupPath}/.backup) ]]; then
    rm -d ${backupPath}/.backup
  fi
}

# ==== Install packages ==== #

{
if [[ ! -e /bin/rustup ]]; then
    echo 'Installing rust...'
    sudo pacman --noconfirm -Rs rust
    sudo pacman --needed --noconfirm -S rustup
fi
} || error 'Failed to install rust'

{
if [[ $(rustup default) = nightly* ]]; then
  if [[ ! -e $HOME/.cargo/bin/bob ]]; then
    cargo install --git https://github.com/MordechaiHadad/bob.git
  fi
else
  rustup default nightly
  argo install --git https://github.com/MordechaiHadad/bob.git
fi
} || error 'Failed to install Macchina'

echo 'Installing packages...'
{
  sudo pacman --needed --noconfirm -Syu base-devel
  sudo pacman --needed --noconfirm -S \
    sway waybar rofi-wayland \
    kitty zsh luajit github-cli \
    starship eza bat ripgrep fd yazi \
    kvantum kvantum-qt5 qt5ct qt6ct gtk2 gtk3 gtk4 \
    iniparser autoconf-archive pkgconf xdg-user-dirs wget unzip \
    ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono
} || error 'Failed to install required packages'

{
if [[ ! -d $DOTS ]]; then
    git clone https://github.com/5nik7/dot.git $DOTS || error 'Failed to clone repo'
fi
} || error 'Failed to clone repo'

echo 'Installation complete!'