{ pkgs, ... }:
with pkgs;
[
  # misc
  nixpkgs-fmt
  nixfmt-rfc-style
  wget
  beautysh
  shellcheck
  nixgl.auto.nixGLDefault
  unclutter
  zsh-completions

  # scripts
  (writeShellScriptBin "scrotc" (builtins.readFile ./scripts/scrotc.sh))
  (writeShellScriptBin "slp" (builtins.readFile ./scripts/slp.sh))

  # languages
  micromamba
  pipx
  rustup
  zig
  uv

  # cli tools
  btop
  cowsay
  evcxr
  ncdu
  neofetch
  nix-output-monitor
  ripgrep
  silver-searcher
  scrot
  xclip

  # TODO get berkeley mono at some point
  dejavu_fonts
  source-serif-pro
  terminus_font
  (nerdfonts.override {
    fonts = [
      "FiraCode"
      "DroidSansMono"
      "IBMPlexMono"
    ];
  })

]
