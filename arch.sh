#!/bin/bash

# Verifica se o script está sendo executado como root
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root."
   exit 1
fi

# Criação da partição usando o gdisk
loadkeys br-abnt2

setfont ter-v32n

gdisk /dev/sda <<EOF
o
y

n
1

+1g
ef00
n
2

8200
w
y
EOF
gdisk /dev/sdb <<EOF
o
y

n
1


8300
w
y
EOF

# Formatação da partição como ext4
mkfs.btrfs -f /dev/sdb1

mkswap /dev/sda2

swapon /dev/sda2

mkfs.vfat -F32 /dev/sda1
# Montagem da partição raiz em /mnt
mount /dev/sdb1 /mnt

mkdir -pv /mnt/boot/efi

mount /dev/sda1 /mnt/boot/efi

# Configuração do espelho dos repositórios (opcional, pode ser ajustado conforme a distribuição Linux desejada)
rm /etc/pacman.d/mirrorlist

echo "ParallelDownloads = 5" >> /etc/pacman.conf

echo "[multilib]" >> /etc/pacman.conf

echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

#Mirrors

echo "Server = https://mirror.ufscar.br/archlinux/$repo/os/$arch" >> /etc/pacman.d/mirrorlist

echo "Server = https://www.caco.ic.unicamp.br/archlinux/$repo/os/$arch " >> /etc/pacman.d/mirrorlist

echo "Server = https://mirror.adectra.com/archlinux/$repo/os/$arch  " >> /etc/pacman.d/mirrorlist

echo "Server = https://mirror.arizona.edu/archlinux/$repo/os/$arch " >> /etc/pacman.d/mirrorlist




pacman-key --init

pacman-key --populate

pacman -Sy archlinux-keyring
# Instalação dos pacotes base e base-devel
pacstrap /mnt base base-devel linux linux-firmware nano dhcpcd

# Gerar arquivo fstab para montagem automática das partições
genfstab -U /mnt >> /mnt/etc/fstab

# Copia o arquivo resolv.conf para a nova raiz, para manter a conectividade de rede
cp -r /etc/pacman.conf /mnt/etc/pacman.conf

cp -r /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist

cp -r arch2.sh /mnt/


# Chroot para a nova raiz
arch-chroot /mnt

# Agora você está no ambiente chroot da nova instalação. Você pode executar comandos adicionais se necessário.

# Finalização da execução do script
echo "Instalação concluída."
