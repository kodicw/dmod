{ options
, config
, lib
, pkgs
, namespace
, ...
}:
let
  cfg = config.${namespace}.desktop.packs;

  entertainment-cli = with pkgs; [
    ani-cli # Watch anime from the cli.
    ytfzf # Watch youtube from the cli.
    mpv # Video player.
  ];

  hyprland = with pkgs; [
    grimblast # Helper for screenshots in hyprland.
    swappy # Snapshot editing for hyprland inspired by Macos.
    slurp # Select region for wayland compositor.
    swww # Wallpaper for hyprland
    cliphist # Clipboard cli management
  ];

  audio-video = with pkgs; [
    ffmpeg # Record convert and stream audio.
    pamixer # Pulseaudio cli mixer. 
    motion # Monitor video signals from camera.
  ];

  cli-utils = with pkgs; [
    trash-cli # Cli interface for freedesktop.org trashcan.
    typer # Typing practice in the cli
    tldr # Simplified man pages
    pass # Store passwords
  ];

  desktop = with pkgs; [
    vivaldi # Chromium based web browser 
    google-chrome # Browser with 90% marketshare
    dolphin # File manager.
    rpi-imager
  ];

  ai = with pkgs; [
    ollama
    piper-tts
  ];

in
{
  options.${namespace}.packs = {
    entertainment-cli.enable = lib.mkEnableOption "entertainment-cli";
    hyprland.enable = lib.mkEnableOption "hyprland";
    audio-video.enable = lib.mkEnableOption "audio-video";
    cli-utils.enable = lib.mkEnableOption "cli-utils";
    desktop.enable = lib.mkEnableOption "desktop";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages =
      lib.optional cfg.entertainment-cli.enable entertainment-cli
      ++
      lib.optional cfg.hyprland.enable hyprland
      ++
      lib.optional cfg.audio-video.enable audio-video
      ++
      lib.optional cfg.cli-utils.enable cli-utils
      ++
      lib.optional cfg.desktop.enable desktop
    ;
  };
}
