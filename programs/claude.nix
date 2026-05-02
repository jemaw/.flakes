{ ... }:
let
  skills = [
    "hello-nix"
  ];

  mkSkill = name: {
    name = ".claude/skills/${name}/SKILL.md";
    value = {
      source = ./claude/skills/${name}/SKILL.md;
    };
  };
in
{
  home.file = builtins.listToAttrs (map mkSkill skills);
}
