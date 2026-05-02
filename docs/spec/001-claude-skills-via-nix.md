# Manage Claude Code skills via Nix

## Overview

Claude Code reads skills from `~/.claude/skills/<name>/SKILL.md` (plus optional supporting files in the same directory). On this machine the directory is currently unmanaged — populated by hand. This spec defines a home-manager module in the user's flake that vendors skills in-repo and installs them declaratively, so skills are version-controlled and reproducible across hosts.

Scope is limited to skills. Other Claude Code configuration (`settings.json`, agents, commands, hooks) is out of scope for this iteration but should be addable to the same module later without rework.

## Requirements

### Module structure
- A new home-manager module exists at `programs/claude.nix` and is imported from `home.nix` alongside the other `programs/*.nix` modules.
- Skill content is vendored under `programs/claude/skills/<name>/`, where each `<name>` directory contains at minimum a `SKILL.md` file with valid frontmatter (`name`, `description`).
- The module exposes an explicit list of enabled skills (e.g. a local `skills = [ "<name>" ... ]` binding). Skills are toggled by adding/removing entries in this list, not by deleting files on disk.

### Installation behavior
- For each enabled skill `<name>`, the module installs the directory `programs/claude/skills/<name>/` to `~/.claude/skills/<name>/` via home-manager's `home.file` mechanism, producing a symlink into the Nix store.
- The installed path is read-only (Nix store semantics). Editing a skill requires editing the source under `programs/claude/skills/<name>/` and rebuilding.
- Skills not in the enabled list have no effect on `~/.claude/skills/`.

### Conflict handling
- The module does **not** set `force = true` on any `home.file` entry.
- If a real (non-symlink) directory already exists at `~/.claude/skills/<name>/` for an enabled skill, home-manager activation must fail with its standard conflict error rather than silently overwriting. This is the intended safety net.
- Resolving such a conflict is a manual user action (rename, move, or delete the existing directory) and is not automated by the module.

### Coexistence with unmanaged skills
- Skills that exist in `~/.claude/skills/` but are not enabled in the module are left untouched by activation. The module only writes to the paths it owns.
- On the current host, the unmanaged skills `explore` and `spec` continue to function unchanged after activation.

### Initial content
- The first revision ships exactly one example skill whose name does not collide with any existing entry in `~/.claude/skills/` on the target host. Its only purpose is to verify the wiring end-to-end.

## Constraints

- Must work with the existing flake (NixOS + home-manager, `claude-code` already provided as an input via `home.nix`). No new flake inputs introduced.
- Pure Nix evaluation — no IFD, no network access at evaluation time, no reliance on `builtins.fetchGit` or similar.
- Must follow the repo's existing convention: home-manager modules under `programs/`, imported from `home.nix`.
- No use of activation scripts to mutate `~/.claude/skills/` outside of what `home.file` does natively.

## Non-goals

- Managing `~/.claude/settings.json`, `~/.claude/settings.local.json`, agents, slash commands, or hooks.
- Migrating the existing hand-placed `explore` and `spec` skills into the module.
- Pulling skills from upstream repositories (Anthropic's published skills or others) as flake inputs.
- Auto-discovery of skill directories — listing is explicit by decision.
- Live-editable installs (writable copies, activation-script copies) — symlinks only.
- Cross-platform concerns beyond what home-manager already abstracts.

## Open questions

- **Naming of the seed skill.** Any name that doesn't collide with `explore` or `spec` on the current host works; the choice is cosmetic and can be decided at implementation time.
- **Future per-skill options.** If skills later need per-entry configuration (e.g. conditional enable per host, extra files), the explicit-list shape may need to evolve into a per-skill attrset or per-skill `.nix` files. Out of scope now; flagged so the initial shape doesn't paint us into a corner.
- **Multi-host divergence.** Whether different hosts (`hosts/nixos`, `hosts/arch`) should be able to enable different skill subsets is unanswered. Current assumption: one shared list for all hosts. If divergence is wanted later, the list moves into a per-host module or becomes a module option.
