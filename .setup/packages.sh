#!/bin/sh

source ./funcs.sh

packages="git neovim alacritty rate-mirrors xorg xorg-xinit picom firefox awesome glow xf86-video-fbdev"

echo "Installing packages"

instal $packages
