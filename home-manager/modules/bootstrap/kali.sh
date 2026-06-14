set -euo pipefail

# https://github.com/89luca89/distrobox/issues/1673
# Skip if already bootstrapped
if [ -f /root/.first_run_complete ]; then
  exit 0
fi

apt update

# Disable temporarily
#apt install -y kali-linux-headless

# Core utilities
apt install -y \
  curl \
  wget \
  git \
  build-essential \
  python3-pip

# Extract rockyou.txt wordlist
if [ -f /usr/share/wordlists/rockyou.txt.gz ]; then
  gunzip -f /usr/share/wordlists/rockyou.txt.gz
fi

touch /root/.first_run_complete