{ pkgs, config, ... }:
let
  user = "jm.wanka";
  mail = user + "@gmail.com";
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
      userEmail = mail;
      userName = "Jean Wanka";
      delta.options = {
        side-by-side = true;
      };
    };
    htop.enable = true;
    info.enable = true;
    jq.enable = true;
    kitty = {
      enable = true;
      package = wrapper pkgs.kitty;
    };
    home-manager.enable = true;
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

  };
}
