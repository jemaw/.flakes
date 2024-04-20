  let
    user = "jm.wanka";
    mail = user + "@gmail.com";
  in 
{

  imports = [
    ./tmux.nix
    ./zsh
  ];

  programs.home-manager.enable = true;
  programs.starship = {
    enable = false;
    settings = {
      add_newline = false;
    };
  };
  programs.fish.enable = true;
  programs.yazi.enable = true;
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

  # things that don't work yet
  # TODO: find good way with nixgl
  # imports = [ ./alacritty.nix ];
  programs.rofi.enable = false; # needs nixgl (probably)


}
