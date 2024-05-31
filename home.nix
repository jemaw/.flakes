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

  xsession.windowManager.xmonad = {
    enable = true;
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
  # normal packages installed via nix
  home.packages = with pkgs; [
    # misc
    nixpkgs-fmt
    nixfmt-rfc-style
    wget
    beautysh
    shellcheck
    nixgl.auto.nixGLDefault

    # scripts
    (writeShellScriptBin "scrotc"
      (builtins.readFile ./scripts/scrotc.sh))

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
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "DroidSansMono"
        "IBMPlexMono"
      ];
    })
  ];
}



