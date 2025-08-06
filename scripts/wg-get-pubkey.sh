#!/usr/bin/env bash
set -e -u -o pipefail

if [ "$#" -ne "1" ]; then
  echo >&2 "usage: $0 HOSTNAME"
  echo >&2 ""
  echo >&2 "Fetches the public WireGuard key from a remote host"
fi

command ssh "$1" 'sudo sh -c "wg pubkey < /var/lib/wireguard/private"'
