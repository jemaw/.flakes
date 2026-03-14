{
  pkgs,
  nixvim-config,
  ...
}:
{
  imports = [ ../../home.nix ];

  programs.noctalia-shell.enable = true;
}
