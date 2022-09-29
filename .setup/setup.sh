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


# echo "installing ohmyzsh"
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# if [ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]; then
#   echo "powerlevel10k already cloned"
# else
#   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# fi

git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
# git -C ~/.oh-my-zsh/custom/plugins clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git
# git -C ~/.oh-my-zsh/custom/plugins clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git
git -C ~/.oh-my-zsh/custom/themes clone --depth=1 https://github.com/romkatv/powerlevel10k.git

cat >~/.zshrc <<\END
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH=~/.oh-my-zsh
DISABLE_AUTO_UPDATE=true
DISABLE_MAGIC_FUNCTIONS=true
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(zsh-syntax-highlighting zsh-autosuggestions)

source ~/.oh-my-zsh/oh-my-zsh.sh
source ~/.p10k.zsh
END

cat >~/.p10k.zsh <<\END
# put the content of your own .p10k.zsh here
END


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

