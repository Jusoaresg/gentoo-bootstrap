#!/usr/bin/env bash

chroot /mnt/gentoo /usr/bin/env bash <<EOF 
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen
eselect locale set en_us.UTF-8
EOF
