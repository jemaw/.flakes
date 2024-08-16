{ pkgs, ... }:

# for non NixOS setups nixGL wraps graphical programs
# implementation based on: https://github.com/alexisquintero/nix/blob/master/nixgl/pkgs.nix
# needs impure on the home-maanger install:
# home-manager switch --impure --flake .  

let
  glWrap = (
    pkg: name:
      pkgs.writeShellScriptBin "${name}" ''
        ${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL ${pkg}/bin/${name} "$@"
      ''
  );
  wrapped_vscode = glWrap pkgs.vscode "code" // {
    pname = pkgs.vscode.pname;
    version = pkgs.vscode.version;
  };

  shellIntegrationStrwezterm = ''
    source "${pkgs.wezterm}/etc/profile.d/wezterm.sh"
  '';

in
{

  programs = {
    kitty.package = (glWrap pkgs.kitty "kitty");
    alacritty.package = (glWrap pkgs.alacritty "alacritty");
    rofi.package = (glWrap pkgs.rofi "rofi");
    vscode.package = wrapped_vscode;
    wezterm.package = (glWrap pkgs.wezterm "wezterm");
    zsh.initExtra = shellIntegrationStrwezterm;
  };
}
