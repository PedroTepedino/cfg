if pacman -Qs paru > /dev/null; then
  echo "Paru Already installed"
else 
  echo "Installing PARU"
  sudo pacman -S --needed base-devel  
  
  git clone https://aur.archlinux.org/paru.git
  cd paru
  
  makepkg -si
  cd ..

  echo "Paru Installed"
  echo "Removing Repo"
  rm -rf paru
fi
