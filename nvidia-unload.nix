# NVIDIA module unloading for clean shutdown
{ config, lib, pkgs, ... }:

{
  # Add the NVIDIA module unload service to prevent shutdown issues
  systemd.services.nvidia-poweroff = {
    enable = true;
    description = "Unload nvidia modules from kernel";
    documentation = [ "man:modprobe(8)" ];
    unitConfig.DefaultDependencies = "no";
    after = [ "umount.target" ];
    before = [ "shutdown.target" "final.target" ];
    wantedBy = [ "shutdown.target" "final.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "-${pkgs.kmod}/bin/rmmod nvidia_drm nvidia_modeset nvidia_uvm nvidia";
    };
  };
  
  # Add additional NVIDIA modeset option
  boot.extraModprobeConfig = lib.mkIf (!config.boot.extraModprobeConfig?options) ''
    options nvidia-drm modeset=1
  '';
} 