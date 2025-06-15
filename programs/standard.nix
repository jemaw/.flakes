{ pkgs, config, ... }:
let
  userConfig = import ../user-config.nix;
  wrapper = config.lib.nixGL.wrap;
in
{
  programs = {
    bat.enable = true;
    eza.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fish.enable = true;
    fzf.enable = true;
    git = {
      enable = true;
      delta.enable = true;
      lfs.enable = true;
      userEmail = userConfig.email;
      userName = userConfig.fullName;
      delta.options = {
        side-by-side = true;
      };
    };
    helix = {
      enable = true;
      settings = {
        theme = "ayu_dark";
      };
      languages = {
        language-server.typescript-language-server = with pkgs.nodePackages; {
          command = "${typescript-language-server}/bin/typescript-language-server";
          args = [
            "--stdio"
            "--tsserver-path=${typescript}/lib/node_modules/typescript/lib"
          ];
        };

        language-server.rust-analyzer.config.check = {
          command = "clippy";
        };

        language = [
          {
            name = "nix";
            auto-format = true;
            formatter = {
              command = "nixfmt";
            };
          }
          {
            name = "rust";
            auto-format = true;
          }
        ];
      };
    };
    home-manager.enable = true;
    htop.enable = true;
    info.enable = true;
    jq.enable = true;
    kitty = {
      enable = true;
      package = wrapper pkgs.kitty;
    };

    mpv = {
      enable = true;
      package = wrapper pkgs.mpv;
    };
    rofi = {
      enable = true;
      package = wrapper pkgs.rofi;
    };
    starship = {
      enable = false;
      settings = {
        add_newline = false;
      };
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
    yazi = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        manager = {
          sort_by = "natural";
          sort_dir_first = true;
          linemode = "size";
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
    yt-dlp.enable = true;

    zed-editor = {
      enable = false;
      extraPackages = [ pkgs.nixd ];
      extensions = [
        "dockerfile"
        "haskell"
        "html"
        "lua"
        "make"
        "nix"
        "proto"
        "toml"
        "zig"
      ];
      userSettings = {
        telemetry.metrics = false;
        vim_mode = true;
        cursor_blink = false;
        theme = "Tokyo Night";
      };
      userKeymaps = [
        {
          context = "Workspace";
          bindings = {
            ctrl-shift-t = "workspace::NewTerminal";
          };

        }
        {
          context = "Editor";
          bindings = {
            "k j" = [
              "workspace::SendKeystrokes"
              "escape"
            ];
          };
        }

      ];

    };
  };
}
