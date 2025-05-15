{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nvidia.nix #Nvidia Drivers not from stable NixOS pkgs with Intel HD Drivers
      ./nvidia-unload.nix #NVIDIA module unloading for clean shutdown
      # ./laptop-power.nix #TLP and power management optimized for i7-13700H on the Legion Slim 7i (untested)
      # ./trim.nix #SSD Trim Support uncomment if supported
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #Bluetooth Support
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  nix.settings.experimental-features = "nix-command flakes";

  #Potential Firmware fix
  hardware.enableAllFirmware = true;

  #Fix for LS7i Speakers:
  boot.extraModprobeConfig = ''options snd-intel-dspcfg dsp_driver=1'';

  #Latest Kernel:
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "td-legion-slim-7i"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  # Power Management for Laptop - Now managed in laptop-power.nix
  # services.tlp.enable = true;
  # services.tlp.settings = {
  #   CPU_SCALING_GOVERNOR_ON_AC = "ondemand";
  #   CPU_SCALING_GOVERNOR_ON_BAT = "ondemand";
  #   CPU_MAX_PERF_ON_AC = 100;
  #   CPU_MAX_PERF_ON_BAT = 100;
  #   
  # };
  # services.thermald.enable = true;
  # services.auto-cpufreq.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.tanujd = {
    isNormalUser = true;
    description = "Tanuj Dargan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      kdePackages.okular
      kdePackages.kdeconnect-kde
      nvtopPackages.nvidia
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  wget
  brave
  spotify
  spicetify-cli
  obsidian
  code-cursor
  powertop
  tlp
  auto-cpufreq
  obs-studio
  vesktop
  thermald
  slack
  alsa-utils
  qbittorrent
  git
  wget
  cmake
  alacritty
  gcc
  kitty
  nodejs
  tailscale
  vlc
  lenovo-legion
  curl
  htop
  unstable.ghidra
  steam-run-native
  gparted
  lm_sensors
  telegram-desktop
  nodejs_22
  openssh
  pnpm
  zip
  unzip
  rustup
  neofetch
  acpi

  (python3.withPackages
  (ps:
    with ps; [
      jupyter
      matplotlib
      numpy
      pep8
      requests
      scipy
      setuptools
      virtualenv
    ]))
  ];

}
