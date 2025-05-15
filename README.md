# NixOS Config
This repo contains my NixOS config files. To reuse, download these files to `/etc/nixos/configuration` and run `sudo nixos-rebuild switch`.

- `configuration.nix` - main config file with most of my stuff, packages will be moved to a seperate file later.
- `laptop-power.nix` - TLP optimisations for newer Intel Laptop CPU's (i7-13700H) and general optimisations for improved thermals and performance.
- `nvidia-unload.nix` - Known issues with shutdown when Nvidia drivers are installed (freezing on shutdown screen), this aims to fix that.
- `nvidia.nix` - Installs Nvidia Driver 570.133.07, stable still uses older drivers that are not compatible with latest kernel (required for hardware fixes), this fixes that.
- `ssd.nix` - Enables SSD TRIM, use if SSD is compatible with it.
