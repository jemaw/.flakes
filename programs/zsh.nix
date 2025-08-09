{ config, ... }:
{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;
    # enable for debugging startup time
    # zprof.enable = true;

    history = {
      size = 100000;
      append = true;
      ignoreAllDups = true;
    };

    initContent = ''
      autoload -Uz edit-command-line vcs_info promptinit
      zmodload zsh/complist
      zle -N edit-command-line

      # Paths
      export CARGO_BIN="$HOME/.cargo/bin"

      # Ensure path arrays do not contain duplicates.
      typeset -gU cdpath fpath mailpath path gopath

      # Set the list of directories that Zsh searches for programs.
      path=(
          ~/bin
          ~/.local/bin
          /usr/local/{bin,sbin}
          $path
          $GOPATH/bin
          $SPARK_BIN
          $CARGO_BIN
      )

      # cd movement
      # use cd -<TAB> and cd +<TAB> to navigate dir stack
      setopt autocd autopushd pushdminus pushdsilent pushdtohome
      DIRSTACKSIZE=5

      # completion
      # enable menu completion
      zstyle ':completion:*' menu select

      # option colors
      zstyle ':completion:*:options' list-colors '=^(-- *)=34'
      # verbose Output
      zstyle ':completion:*' verbose yes

      # group completion candidates in groups (example no<TAB>)
      zstyle ':completion:*:descriptions' format '%U%B%d%b%u' # shows group name
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*:messages' format '%d'

      # completion caching for speedup
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' rehash yes

      # kill completions
      zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
      zstyle ':completion:*:kill:*' command 'ps -u $USER --forest -o pid,%cpu,tty,cputime,cmd'
      # show kill completion even when there is only one match
      zstyle ':completion:*:*:kill:*' menu yes select
      zstyle ':completion:*:kill:*' force-list always
      zstyle ':completion:*:*:killall:*' menu yes select
      zstyle ':completion:*:killall:*' force-list always

      # bindkeys
      #vim mode
      bindkey -v
      bindkey "^A" beginning-of-line
      bindkey "^E" end-of-line

      # Open in editor.
      bindkey -M vicmd 'v' edit-command-line

      # Avoid Esc
      bindkey -M viins 'kj' vi-cmd-mode
      # Time in ms to wait for sequences
      KEYTIMEOUT=30

      # prompt
      # command substitution (needed for vcs prompt)
      setopt prompt_subst
      # rprompt only current prompt
      setopt transient_rprompt

      zstyle ':vcs_info:*' enable git svn
      zstyle ':vcs_info:git*' formats " %b%m%u%c% "
      zstyle ':vcs_info:*' check-for-changes true
      zstyle ':vcs_info:*' unstagedstr '!'
      zstyle ':vcs_info:*' stagedstr '+'

      PROMPT_SIGN='»'

      precmd () { vcs_info }
      PROMPT='$'{vcs_info_msg_0_}' $PROMPT_SIGN %f%b'
      RPROMPT='%~'

      # global aliases
      # Automatically Expanding Global Aliases (Space key to expand)
      globalias() {
          if [[ $LBUFFER =~ '[A-Z0-9]+$' ]]; then
              zle _expand_alias
              zle expand-word
          fi
          zle self-insert
      }
      zle -N globalias
      bindkey " " globalias                 # space key to expand globalalias
      bindkey "^[[Z" magic-space            # shift-tab to bypass completion
      bindkey -M isearch " " magic-space    # normal space during searches

      # global aliases
      alias -g T='| tail'
      alias -g G='| rg -i'
      alias -g C='| wc -l'
      alias -g L='| less'
      alias -g H='--help | bat --language=help --style=plain'

      # plugin configuration
      bindkey -M vicmd 'k' history-substring-search-up
      bindkey -M vicmd 'j' history-substring-search-down
      typeset -g HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true
      typeset -g HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=fg,bold'
      typeset -g HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,bold'

      # zsh-users/zsh-autosuggestions
      bindkey '^ '  autosuggest-execute
      bindkey '^J'  autosuggest-execute
    '';

    plugins = [
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
