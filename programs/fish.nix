{ config, pkgs, ... }:
{
  # TODO: paths are not underlined properly
  # TODO deduplicate aliases with zsh
  programs.fish = {
    enable = true;

    # Shell aliases similar to ZSH config
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
    };

    # Fish shell initialization
    shellInit = ''
      # Fish doesn't seem to autosource this, zsh
      # seems to autosource /etc/profile.d/nix-daemon.sh
      if test -e /etc/profile.d/nix-daemon.fish
        source /etc/profile.d/nix-daemon.fish
      end

      # Disable greeting
      set fish_greeting

      # Add paths
      fish_add_path ~/bin
      fish_add_path ~/.local/bin
      fish_add_path ~/.cargo/bin
      fish_add_path $GOPATH/bin

      # Vim mode
      fish_vi_key_bindings

      # FZF configuration
      set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git/*"'
    '';

    # Minimal prompt configuration
    interactiveShellInit = ''
      # Configure git prompt settings to match ZSH style
      set -g __fish_git_prompt_showuntrackedfiles 0
      set -g __fish_git_prompt_showdirtystate 1
      set -g __fish_git_prompt_showstashstate 0
      set -g __fish_git_prompt_showupstream 0
      set -g __fish_git_prompt_showcolorhints 0
      set -g __fish_git_prompt_char_dirtystate "!"
      set -g __fish_git_prompt_char_stagedstate "+"
      set -g __fish_git_prompt_char_untrackedfiles ""
      set -g __fish_git_prompt_char_invalidstate ""
      set -g __fish_git_prompt_char_cleanstate ""
      set -g __fish_git_prompt_char_upstream_equal ""
      set -g __fish_git_prompt_char_upstream_behind ""
      set -g __fish_git_prompt_char_upstream_ahead ""
      set -g __fish_git_prompt_char_upstream_diverged ""

      # Minimal prompt using built-in git prompt with custom format
      function fish_prompt
        set -l git_info (fish_git_prompt "%s")
        if test -n "$git_info"
          # Remove the space that fish_git_prompt adds and fix order
          set git_info (string replace -r " " "" $git_info)
          set git_info (string replace -r "([^!+]+)\\+!" '$1!+' $git_info)
          printf " %s » " $git_info
        else
          printf " » "
        end
      end

      function fish_right_prompt
        printf "%s" (prompt_pwd)
      end

      # Disable vi mode prompt indicator
      function fish_mode_prompt
        # Empty function to disable mode indicator
      end

      # Vi mode cursor shapes - use block for insert mode
      set fish_cursor_default block
      set fish_cursor_insert block
      set fish_cursor_replace_one underscore
      set fish_cursor_visual block

      # Set escape timeout to 30ms (like ZSH KEYTIMEOUT)
      set fish_escape_delay_ms 30

      set fish_color_command green
      set fish_color_error red --bold
      set fish_color_autosuggestion brblack

      # Key bindings
      bind -M insert \cj accept-autosuggestion execute
      bind -M insert kj "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
      bind -M default v edit_command_buffer
    '';

    # Abbreviations (Fish equivalent of ZSH global aliases)
    shellAbbrs = {
      T = {
        position = "anywhere";
        expansion = "| tail";
      };
      G = {
        position = "anywhere";
        expansion = "| rg -i";
      };
      C = {
        position = "anywhere";
        expansion = "| wc -l";
      };
      L = {
        position = "anywhere";
        expansion = "| less";
      };
      H = {
        position = "anywhere";
        expansion = "--help | bat --language=help --style=plain";
      };
    };

    plugins = [
      # Add fzf integration for Fish
      {
        name = "fzf-fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "v10.3";
          sha256 = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
        };
      }
    ];
  };
}
