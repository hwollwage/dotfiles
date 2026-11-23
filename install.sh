#!/usr/bin/env bash
# sudo cp ~/dotfiles/scripts/usb-notify.sh /usr/local/bin/ for future rules.d

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
# RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE} ~ dotfiles setup ${NC}\n"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

PACKAGES_DIR="$DOTFILES_DIR/pkgs"

if [ -d "$PACKAGES_DIR" ]; then
  echo -e "${BLUE}[*] initializing packages...${NC}"

  # pacman
  # pacman -Qqen
  if [ -f "$PACKAGES_DIR/pacman.txt" ]; then
    echo -e "${YELLOW}[->] installing from pacman repo...${NC}"
    grep -vE '^\s*#|^\s*$' "$PACKAGES_DIR/pacman.txt" | sudo pacman -S --needed --noconfirm -
  fi

  # yay (AUR)
  # pacman -Qqem
  if [ -f "$PACKAGES_DIR/aur.txt" ]; then
    echo -e "${YELLOW}[->] checking AUR helper...${NC}"
    if ! command -v yay &>/dev/null; then
      sudo pacman -S --needed --noconfirm git base-devel
      rm -rf /tmp/yay
      git clone https://archlinux.org /tmp/yay
      (cd /tmp/yay && makepkg -si --noconfirm)
      rm -rf /tmp/yay
    fi
    echo -e "${YELLOW}[->] installing app from AUR...${NC}"
    grep -vE '^\s*#|^\s*$' "$PACKAGES_DIR/aur.txt" | yay -S --needed --noconfirm -
  fi

  # flatpak
  # flatpak list --app --columns=application
  if [ -f "$PACKAGES_DIR/flatpak.txt" ]; then
    echo -e "${YELLOW}[->] checking flatpak...${NC}"
    if ! command -v flatpak &>/dev/null; then
      sudo pacman -S --needed --noconfirm flatpak
    fi
    echo -e "${YELLOW}[->] installing flatpak app...${NC}"
    while IFS= read -r app; do
      [[ -z "$app" || "$app" =~ ^# ]] && continue
      flatpak install --user -y --noninteractive flathub "$app" || true
    done <"$PACKAGES_DIR/flatpak.txt"
  fi
fi

echo -e "\n${GREEN}[✓] setup complete!${NC}"
