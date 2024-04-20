{ ... }:
{
  programs.alacritty = {
    #enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window.padding = {
        x = 4;
        y = 4;
      };
      font = {
        normal = {
          family = "Blex Mono Nerd Font";
        };
        size = 13;
      };
    };

  };
}
