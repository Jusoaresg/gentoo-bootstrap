#!/usr/bin/env bash

EFI_UUID=$(blkid -s UUID -o value "${DISK}1"
SWAP_UUID=$(blkid -s UUID -o value "${DISK}2"
ROOT_UUID=$(blkid -s UUID -o value "${DISK}3"

GENTOO="/mnt/gentoo"
FSTAB="${GENTOO}/etc/fstab"

cat > "$FSTAB" <<EOF
UUID=$ROOT_UUID / ext4 defaults,noatime 0 1
UUID=$SWAP_UUID none swap sw 0 0
UUID=$EFI_UUID /efi vfat umask=0077 0 2
EOF

echo gentoo > "${GENTOO}/etc/hostname"
sed -i 's/keymap="us"/keymap="br"/' "${GENTOO}/etc/conf.d/keymaps"

chroot /mnt/gentoo /usr/bin/env bash <<EOF 

emerge net-misc/dhcpcd
rc-update add dhcpcd default
rc-service dhcpcd start

emerge app-admin/sysklogd
rc-update add sysklogd default

emerge sys-process/cronie
rc-update add cronie default

emerge net-misc/chrony
rc-update add chronyd default

rc-update add sshd default

emerge sys-apps/mlocate
emerge app-shells/bash-completion

EOF
