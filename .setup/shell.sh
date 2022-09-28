#!/bin/sh

source ./funcs.sh

packages="zsh ttf-meslo-nerd-font-powerlevel10k"
install $packages

if [ -d $HOME/.oh-my-zsh/ ]; then
  echo "ohmyzsh already installed"
else
  echo "installing ohmyzsh"
  sh -c "$(curl -fsoh https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]; then
  echo "powerlevel10k already cloned"
else
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi
