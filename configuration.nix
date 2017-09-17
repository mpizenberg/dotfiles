# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "eve"; # Define your hostname.
    networkmanager.enable = true;
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # wireless.networks.CISCO_IPAL = { psk = "putpasswordhere"; };
  };


  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "fr-bepo";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Activate the automatic nix garbage collector (here every night at 03:15)
  nix.gc.automatic = true;
  nix.gc.dates = "03:15";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    curl
    netcat
    rsync
    nano
    vim
    neovim
    terminator
    tmux
    htop
    git
    glxinfo
    openvpn
    firefox
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Keyboard configuration
    layout = "fr";
    xkbVariant = "bepo";
    # xkbOptions = "eurosign:e";

    # Touchpad configuration
    libinput = {
      enable = true;
      tapping = false;
      sendEventsMode = "disabled-on-external-mouse";
    };

    # Choosing the Display Manager (login)
    displayManager.lightdm.enable = true;
    # displayManager.sddm.enable = true;

    # Choosing the Desktop Environment.
    # desktopManager.plasma5.enable = true;
    desktopManager.gnome3.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.matthieu = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.09";

}
