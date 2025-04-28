{ pkgs, ... }:
with pkgs; [
  ark
  brightnessctl # Control device brightnes
  ffmpeg
  fzf
  git
  iperf3
  minicom
  mosh
  sshfs
]
