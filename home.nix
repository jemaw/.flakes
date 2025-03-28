{
  pkgs,
  nixvim-config,
  ...
}:
let
  username = "jean";
  standard_packages = import ./standard_packages.nix;
in
{
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
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

  home.file = {
    ".config/ghostty/config" = {
      source = ./configs/ghostty;
    };
  };

  imports = [
    ./programs/awesome
    ./programs/tmux.nix
    ./programs/zsh
    ./programs/alacritty.nix
    ./programs/vscode.nix
    ./programs/standard.nix
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
