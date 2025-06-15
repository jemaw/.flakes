{
  config,
  pkgs,
  ...
}:
let
  wrapper = config.lib.nixGL.wrap;
in
{
  programs.vscode = {
    enable = true;
    package = wrapper pkgs.vscode;
    profiles.default = {
      extensions = with pkgs; [
        vscode-extensions.rust-lang.rust-analyzer
        vscode-extensions.golang.go
        vscode-extensions.bbenoist.nix
        vscode-extensions.ms-python.vscode-pylance
        vscode-extensions.ms-vsliveshare.vsliveshare
        vscode-extensions.ms-vscode-remote.remote-ssh
        vscode-extensions.redhat.ansible
        vscode-extensions.njpwerner.autodocstring
        vscode-extensions.redhat.vscode-xml
        vscode-extensions.redhat.vscode-yaml
        vscode-extensions.serayuzgur.crates
        vscode-extensions.tamasfe.even-better-toml
        vscode-extensions.vscodevim.vim
        vscode-extensions.yzhang.markdown-all-in-one
        vscode-extensions.ziglang.vscode-zig
      ];
      userSettings = {
        "window.menuBarVisibility" = "toggle";
        "vim.easymotion" = true;
        "vim.incsearch" = true;
        "vim.useSystemClipboard" = true;
        "vim.useCtrlKeys" = true;
        "vim.hlsearch" = true;
        "terminal.integrated.fontFamily" = "Blex Mono Nerd Font";
        "vim.insertModeKeyBindings" = [
          {
            "before" = [
              "k"
              "j"
            ];
            "after" = [
              "<Esc>"
            ];
          }
          {
            "before" = [
              "k"
              "j"
              "s"
            ];
            "after" = [
              "<Esc>"
            ];
            "commands" = [
              {
                "command" = ":w";
              }
            ];
          }
        ];
        "vim.leader" = "<space>";
        "vim.normalModeKeyBindingsNonRecursive" = [
          {
            "before" = [
              "<C-h>"
            ];
            "after" = [
              "<C-w>"
              "h"
            ];
          }
          {
            "before" = [
              "<C-j>"
            ];
            "after" = [
              "<C-w>"
              "j"
            ];
          }
          {
            "before" = [
              "<C-k>"
            ];
            "after" = [
              "<C-w>"
              "k"
            ];
          }
          {
            "before" = [
              "<C-l>"
            ];
            "after" = [
              "<C-w>"
              "l"
            ];
          }
          {
            "before" = [
              "Y"
            ];
            "after" = [
              "y"
              "$"
            ];
          }
          {
            "before" = [
              "<C-right>"
            ];
            "commands" = [
              "=tabnext"
            ];
          }
          {
            "before" = [
              "<C-left>"
            ];
            "commands" = [
              "=tabprev"
            ];
          }
          {
            "before" = [
              "leader"
              "w"
            ];
            "after" = [ ];
            "commands" = [
              {
                "command" = "workbench.action.files.save";
                "args" = [ ];
              }
            ];
          }
        ];
        "vim.handleKeys" = {
          "<C-a>" = false;
          "<C-f>" = false;
          "<C-p>" = false;
        };
      };
      keybindings = [
        {
          "key" = "ctrl+enter";
          "command" = "workbench.action.terminal.focus";
        }
        {
          "key" = "ctrl+enter";
          "command" = "workbench.action.focusActiveEditorGroup";
          "when" = "terminalFocus";
        }
      ];
    };
  };
}
