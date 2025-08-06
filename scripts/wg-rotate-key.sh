#!/usr/bin/env bash
set -e -u -o pipefail

WGDIR="/var/lib/wireguard"

if [ "$#" -ne "1" ]; then
  echo >&2 "usage: $0 TARGET"
  echo >&2 ""
  echo >&2 "Generates a new private key on TARGET, and echos its public key."
fi

command ssh "${1}" "sudo sh -c 'install -d -m 0700 ${WGDIR}; umask 0077; wg genkey | tee ${WGDIR}/private | wg pubkey'"
