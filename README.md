# Installation

Run the following on the Nixos Installer:

```bash
git clone https://github.com/Letgamer/NixOS-Config

cd NixOS-Config

sudo nix --extra-experimental-features "nix-command flakes" \
    run 'github:nix-community/disko/latest#disko-install' -- \
    --flake .#surface \
    --disk main /dev/sda
```
