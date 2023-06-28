# ArchInstall
Script de uma instalação do Arch Linux específica

Notas da instalação:

- Sistema BTRFS
- A partição está configurada para ser instalada em dois ssds, '/dev/sda' e '/dev/sdb'
- Ele muda configurações do etc, como /etc/pacman.conf, onde adiciona 'ParallelDownloads = 5' e '[Multilib]', e remove o arquivo /etc/pacman.d/mirrorlist, para criar um novo com mirrors do Brasil e EUA e copia todos esses arquivos para  o /mnt/etc/
- Ele copia o segundo arquivo de instalação, 'arch2'
