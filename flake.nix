{
  description = "Home Manager Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim-config.url = "github:jemaw/nixvim-config";
    nixGL = {
      url = "github:guibou/nixGL";
      flake = false;
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, nixGL, nixvim-config, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          # adds nixvim config to the pkgs so we can use it in home.nix
          # (final: prev: {
          #   nixvim = inputs.nixvim.packages.${system}.default;
          # })
        ];
      };
    in
    {
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
      defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;

      homeConfigurations.jean = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          nixvim-config = inputs.nixvim-config.packages.${system}.default;
        };
      };
    };
}
