#!/usr/bin/env bash
set -e -u -o pipefail

name="$1"
shift
fqdn="$1"
shift

set -x
nixos-rebuild \
  --max-jobs auto \
  --builders "ssh://${fqdn} x86_64" \
  --flake ".#${name}" \
  --sudo \
  --build-host "$fqdn" \
  --target-host "$fqdn" \
  $@
