{
  description = "Home Manager Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/c49d0387e0b2ee9a53f5298eaaa6b2d37809962f";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim-config.url = "github:jemaw/nixvim-config";
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs =
    inputs@{ nixpkgs
    , home-manager
    , nixgl
    , nixvim-config
    , ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nixgl.overlay ];
        config.allowUnfree = true;
      };
    in
    {
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
      defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;

      homeConfigurations.jean = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          ./nixgl_pkgs.nix
        ];
        extraSpecialArgs = {
          nixvim-config = inputs.nixvim-config.packages.${system}.default;
          vscode-extensions = inputs.nix-vscode-extensions.extensions.${system};
        };
      };
    };
}
