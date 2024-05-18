{ vscode-extensions, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with vscode-extensions; [
      open-vsx-release.rust-lang.rust-analyzer
      vscode-marketplace.golang.go
      vscode-marketplace.bbenoist.nix
      vscode-marketplace.ms-python.vscode-pylance
      vscode-marketplace.ms-vsliveshare.vsliveshare
      vscode-marketplace.ms-vscode-remote.remote-ssh
      vscode-marketplace.redhat.ansible
      vscode-marketplace.njpwerner.autodocstring
      vscode-marketplace.redhat.vscode-xml
      vscode-marketplace.redhat.vscode-yaml
      vscode-marketplace.serayuzgur.crates
      vscode-marketplace.tamasfe.even-better-toml
      vscode-marketplace.vscodevim.vim
      vscode-marketplace.yzhang.markdown-all-in-one
      vscode-marketplace.ziglang.vscode-zig
    ];
    userSettings = {
      "window.menuBarVisibility" = "toggle";
      "vim.easymotion" = true;
      "vim.incsearch" = true;
      "vim.useSystemClipboard" = true;
      "vim.useCtrlKeys" = true;
      "vim.hlsearch" = true;
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
}
