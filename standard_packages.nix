{ pkgs, ... }:
let
  enpass = import ./pkgs/enpass.nix { inherit pkgs; };
in
with pkgs;
[
  # apps
  brave
  discord
  enpass
  evince
  firefox
  imv
  gamescope
  ladybird
  mpv
  nautilus
  obsidian
  signal-desktop

  # misc
  beautysh
  bubblewrap
  gcc
  hyprpicker
  nil
  nixpkgs-fmt
  nixfmt
  usbutils
  shellcheck
  socat
  wget
  # unclutter  # broken on unstable
  zsh-completions

  # scripts
  (writeShellScriptBin "scrotc" (builtins.readFile ./scripts/scrotc.sh))
  (writeShellScriptBin "slp" (builtins.readFile ./scripts/slp.sh))

  # languages
  bash-language-server
  nodejs
  pipx
  pnpm
  nasm
  ruff
  rustup
  taplo
  typst
  uv
  zls
  zig

  # cli tools
  wl-clipboard
  herdr
  dust
  btop
  cowsay
  evcxr
  fastfetch
  ncdu
  nix-output-monitor
  ripgrep
  scrot
  xclip
  ffmpeg_6

  # TODO get berkeley mono at some point
  dejavu_fonts
  source-serif-pro
  terminus_font

  nerd-fonts.fira-code
  nerd-fonts.droid-sans-mono
  nerd-fonts.blex-mono
  nerd-fonts._0xproto

]
