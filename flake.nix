{
  description = "Home Manager Dotfiles";

  inputs = {
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim-config = {
      url = "github:jemaw/nixvim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:nix-community/nixGL";
    ghostty = {
      url = "github:ghostty-org/ghostty";

      # NOTE: The below 2 lines are only required on nixos-unstable,
      # if you're on stable, they may break your build
      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nixgl,
      nixvim-config,
      ghostty,
      ...
    }:
    let
      system = "x86_64-linux";
      ghostty_overlay = (final: prev: { ghostty = inputs.ghostty.packages.${system}.default;});
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nixgl.overlay ghostty_overlay ];
        config.allowUnfreePredicate =
          pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [
            "nvidia"
            "vscode"
          ];
      };
      standard_packages = import ./standard_packages.nix;
    in
    {
      # TOOD: make it work on darwin
      inherit standard_packages;
      packages.x86_64-linux.default = home-manager.defaultPackage.x86_64-linux;
      formatter.x86_64-linux = pkgs.nixfmt-rfc-style;

      homeConfigurations.jean = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
        extraSpecialArgs = {
          standard_packages = standard_packages;
          nixvim-config = inputs.nixvim-config.packages.${system}.default;
          vscode-extensions = inputs.nix-vscode-extensions.extensions.${system};
        };
      };
    };
}
