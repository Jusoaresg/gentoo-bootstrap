#!/usr/bin/env bash

set  -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"

source "$ROOT/scripts/log.sh"
source "$ROOT/scripts/check.sh"

require_root
require_uefi

log "Testing"
