{ pkgs, ... }: 

let

  lain = pkgs.fetchFromGitHub {
    owner = "lcpz";
    repo = "lain";
    rev = "88f5a8abd2649b348ffec433a24a263b37f122c0";
    hash = "sha256-MH/aiYfcO3lrcuNbnIu4QHqPq25LwzTprOhEJUJBJ7I=";
  };
  teleporter = pkgs.fetchFromGitHub {
    owner = "jemaw";
    repo = "hand-tiler";
    rev = "c1dc157f56e8dbb0f75d1aefa3d64e7d87afdf24";
    hash = "sha256-5DTY/WCZ4zCz1Cc/moJCyP5NEizf0f+0aA3tWUs49QA=";
  };
  copycats = pkgs.fetchFromGitHub {
    owner = "lcpz";
    repo = "awesome-copycats";
    rev = "16c16bb16eb1f2d272d6bd85872a05c8c958aeb6";
    hash = "sha256-8CGjbUpfyj2eOu+r87gyOG03FBtY4tvUgMwCl9ohT9E=";
  };

in 

{

  home.file = {
    ".config/awesome" = {
      recursive = true;
      source = ./config;
    };
  };
  home.file = {
    ".config/awesome/lain" = {
      recursive = true;
      source = lain;
    };
  };
  home.file = {
    ".config/awesome/hand-tiler" = {
      recursive = true;
      source = teleporter;
    };
  };
  home.file = {
    ".config/awesome/awesome-copycats" = {
      recursive = true;
      source = copycats;
    };
  };

}
