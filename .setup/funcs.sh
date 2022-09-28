instal () {
  if pacman -Qs paru > /dev/null; then
    echo "paru NOT found"
    echo "using pacman instead"

    sudo pacman -Syu --needed --noconfirm $1
  else
    paru -Syu --needed --noconfirm $1
  fi
}
