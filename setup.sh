#!/bin/sh

sudo true

cd ~

echo "Clonning Dotfiles"

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
packages="nvim zsh ttf-meslo-nerd-font-powerlevel10k alacritty xorg xorg-xinit picom firefox rate-mirrors xf86-video-fbdev"
paru -S $packages 

echo "Updating Everything"
paru -Syu
