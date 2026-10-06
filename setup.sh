#!/usr/bin/env bash
set -e

echo "=== 1. Создание директории для конфига Hyprland ==="
mkdir -p ~/.config/hypr

echo "=== 2. Копирование hyprland.conf ==="
if [ -f "hyprland.conf" ]; then
    cp hyprland.conf ~/.config/hypr/hyprland.conf
    echo "Файл hyprland.conf успешно перемещен в ~/.config/hypr/"
else
    echo "Ошибка: Файл hyprland.conf не найден в текущей директории!"
    exit 1
fi

echo "=== 3. Обновление системы и установка Git / Base-devel ==="
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm base-devel git

echo "=== 4. Установка AUR-помощника (Yay) ==="
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
fi

echo "=== 5. Установка ядра Zen, драйверов AMD и утилит ==="
sudo pacman -S --needed --noconfirm \
    linux-zen linux-zen-headers \
    mesa lib32-mesa \
    vulkan-radeon lib32-vulkan-radeon \
    libva-mesa-driver lib32-libva-mesa-driver \
    gamemode mangohud \
    hyprland waybar kitty \
    dunst swww grim slurp wl-clipboard cliphist \
    qt5-wayland qt6-wayland xdg-desktop-portal-hyprland \
    polkit-kde-agent ttf-jetbrains-mono-nerd thunar

yay -S --needed --noconfirm rofi-lbonn-wayland-git

echo "=== Готово! Перезагрузите систему или введите Hyprland ==="