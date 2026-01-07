#!/usr/bin/env bash

set  -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"

source "$ROOT/scripts/log.sh"
source "$ROOT/scripts/check.sh"

require_root
require_uefi

log "Starting Gentoo bootstrap"

bash "$ROOT/scripts/disk.sh"
bash "$ROOT/scripts/stage3.sh"
bash "$ROOT/scripts/portage.sh" "$ROOT"
bash "$ROOT/scripts/locales.sh"
bash "$ROOT/scripts/kernel.sh"

log "Bootstrap finished"
