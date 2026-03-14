{
  pkgs,
  nixvim-config,
  claude-code,
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
    nixvim-config
    claude-code
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
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

}
