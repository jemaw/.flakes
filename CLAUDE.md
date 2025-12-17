# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Nix home-manager configuration that manages dotfiles and system packages using Nix flakes. The configuration targets x86_64-linux systems and includes various development tools, window managers, and terminal applications.

## Key Commands

- `home-manager switch --flake .#jean --impure` - Apply configuration changes (requires --impure flag)
- `nix flake update` - Update flake.lock to latest versions
- `nix fmt` - Format Nix files using nixfmt-rfc-style
- `nix flake check` - Validate flake configuration

## Architecture

The configuration follows a modular structure with clear separation of concerns:

### Core Files
- `flake.nix` - Main flake definition with four inputs: nixpkgs, home-manager, nixvim-config (external), and nixGL
- `home.nix` - Central configuration that imports all program modules and sets up the home environment
- `user-config.nix` - User-specific settings (username, email, full name) referenced by other modules
- `standard_packages.nix` - Package list as a function that returns a list of derivations

### Module System
- `programs/standard.nix` - Program configurations that use the programs.* options (git, helix, kitty, wezterm, zed-editor, yazi, etc.)
- `programs/tmux.nix`, `programs/fish.nix`, `programs/zsh.nix`, `programs/ghostty.nix`, `programs/alacritty.nix`, `programs/vscode.nix` - Individual program module files
- `programs/awesome/` and `programs/xmonad/` - Window manager configurations (XMonad enabled by default, Awesome disabled)

### Important Patterns

**nixGL Integration**: The configuration uses nixGL overlay for OpenGL applications on non-NixOS systems. Programs requiring GPU access are wrapped using `config.lib.nixGL.wrap` (see `programs/standard.nix:3-4` for the wrapper pattern). The wrapper is applied to packages like kitty, mpv, rofi, and wezterm.

**External Flake Integration**: The nixvim-config is imported as an external flake input and passed via `extraSpecialArgs` to be available in home.nix as a package.

**Custom Scripts**: Shell scripts in `scripts/` directory are packaged as derivations using `writeShellScriptBin` in standard_packages.nix (e.g., scrotc and slp scripts).

**Unfree Package Handling**: Specific unfree packages (nvidia, vscode, vscode extensions) are allowlisted by name in flake.nix using `allowUnfreePredicate`.

## Configuration Details

- Default editor: nvim (from external nixvim-config flake)
- Default nixGL wrapper: nvidia
- Window manager: XMonad (awesome.enable = false in home.nix)
- Home state version: "23.11"
- All Nix files use auto-formatting with nixfmt-rfc-style
