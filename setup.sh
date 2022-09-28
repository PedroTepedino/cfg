#!/bin/sh

sudo true

cd ~

if pacman -Qs paru > /dev/null; then
  echo "Paru Already installed"
else
  echo "Installing PARU"
  sudo pacman -S --needed base-devel
  git clone https://aur.archlinux.org/paru.git
  cd paru 
  makepkg -si
  cd ..

  echo "Paru installed... Removing repo"
  rm -rf paru
fi

echo "Installing packages"
paru -Syu --needed neovim zsh ttf-meslo-nerd-font-powerlevel10k alacritty xorg xorg-xinit picom firefox rate-mirrors xf86-video-fbdev 

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

echo "Updating Everything"
paru -Syu

if [ -d $HOME/dotfiles/ ]; then
  echo "Dotfiles already cloned"
else
  echo "Clonning Dotfiles"

  git clone --bare https://github.com/PedroTepedino/dotfiles $HOME/dotfiles

  source .bashrc
  source .zshrc

  config checkout

  config config --local status.showUntrackedFiles no
fi
