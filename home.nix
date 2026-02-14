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

  targets.genericLinux.enable = true;
  targets.genericLinux.gpu.nvidia = {
    enable = true;
    version = "590.48.01";
    sha256 = "sha256-ueL4BpN4FDHMh/TNKRCeEz3Oy1ClDWto1LO/LWlr1ok=";
  };

  home.packages = (standard_packages pkgs) ++ [
    nixvim-config
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
