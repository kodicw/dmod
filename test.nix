{ pkgs, config, lib, namespace, ... }@args:

let
  cfg = config.${namespace}.packs;

  packDefs = {
    cli = with pkgs; [ aspell btop fastfetch nushell proxychains tmux ];
    tools = with pkgs; [ ark brightnessctl ffmpeg fzf git iperf3 minicom mosh sshfs ];
    nix = with pkgs; [ manix nixos-anywhere nixpkgs-fmt nurl ];
    art = with pkgs; [ blender gimp obs-studio ];
    charm = with pkgs; [ charm glow mods pop skate vhs wishlist ];
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
    gaming = with pkgs; [ steam armcord protontricks bottles ];
    dev = with pkgs; [ just go gcc bun nodejs nim codon rust quickemu thonny ];
    hyprland = with pkgs; [ hypridle wl-clipboard-rs ];
    network-tools = with pkgs; [ wireshark netscanner nmap netcat rustscan whois tcpdump ngrep ];
    android-tools = with pkgs; [ scrcpy adbtuifm adb-sync adbfs-rootless ];
  };

  packOptions = lib.attrsets.mapAttrs (_: _v: lib.mkEnableOption "Enable this pack") packDefs;

  enabledPackages = lib.flatten (
    lib.attrsets.mapAttrsToList
      (name: pkgsList:
        lib.optionals (cfg.${name}.enable or false) pkgsList
      )
      packDefs
  );

in
{
  options.${namespace}.packs = packOptions // {
    mySystem.enable = lib.mkEnableOption "my system config";
    openssh.enable = lib.mkEnableOption "OpenSSH";
  };

  config = {
    environment.systemPackages = enabledPackages;

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
  };
}

