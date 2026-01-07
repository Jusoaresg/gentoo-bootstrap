#!/usr/bin/env bash

chroot /mnt/gentoo /usr/bin/env bash <<EOF 

echo 'sys-kernel/installkernel grub dracut' >> /etc/portage/package.use/installkernel

emerge sys-kernel/linux-firmware \
	sys-firmware/sof-firmware \
	sys-kernel/installkernel \
	sys-kernel/gentoo-kernel-bin
EOF
