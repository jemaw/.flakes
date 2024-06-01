{ pkgs, nixvim-config, ... }:
let
  username = "jean";
  # lain = pkgs.fetchFromGitHub {
  #   owner = "lcpz";
  #   repo = "lain";
  #   rev = "88f5a8abd2649b348ffec433a24a263b37f122c0";
  #   hash = "sha256-MH/aiYfcO3lrcuNbnIu4QHqPq25LwzTprOhEJUJBJ7I=";
  # };
  # teleporter = pkgs.fetchFromGitHub {
  #   owner = "jemaw";
  #   repo = "hand-tiler";
  #   rev = "c1dc157f56e8dbb0f75d1aefa3d64e7d87afdf24";
  #   hash = "sha256-5DTY/WCZ4zCz1Cc/moJCyP5NEizf0f+0aA3tWUs49QA=";
  # };
  # copycats = pkgs.fetchFromGitHub {
  #   owner = "lcpz";
  #   repo = "awesome-copycats";
  #   rev = "16c16bb16eb1f2d272d6bd85872a05c8c958aeb6";
  #   hash = "sha256-8CGjbUpfyj2eOu+r87gyOG03FBtY4tvUgMwCl9ohT9E=";
  # };
in
{
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  fonts.fontconfig.enable = true;

  # programs with config inside home-manager
  imports = [ ./programs ];

  xsession.windowManager.xmonad = {
    enable = false;
    enableContribAndExtras = true;
    config = pkgs.writeText "xmonad.hs" ''
      import XMonad
      main = xmonad defaultConfig
          { terminal    = "alacritty"
          , modMask     = mod4Mask
          , borderWidth = 3
          }
    '';
  };

  xsession.windowManager.awesome = {
    enable = true;
    noArgb = true;
  };

  # normal packages installed via nix
  home.packages = with pkgs; [
    # misc
    nixpkgs-fmt
    nixfmt-rfc-style
    wget
    beautysh
    shellcheck
    nixgl.auto.nixGLDefault
    unclutter

    # scripts
    (writeShellScriptBin "scrotc"
      (builtins.readFile ./scripts/scrotc.sh))
    (writeShellScriptBin "slp"
      (builtins.readFile ./scripts/slp.sh))

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
    scrot
    xclip

    # programs
    nixvim-config
    # i3lock somehow does not accept correct passowrds


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
  ];
}



