{ pkgs, ... }:
with pkgs; [
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
]
