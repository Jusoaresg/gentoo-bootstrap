#!/usr/bin/env bash

ROOT=$1
PORTAGE="/mnt/gentoo/etc/portage"
rsync -av --progress "$ROOT/portage/make.conf" "${PORTAGE}/make.conf"
rsync -av --progress "$ROOT/portage/binrepos.conf" "$PORTAGE"

chroot /mnt/gentoo /usr/bin/env bash <<EOF 
emerge-webrsync
emerge --sync
getuto

emerge --oneshot app-portage/cpuid2cpuflags
echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags
echo "*/* VIDEO_CARDS: amdgpu radeonsi" > /etc/portage/package.use/00video_cards
EOF
