{ pkgs, nixvim-config, ... }:
let
  username = "jean";
in
{
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";
  fonts.fontconfig.enable = true;

  # programs with config inside home-manager
  imports = [ ./programs ];

  # normal packages installed via nix
  home.packages = with pkgs; [
    # misc
    nixpkgs-fmt
    nixfmt-rfc-style
    nix
    wget
    beautysh
    shellcheck

    # languages
    micromamba
    pipx
    rustup
    zig

    # cli tools
    nix-output-monitor
    cowsay
    ripgrep
    btop
    neofetch
    ncdu
    evcxr
    ueberzugpp # image display in terminals

    # programs
    nixvim-config

    # TODO get berkeley mono at some point
    dejavu_fonts
    source-serif-pro
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "IBMPlexMono" ]; })
  ];


}
