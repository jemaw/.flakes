{
  pkgs,
  ...
}:
let
  userConfig = import ./user-config.nix;
  standard_packages = import ./standard_packages.nix;
in
{
  home.username = userConfig.username;
  home.homeDirectory = "/home/${userConfig.username}";
  home.stateVersion = "23.11";

  home.packages = (standard_packages pkgs) ++ [
    pkgs.llm-agents.claude-code
    pkgs.llm-agents.pi
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  home.pointerCursor = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  imports = [
    ./programs/awesome
    ./programs/niri.nix
    ./programs/tmux.nix
    ./programs/fish.nix
    ./programs/alacritty.nix
    ./programs/vscode.nix
    ./programs/standard.nix
    ./programs/ghostty.nix
    ./programs/zsh.nix
    ./programs/claude.nix
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/jpeg" = "imv.desktop";
      "image/png" = "imv.desktop";
      "image/gif" = "imv.desktop";
      "image/webp" = "imv.desktop";
      "image/svg+xml" = "imv.desktop";
      "image/bmp" = "imv.desktop";
      "image/tiff" = "imv.desktop";
    };
  };

  xsession.windowManager.xmonad = {
    enable = false;
    enableContribAndExtras = true;
    config = ./programs/xmonad/xmonad.hs;
  };

  xsession.windowManager.awesome = {
    enable = false;
    noArgb = true;
  };

}
