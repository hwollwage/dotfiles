#!/usr/bin/env bash

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE} ~ dotfiles setup ${NC}\n"

DOTFILES_DIR = "$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
cd "$DOTFILES_DIR"

PACKAGES_DIR = "$DOTFILES_DIR/packages"

if [ -d "$PACKAGES_DIR" ]; then
    echo -e "${BLUE}[*] initializing packages...${NC}"

    # pacman
    if [ -f "$PACKAGEES_DIR/pacman.txt" ]; then
        echo -e "${YELLOW}[->] installing from pacman repo...${NC}"
        sudo pacman -S --needed --noconfirm - < "$PACKAGES_DIR/pacman.txt"
    fi

    # yay (AUR)
    if [ -f "$PACKAGES_DIR/aur.txt" ]; then
        echo -e "${YELLOW}[->] checking AUR helper...${NC}"
        sudo pacman -S --needed --noconfirm git base-devel
        git clone https://archlinux.org /tmp/yay
        cd /tmp/yay && makepkg -si --noconfirm
        cd "$DOTFILES_DIR"
    fi
    echo -e "${YELLOW}[->] installing app from AUR...${NC}"
    yay -S --needed --noconfirm - < "$PACKAGES_DIR/aur.txt"

    # flatpak
    if [ -f "$PACKAGES_DIR/flatpak.txt" ]; then
        echo -e "${YELLOW}[->] checking flatpak...${NC}"
        if ! command -v flatpak &> /dev/null; then
            sudo pacman -S --noconfirm flatpak
        fi
        echo -e "${YELLOW}[->] installing flatpak app...${NC}"
        while read -r app; do
            [ -z "$app" ] && continue
            flatpak install --user --y --noninteractive flathub "$app" || true
        done < "$PACKAGE_DIR/flatpak.txt"
    fi
fi

