{ pkgs
, config
, lib
, namespace
, ...
}:
let
  cfg = config.${namespace}.pack;

  cli-apps = with pkgs; [
    aspell
    btop
    fastfetch
    nushell
    proxychains
    tmux
  ];

  tools = with pkgs; [
    ark
    brightnessctl # Control device brightnes
    ffmpeg
    fzf
    git
    iperf3
    minicom
    mosh
    sshfs
  ];

  nix = with pkgs; [
    manix
    nixos-anywhere
    nixpkgs-fmt
    nurl
  ];

  art = with pkgs; [
    blender
    gimp
    obs-studio
  ];

  charm = with pkgs; [
    charm
    glow
    mods
    pop
    skate
    vhs
    wishlist
  ];

  desktop = with pkgs; [
    banana-cursor
    freecad-wayland
    gparted
    hacksaw
    kdenlive
    kitty
    libreoffice
    localsend
    proton-pass
    protonmail-desktop
    shotgun
    spotify
    vlc
  ];

  python = import ./python.nix { inherit pkgs; } ++ [ pkgs.virtualenv ];

  gaming = with pkgs; [
    steam
    armcord
    protontricks
    bottles
  ];

  dev = with pkgs; [
    just
    go
    gcc
    bun
    nodejs
    nim
    codon
    rust
    quickemu
    thonny
  ];

  hyprland = with pkgs; [
    hypridle
    wl-clipboard-rs
  ];

  network-tools = with pkgs; [
    wireshark
    netscanner
    nmap
    netcat
    rustscan
    whois
    tcpdump
    ngrep
  ];

  android-tools = with pkgs; [
    scrcpy
    adbtuifm
    adb-sync
    adbfs-rootless
  ];

in

{
  options.${namespace}.pack = {
    cli.enable = lib.mkEnableOption "cli";
    tools.enable = lib.mkEnableOption "tools";
    nix.enable = lib.mkEnableOption "nix";
    art.enable = lib.mkEnableOption "art";
    charm.enable = lib.mkEnableOption "charm";
    desktop.enable = lib.mkEnableOption "desktop";
    python.enable = lib.mkEnableOption "python";
    gaming.enable = lib.mkEnableOption "gaming";
    dev.enable = lib.mkEnableOption "dev";
    hyprland.enable = lib.mkEnableOption "hyprland";
    network-tools.enable = lib.mkEnableOption "network-tools";
    mySystem.enable = lib.mkEnableOption "network-tools";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages =
      lib.optional cfg.cli.enable cli-apps
      ++
      lib.optional cfg.tools.enable tools
      ++
      lib.optional cfg.nix.enable nix
      ++
      lib.optional cfg.art.enable art
      ++
      lib.optional cfg.charm.enable charm
      ++
      lib.optional cfg.desktop.enable desktop
      ++
      lib.optional cfg.python.enable python
      ++
      lib.optional cfg.gaming.enable gaming
      ++
      lib.optional cfg.dev.enable dev
      ++
      lib.optional cfg.hyprland.enable hyprland
      ++
      lib.optional cfg.network-tools.enable network-tools
    ;
  };

  nix = lib.mkIf cfg.nix.enable {
    settings = {
      experimental-features = "nix-commands flakes";
      auto-optimise-store = true;
    };
  };

  boot.kernel.sysctl = lib.mkIf cfg.gaming.enable {
    "kernel.sched_cfs_bandwidth_slice_us" = 3000;
    "net.ipv4.tcp_fin_timeout" = 5;
    "vm.max_map_count" = 2147483642;
  };

  ${namespace} = lib.mkIf cfg.mySystem.enable {
    system = {
      locale.enable = true;
      fonts.enable = true;
      time.enable = true;
      xkb.enable = true;
    };
  };
}
