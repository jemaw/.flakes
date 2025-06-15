{ pkgs, ... }:
with pkgs;
[
  # misc
  nil
  nixpkgs-fmt
  nixfmt-rfc-style
  wget
  beautysh
  shellcheck
  # unclutter  # broken on unstable
  zsh-completions

  # scripts
  (writeShellScriptBin "scrotc" (builtins.readFile ./scripts/scrotc.sh))
  (writeShellScriptBin "slp" (builtins.readFile ./scripts/slp.sh))

  # languages
  bash-language-server
  pipx
  ruff
  rustup
  taplo
  uv
  zls
  zig

  # cli tools
  dust
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
  ffmpeg_6

  # TODO get berkeley mono at some point
  dejavu_fonts
  source-serif-pro
  terminus_font

  ghostty
  nerd-fonts.fira-code
  nerd-fonts.droid-sans-mono
  nerd-fonts.blex-mono
  nerd-fonts._0xproto

]
