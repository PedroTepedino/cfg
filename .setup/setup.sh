#!/bin/sh

sudo true

cd ~

if [ -d "$HOME/.setup/" ]; then

  setup_folder="$HOME/.setup"

  paru="$setup_folder/paru.sh"
  packages="$setup_folder/packages.sh"
  shell="$setup_folder/shell.sh"
  dotfiles="$setup_folder/dotfiles.sh"

else

  url="curl -L https://raw.githubusercontent.com/PedroTepedino/cfg/master/.setup"

  paru=$("$url/setup.sh")
  packages=$("$url/packages.sh")
  shell=$("$url/shell.sh")
  dotfiles=$("$url/dotfiles.sh")

fi

source $paru
source $packages
source $shell
source $dotfiles
