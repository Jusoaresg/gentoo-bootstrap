#!/usr/bin/env bash

chroot /mnt/gentoo /usr/bin/env bash <<EOF 

emerge sys-kernel/linux-firmware
emerge sys-firmware/sof-firmware

echo 'sys-kernel/installkernel grub dracut' >> /etc/portage/package.use/installkernel
emerge sys-kernel/installkernel

emerge sys-kernel/gentoo-kernel-bin
EOF
