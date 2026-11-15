# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include the necessary packages and configuration for Apple Silicon support
      ./apple-silicon-support
    ];

  # Enable basic nixos-apple-silicon support.
  hardware.asahi.enable = true;


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  users.users.mufeedcm = {
   isNormalUser = true;
   extraGroups = [ "wheel" "networkmanager" "video" "input" "uinput" ];
   shell = pkgs.zsh;
  };
  security.sudo.enable = true;

  nix.settings.max-jobs = 2;
  nix.settings.cores = 2;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk];
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  programs.zsh.enable = true;

  systemd.services.kmonad = {
    description = "kmonad";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.kmonad}/bin/kmonad /home/mufeedcm/.config/kmonad/config.kbd";
      Restart = "always";
    };
  };

  nixpkgs.config.allowUnfree = true;
	
  environment.systemPackages = with pkgs; [ 
    vim
    git
    curl
    wget
    tmux
    neovim
    wezterm
    waybar
    rofi
    firefox
    zoxide
    kmonad
    hyprlock
    hypridle
    hyprpaper
    hyprpicker
    hyprsunset
    hyprshot
    swaynotificationcenter
    feh
    zathura
    nemo
    gh
    pnpm
    nodejs_latest
    fastfetch
    emacs
    gcc
    syncthing
    adwaita-icon-theme
    fd
    ripgrep
    fzf
    tree
    ncmpcpp

    libnotify
    wl-clipboard
    brightnessctl
    playerctl
    btop

    #ai
    opencode
    antigravity-cli
    codex
    claude-code
    github-copilot-cli

 ];

fonts.packages = with pkgs; [
  inter
  nerd-fonts.jetbrains-mono
  noto-fonts
  noto-fonts-color-emoji
];

fonts.fontconfig = {
  enable = true;
  defaultFonts = {
    serif = [ "Noto Serif" ];
    sansSerif = [ "Inter" ];
    monospace = [ "JetBrainsMono Nerd Font" ];
    emoji = [ "Noto Color Emoji" ];
  };
};
environment.sessionVariables = {
  HYPRCURSOR_THEME = "Adwaita";
  HYPRCURSOR_SIZE = "24";
  XCURSOR_THEME = "Adwaita";
  XCURSOR_SIZE = "24";
};

  nix.settings.experimental-features = [
  "nix-command" 
  "flakes"
  ];

  services.syncthing = {
    enable = true;
    user = "mufeedcm";
    group = "users";
    dataDir = "/home/mufeedcm/.config/syncthing";
    configDir = "/home/mufeedcm/.config/syncthing";
    openDefaultPorts = true;
  };

  networking.hostName = "mufeedcm"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  # For ` to < and - to > (for those with US keyboards)
  boot.extraModprobeConfig = ''
    options hid_apple iso_layout=0
  '';

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  # };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.11"; # Did you read the comment?

}

