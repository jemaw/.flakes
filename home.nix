{
  pkgs,
  nixvim-config,
  config,
  ...
}:
let
  username = "jean";
  user = "jm.wanka";
  mail = user + "@gmail.com";
  wrapper = config.lib.nixGL.wrap;
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
    enable = true;
    enableContribAndExtras = true;
    config = ./programs/xmonad/xmonad.hs;
  };

  xsession.windowManager.awesome = {
    enable = false;
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
    kitty = {
      enable = true;
      package = wrapper pkgs.kitty;
    };
    mpv = {
      enable = true;
      package = wrapper pkgs.mpv;
    };
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
      keymap = {
        manager.prepend_keymap = [
          {
            on = [
              "g"
              "m"
            ];
            run = "cd /media";
            desc = "cd /media";
          }

          {
            on = [
              "g"
              "M"
            ];
            run = "cd /mnt";
            desc = "cd /mnt";
          }

          {
            on = [
              "g"
              "t"
            ];
            run = "cd /tmp";
            desc = "cd /tmp";
          }

          {
            on = [
              "g"
              "/"
            ];
            run = "cd /";
            desc = "cd /";
          }
        ];
      };
    };

    rofi = {
      enable = true;
      package = wrapper pkgs.rofi;
    };
    wezterm = {
      enable = true;
      enableZshIntegration = true;
      package = wrapper pkgs.wezterm;
      extraConfig = ''
        local wezterm = require 'wezterm'
        config = wezterm.config_builder()
        local mux = wezterm.mux
        local act = wezterm.action
        config.hide_tab_bar_if_only_one_tab = true
        config.tab_bar_at_bottom = true
        config.use_fancy_tab_bar = false
        config.color_scheme = "Catppuccin Mocha"
        config.front_end = "WebGpu"

        return config
      '';
    };
  };
}
