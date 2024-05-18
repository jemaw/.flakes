let
  user = "jm.wanka";
  mail = user + "@gmail.com";
in
{

  imports = [
    ./tmux.nix
    ./zsh
    ./alacritty.nix
    ./vscode.nix
  ];

  programs.home-manager.enable = true;
  programs.starship = {
    enable = false;
    settings = {
      add_newline = false;
    };
  };
  programs.fish.enable = true;
  programs.yt-dlp.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.fzf.enable = true;
  programs.jq.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.htop.enable = true;
  programs.info.enable = true;
  programs.git = {
    enable = true;
    delta.enable = true;
    lfs.enable = true;
    userEmail = mail;
    userName = "Jean Wanka";
    delta.options = {
      side-by-side = true;
    };
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      manager = {
        sort_by = "natural";
        sort_dir_first = true;
      };
    };
  };

  programs.rofi.enable = true;
}
