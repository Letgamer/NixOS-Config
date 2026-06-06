#!/usr/bin/env bash

set -euo pipefail
# Enable this for debugging
#set -o xtrace

# https://github.com/89luca89/distrobox/issues/1673
# Skip if already bootstrapped
if [ -f /root/.first_run_complete ]; then
  exit 0
fi

# Enable color output in pacman
sed -i 's/^#Color/Color/' /etc/pacman.conf

# Populate the pacman keyring
pacman-key --init

# Full system upgrade
pacman -Syu --noconfirm

# Install common utilities
pacman -Sy --noconfirm --needed \
  curl \
  wget \
  vim \
  git \
  base-devel

# Install yay-bin (pre-compiled binary from AUR)
if ! command -v yay &> /dev/null; then
  # do not use /tmp as it is mounted into the container!
  cd /var/tmp
  git clone https://aur.archlinux.org/yay-bin.git

  chown -R user:user /var/tmp/yay-bin

  # Run the build without root
  runuser -u user -- bash -c '
    cd /var/tmp/yay-bin
    makepkg -s --noconfirm
  '

  # Install the built package
  pacman -U --noconfirm /var/tmp/yay-bin/*.pkg.tar.zst

  rm -rf /var/tmp/yay-bin
fi

# mark bootstrap complete
touch /root/.first_run_complete