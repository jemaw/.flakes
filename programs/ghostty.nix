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
      window-padding-y = 8;
      window-padding-x = 4;
    };
  };
}
