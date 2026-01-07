#!/usr/bin/env bash

require_root() {
	[[ $EUID -eq 0 ]] || { echo "Run as admin"; exit 1; }
}

require_uefi() {
	[[ -d /sys/firmware/efi ]] || { echo "UEFI required"; exit 1; }
}
