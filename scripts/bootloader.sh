#!/usr/bin/env bash

chroot /mnt/gentoo /usr/bin/env bash <<EOF 

echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
emerge sys-boot/grub
emerge sys-boot/os-prober

grub-install --efi-directory=/efi
grub-mkconfig -o /efi/grub/grub.cfg

EOF
