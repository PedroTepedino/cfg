#!/bin/sh

#setup 
sudo true
cd ~

#paru
package="paru"
check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")";
if [ -n "${check}" ] ; then
  echo "paru Already installed"
elif [ -z "${check}" ] ; then
  if [ -d "$HOME/paru" ]; then
    rm -rf $HOME/paru
  fi

  echo "Installing PARU"
  sudo pacman -S --needed base-devel  
  
  git clone https://aur.archlinux.org/paru.git
  cd paru
  
  makepkg -si --needed --noconfirm
  cd ..

  echo "Paru Installed"
  echo "Removing Repo"
  rm -rf paru
fi

paru -Syu --noconfirm


#packages
packages="git neovim alacritty rate-mirrors xorg xorg-xinit picom firefox awesome glow xf86-video-fbdev"
echo "Installing packages"
paru -Syu --needed --noconfirm $packages


#shell
packages="zsh ttf-meslo-nerd-font-powerlevel10k"
paru -Syu --needed --noconfirm $packages


echo "installing ohmyzsh"
sh -c "$(curl -fsoh https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

if [ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]; then
  echo "powerlevel10k already cloned"
else
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi


#dotfiles
git clone --bare https://github.com/PedroTepedino/cfg.git $HOME/.cfg

function config {
  /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

mkdir -p .config-backup
config checkout

if [ $? = 0 ]; then
  echo "Checked out config.";
else
  echo "Backing up pre-existing dot files.";
  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv  {} .config-backup/{}
fi;

config checkout
config config status.showUntrackedFiles no

