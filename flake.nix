{
  description = "Home Manager Dotfiles";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim-config = {
      url = "github:jemaw/nixvim-config";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim-config,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      # TOOD: make it work on darwin
      packages.x86_64-linux.default = home-manager.packages.x86_64-linux.default;
      formatter.x86_64-linux = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;

      homeConfigurations.jean = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home.nix
          {
            nixpkgs.config.nvidia.acceptLicense = true;
            nixpkgs.config.allowUnfreePredicate =
              pkg:
              builtins.elem (nixpkgs.lib.getName pkg) [
                "nvidia"
                "nvidia-x11"
                "vscode"
                "vscode-extension-MS-python-vscode-pylance"
                "vscode-extension-ms-vsliveshare-vsliveshare"
                "vscode-extension-ms-vscode-remote-remote-ssh"
              ];
          }
        ];

        extraSpecialArgs = {
          nixvim-config = nixvim-config.packages.${system}.default;
        };
      };
    };
}
