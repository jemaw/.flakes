{
  pkgs,
  nixvim-config,
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

  fonts.fontconfig.enable = true;
  nixGL = {
    packages = pkgs.nixgl; # you must set this or everything will be a noop
    defaultWrapper = "nvidia";
  };

  home.packages = (standard_packages pkgs) ++ [
    nixvim-config
    pkgs.nixgl.auto.nixGLDefault
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };


  imports = [
    ./programs/awesome
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
