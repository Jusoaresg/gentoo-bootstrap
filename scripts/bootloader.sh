#!/usr/bin/env bash

chroot /mnt/gentoo /usr/bin/env bash <<EOF 

echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
emerge sys-boot/grub

grub-install --efi-directory=/efi
grub-mkconfig -o /boot/grub/grub.cfg

EOF
