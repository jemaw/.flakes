{ pkgs, ... }:
let
  userConfig = import ../user-config.nix;
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
    less.enable = true;
    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        side-by-side = true;
      };
    };
    git = {
      enable = true;
      lfs.enable = true;
      settings.user = {
        email = userConfig.email;
        name = userConfig.fullName;
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
    };

    mpv = {
      enable = true;
    };
    rofi = {
      enable = true;
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
      extraConfig = ''
        local wezterm = require 'wezterm'
        config = wezterm.config_builder()
        local mux = wezterm.mux
        local act = wezterm.action
        config.hide_tab_bar_if_only_one_tab = true
        config.tab_bar_at_bottom = true
        config.use_fancy_tab_bar = false
        config.color_scheme = "Catppuccin Mocha"
        -- config.front_end = "WebGpu"
        config.enable_kitty_keyboard = true
        config.enable_wayland = true

        return config
      '';
    };
    yazi = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        mgr = {
          sort_by = "natural";
          sort_dir_first = true;
          linemode = "size";
        };
      };
      keymap = {
        mgr.prepend_keymap = [
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
      enable = true;
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
        "kdl"
      ];
      userSettings = {
        telemetry.metrics = false;
        vim_mode = true;
        cursor_blink = false;
        theme = "Catppuccin Mocha";
        always_treat_brackets_as_autoclosed = true;
        edit_predictions.mode = "subtle";
        inlay_hints.enabled = true;
      };
      userKeymaps = [
        {
          context = "Workspace";
          bindings = {
            # Seamless bidirectional terminal toggle
            "ctrl-;" = "terminal_panel::ToggleFocus";
            # Create new terminal
            ctrl-shift-t = "workspace::NewTerminal";
          };

        }
        {
          context = "Editor";
          bindings = {
            # Override the conflicting line numbers toggle with terminal toggle
            "ctrl-;" = "terminal_panel::ToggleFocus";
          };
        }
        {
          context = "Editor && VimControl && !VimWaiting && !menu";
          bindings = {
            "space p" = "file_finder::Toggle";
            "space t" = "tab_switcher::Toggle";
            "space n" = "workspace::ToggleLeftDock";
            "space /" = "workspace::NewSearch";
            "space w" = "workspace::Save";
            "space b" = "outline::Toggle";
            "space s" = "project_symbols::Toggle";
          };
        }
        {
          context = "vim_mode == insert";
          bindings = {
            "k j" = [
              "workspace::SendKeystrokes"
              "escape"
            ];
          };
        }
        {
          context = "vim_mode == insert";
          bindings = {
            "j k" = [
              "workspace::SendKeystrokes"
              "escape : w enter"
            ];
          };
        }

      ];

    };
  };
}
