#!/bin/bash

# Verifica se o script está sendo executado como root
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root."
   exit 1
fi

#Configurações

ln -sf /usr/share/zoneinfo/America/Araguaina /etc/localtime

echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen

locale-gen

echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf

echo "computador" >> /etc/hostname

echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf

#Usuários

echo "Insira a senha do root"
passwd root

useradd -m -g users -G wheel,power,storage -s /bin/bash james

echo "Insira a senha do usuário James"
passwd james

echo "james ALL=(ALL:ALL) ALL" >> /etc/sudoers

#Instalando aplicativos de internet, utilitários de filesystems e softwares de extração

pacman -S --noconfirm dosfstools mtools networkmanager network-manager-applet wpa_supplicant wireless_tools dialog os-prober unrar unzip p7zip git nasm vim neovim neofetch

#Instalando e configurando o Grub para x86_64-efi

pacman -S --noconfirm grub efibootmgr

echo "Instalando Grub"
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=archlinux --recheck

grub-mkconfig -o /boot/grub/grub.cfg

exit

echo "Instalação e Configuração concluída"

echo "Reiniciando"
reboot

