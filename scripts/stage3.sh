#!/usr/bin/env bash

# AMD64
OPENRC="https://distfiles.gentoo.org/releases/amd64/autobuilds/20260106T094555Z/stage3-amd64-openrc-20260106T094555Z.tar.xz"
SYSTEMD="https://distfiles.gentoo.org/releases/amd64/autobuilds/20260105T081601Z/stage3-amd64-systemd-20260105T081601Z.tar.xz"

# Maybe some file verification after wget ?

cd /mnt/gentoo
wget "$OPENRC"
tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner -C /mnt/gentoo

# Installing base system

cp --dereference /etc/resolv.conf /mnt/gentoo/etc/

mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run
