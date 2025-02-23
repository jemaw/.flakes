{
  description = "Home Manager Dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim-config = {
      url = "github:jemaw/nixvim-config";
    };
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nixgl,
      nixvim-config,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nixgl.overlay ];
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
          inherit standard_packages;
          nixvim-config = inputs.nixvim-config.packages.${system}.default;
          vscode-extensions = inputs.nix-vscode-extensions.extensions.${system};

        };
      };
    };
}
