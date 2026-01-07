#!/usr/bin/env bash

: "${DISK:?Define DISK}"

[[ -b "$DISK" ]] || { echo "DISK doesn't exist"; exit 1; }

TYPE=$(lsblk -no TYPE "$DISK" | head -n 1)
[[ "$TYPE" == "disk" ]] || { echo "DISK is not a disk"; exit 1; }

RM=$(lsblk -no RM "$DISK" | head -n 1 )
[[ "$RM" == "0" ]] || { echo "DISK can't be removable"; exit 1; }

SIZE=$(lsblk -b -no SIZE "$DISK" | head -n 1 ) 
(( SIZE > 20 * 1024 * 1024 * 1024 )) || { echo "DISK too small"; exit 1; }

echo "Selected disk: $DISK"

sgdisk --zap-all "$DISK"

# EFI
sgdisk -n 1:0:+1GB -t 1:ef00 "$DISK"

# SWAP
sgdisk -n 2:0:+8G -t 2:8200 "$DISK"

# ROOT
sgdisk -n 3:0:0 -t 3:8300 "$DISK"

mkfs.vfat -F32 "${DISK}1"
mkswap "${DISK}2"
mkfs.ext4 -F "${DISK}3"

swapon "${DISK}2"

mkdir -p /mnt/gentoo
mount "${DISK}3" /mnt/gentoo
mkdir -p /mnt/gentoo/efi
mount "${DISK}1" /mnt/gentoo/efi

lsblk "$DISK"
