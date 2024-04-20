{ ... }:
{
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    historyLimit = 406000;
    clock24 = true;
    terminal = "xterm-256color";
  };
}
