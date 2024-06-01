{ pkgs, nixvim-config, ... }:
let
  username = "jean";
  user = "jm.wanka";
  mail = user + "@gmail.com";
in
{
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  fonts.fontconfig.enable = true;

  # programs with config inside home-manager
  imports = [
    ./programs/awesome
    ./programs/tmux.nix
    ./programs/zsh
    ./programs/alacritty.nix
    ./programs/vscode.nix
  ];

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

  programs = {
    home-manager.enable = true;
    starship = {
      enable = false;
      settings = {
        add_newline = false;
      };
    };
    fish.enable = true;
    yt-dlp.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fzf.enable = true;
    jq.enable = true;
    bat.enable = true;
    eza.enable = true;
    htop.enable = true;
    info.enable = true;
    git = {
      enable = true;
      delta.enable = true;
      lfs.enable = true;
      userEmail = mail;
      userName = "Jean Wanka";
      delta.options = {
        side-by-side = true;
      };
    };

    yazi = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        manager = {
          sort_by = "natural";
          sort_dir_first = true;
        };
      };
    };

    rofi.enable = true;
  };
}



