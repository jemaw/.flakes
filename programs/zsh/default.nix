{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 100000;
      append = true;
      ignoreAllDups = true;
    };

    initExtra = ''
      ${builtins.readFile ./zshrc}
    '';
    profileExtra = ''
      ${builtins.readFile ./zprofile}
    '';
    loginExtra = ''
      ${builtins.readFile ./zlogin}
    '';

    plugins =
      [
      ];

    shellAliases = {
      # programs
      vi = "nvim";
      ra = "yy";
      ag = "rg";
      cat = "bat";
      # python
      py = "python";
      # arch
      pacu = "sudo pacman -Syu";
      paci = "sudo pacman -S";
      # ls
      ls = "eza";
      ll = "eza -lg";

      # git
      g = "git";
      gs = "git status";
      gd = "git diff";
      ga = "git add";
      gaa = "git add --all";
      gc = "git commit";
      gp = "git push";
      glog = "git log --decorate --graph --oneline";

      # configs
      vconf = "nvim ~/.config/nvim/init.vim";
      aconf = "nvim ~/.config/awesome/rc.lua";

      # misc
      sleeep = "echo systemctl suspend | at now +";
      q = "exit";
      pip = "noglob pip";
    };
  };
}
