#!/usr/bin/env bash
set -e -u -o pipefail

WGDIR="/var/lib/wireguard"

if [ "$#" -ne "2" ]; then
  echo >&2 "usage: $0 ALIAS TARGET"
  echo >&2 ""
  echo >&2 "Generates a new PSK for ALIAS on the bastion host, and installs it on TARGET."
  echo >&2 ""
  echo >&2 "example: $0 nix-cache 1.2.3.4"
fi

alias="${1}"
target="${2}"

# Generate a new PSK on the bastion host
psk="$(command ssh bastion "sudo sh -c 'umask 0077; wg genpsk | tee ${WGDIR}/psk-${alias}'")"

if [ "${target}" == "localhost" ]; then
  # Install the PSK locally
  dir="/nix/persist${WGDIR}" 
  sudo install -d -m 0700 "$dir"
  sudo sh -c "umask 0077; echo '$psk' > ${dir}/presharedkey"
else
  # Install the psk on the target system
  command ssh "$target" "sudo sh -c 'install -d -m 0700 ${WGDIR}; umask 0077; echo ${psk} > ${WGDIR}/presharedkey'"
fi
