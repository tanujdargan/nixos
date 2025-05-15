# SSD Trim Support
# Check if TRIM is supported by doing: lsblk --discard
# if it is then uncomment the import in configuration.nix
services.fstrim.enable = true;