{ ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      gtk-titlebar = false;
      gtk-tabs-location = "bottom";
      gtk-wide-tabs = false;
      cursor-style = "block";
      shell-integration-features = "no-cursor";
      cursor-style-blink = false;
      theme = "catppuccin-mocha";
      window-padding-y = 28;
      window-padding-x = 4;
    };
  };
}
