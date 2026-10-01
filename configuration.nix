{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  # Networking
  networking.networkmanager.enable = true;

  # User
  # Replace YOUR_USER with your actual username.
  users.users.YOUR_USER = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  # NVIDIA RTX 5070
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Login manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Audio
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  # Apps and utilities
  environment.systemPackages = with pkgs; [
    # Desktop
    quickshell
    kitty
    hyprpaper
    hyprlock
    hypridle
    hyprpolkitagent

    # Wayland tools
    wl-clipboard
    grim
    slurp

    # Apps
    librewolf
    discord
    onlyoffice-desktopeditors
    vscode
    codex

    # CLI tools
    git
    curl
    wget
    unzip
    btop

    # C / C++
    gcc
    clang
    cmake
    ninja
    gdb
    lldb
    pkg-config

    # Rust
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Keep this equal to the NixOS version used for the initial installation.
  system.stateVersion = "26.05";
}
