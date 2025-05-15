# Laptop power management configuration for Legion Slim 7i (i7-13700H)
{ config, lib, pkgs, ... }:

{
  # Enable TLP and Thermald for better power management
  services.tlp = {
    enable = true;
    settings = {
      # CPU settings optimized for i7-13700H (hybrid architecture)
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      
      # Intel P-state settings (Raptor Lake)
      CPU_HWP_ON_AC = "performance";
      CPU_HWP_ON_BAT = "balance_power";
      
      # Performance settings
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 80;
      
      # Allow turbo boost on AC, but limit on battery
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      
      # Power saving for scheduler
      SCHED_POWERSAVE_ON_AC = 0;
      SCHED_POWERSAVE_ON_BAT = 1;
      
      # Disable NMI Watchdog (saves power)
      NMI_WATCHDOG = 0;
      
      # Energy performance policy
      ENERGY_PERF_POLICY_ON_AC = "performance";
      ENERGY_PERF_POLICY_ON_BAT = "power";
      
      # SATA power management
      SATA_LINKPWR_ON_AC = "max_performance";
      SATA_LINKPWR_ON_BAT = "min_power";
      AHCI_RUNTIME_PM_TIMEOUT = 15;
      
      # PCIe power management
      PCIE_ASPM_ON_AC = "performance";
      PCIE_ASPM_ON_BAT = "powersave";
      
      # Runtime power management
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
      
      # Disable NVIDIA power management (handled by nvidia.nix)
      RUNTIME_PM_DRIVER_BLACKLIST = "nvidia";
      
      # WiFi power saving
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";
      
      # Disable wake on LAN
      WOL_DISABLE = "Y";
      
      # Audio power saving
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";
      
      # USB autosuspend
      USB_AUTOSUSPEND = 1;
      USB_BLACKLIST_BTUSB = 0;
      USB_BLACKLIST_PHONE = 0;
      USB_BLACKLIST_WWAN = 1;
      
      # Device state restoration
      RESTORE_DEVICE_STATE_ON_STARTUP = 0;
      
      # Network device management
      DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi wwan";
      DEVICES_TO_DISABLE_ON_WIFI_CONNECT = "wwan";
      DEVICES_TO_DISABLE_ON_WWAN_CONNECT = "wifi";
      DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi wwan";
      
      # Battery thresholds for Legion laptop
      # These help extend battery lifespan
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 85;
    };
  };
  
  # Enable thermald for better thermal management
  services.thermald.enable = true;
  
  # Enable auto-cpufreq as complementary power management
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
  
  # Enable ACPI events handling
  services.acpid.enable = true;
  
  # Add powertop auto-tune service for additional power savings
  # Uncomment if you want to use powertop's auto-tune
  # systemd.services.powertop = {
  #   description = "Powertop auto-tune";
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "multi-user.target" ];
  #   path = [ pkgs.powertop ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.powertop}/bin/powertop --auto-tune";
  #   };
  # };
  
} 