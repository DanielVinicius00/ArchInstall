#!/bin/bash

# Verifica se o script está sendo executado como root

#Instalando Xorgs e Plasma para dispositivos Intel

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm xorg-xinit xorg-server xorg-apps mesa

sudo pacman -S --needed --nonconfirm xf86-video-intel

sudo pacman -S --needed --noconfirm plasma firefox okular dolphin discover konsole

sudo pacman -S --needed --noconfirm sddm

sudo systemctl enable sddm

sudo systemctl enable NetworkManager

echo "Plasma foi instalado. Reiniciando"
reboot
