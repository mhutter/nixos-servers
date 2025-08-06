#!/usr/bin/env bash
set -e -u -o pipefail

fqdn="$1"
shift
host="$(echo "$fqdn" | cut -d '.' -f 1)"

set -x
nixos-rebuild \
  --max-jobs auto \
  --builders "ssh://${fqdn} x86_64" \
  --flake ".#${host}" \
  --sudo \
  --build-host "$fqdn" \
  --target-host "$fqdn" \
  $@
