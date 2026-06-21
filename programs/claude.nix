{ pkgs, ... }:
let
  skills = [
    "hello-nix"
    "spec-interview"
  ];

  mkSkill = name: {
    name = ".claude/skills/${name}/SKILL.md";
    value = {
      source = ./claude/skills/${name}/SKILL.md;
    };
  };

  settings = {
    sandbox.enabled = true;
    permissions.defaultMode = "auto";
    spinnerVerbs = {
      mode = "replace";
      verbs = [ "" ];
    };
    statusLine = {
      type = "command";
      command = "${pkgs.bash}/bin/bash ${./claude/statusline.sh}";
    };
  };

  settingsFile = (pkgs.formats.json { }).generate "claude-settings.json" settings;
in
{
  home.file = builtins.listToAttrs (map mkSkill skills) // {
    ".claude/settings.json".source = settingsFile;
  };
}
