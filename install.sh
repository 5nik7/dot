#!/bin/bash

# Import OS info as variables
. /etc/os-release

# ==== Check if running Arch ==== #

if [[ $ID != 'arch' ]]; then
  echo 'Arch Linux not detected.'
  echo 'This script only works on Arch or Arch based distros.'
  exit 1
fi

printf '\033[1;33m dot \033[0m \n'
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

echo 'Installing packages...'
{
  sudo pacman --needed --noconfirm -Syu base-devel
  sudo pacman --needed --noconfirm -S \
    sway waybar rofi-wayland \
    kitty zsh starship luajit \
    kvantum kvantum-qt5 qt5ct qt6ct gtk2 gtk3 gtk4 \
    iniparser autoconf-archive pkgconf xdg-user-dirs wget unzip \
    ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono
} || error 'Failed to install required packages'

echo 'Installing rust...'
{
sudo pacman --noconfirm -Rs rust
if [[ ! $(pacman -Q rustup > /dev/null 2>&1) ]]; then
        sudo pacman --needed --noconfirm -S rustup
        rustup default nightly
fi
} || error 'Failed to install rust'


{
DOTS=$HOME/dot
export $DOTS
if [[ ! -d $DOTS ]]; then
    git clone https://github.com/5nik7/dot.git $DOTS || error 'Failed to clone repo'
fi
} || error 'Failed to clone repo'

{
if [[ -e $(which zsh) ]]; then
  read -p 'Change shell to zsh? (y/N) ' modifyZshrc
  modifyZshrc=$(echo "$modifyZshrc" | tr '[:lower:]' '[:upper:]')
  if [[ "$modifyZshrc" == 'Y' ]]; then
    backUp $HOME '.zshrc'
    ln -s $HOME/dot/.zshrc $HOME/.zshrc
    sudo chsh -s $(which zsh)
fi
} || error 'Failed to change shell to zsh'

echo 'Installation complete!'