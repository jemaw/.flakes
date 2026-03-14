{
  description = "Home Manager Dotfiles";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim-config = {
      url = "github:jemaw/nixvim-config";
    };
    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      nixvim-config,
      noctalia-shell,
      ...
    }:
    let
      system = "x86_64-linux";
      nixvim-pkg = nixvim-config.packages.${system}.default;
      unfreePackages = [
        "discord"
        "enpass"
        "obsidian"
        "vscode"
        "vscode-extension-MS-python-vscode-pylance"
        "vscode-extension-ms-vsliveshare-vsliveshare"
        "vscode-extension-ms-vscode-remote-remote-ssh"
      ];
    in
    {
      # TOOD: make it work on darwin
      packages.x86_64-linux.default = home-manager.packages.x86_64-linux.default;
      formatter.x86_64-linux = nixpkgs.legacyPackages.${system}.nixfmt;

      homeConfigurations.jean = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./hosts/arch/home.nix
          {
            nixpkgs.config.nvidia.acceptLicense = true;
            nixpkgs.config.allowUnfreePredicate =
              pkg: builtins.elem (nixpkgs.lib.getName pkg) (unfreePackages ++ [ "nvidia" "nvidia-x11" ]);
          }
        ];

        extraSpecialArgs = {
          nixvim-config = nixvim-pkg;
        };
      };

      nixosConfigurations.nixos = nixpkgs-stable.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [
              noctalia-shell.homeModules.default
              {
                home.enableNixpkgsReleaseCheck = false;
                nixpkgs.config.allowUnfreePredicate =
                  pkg: builtins.elem (nixpkgs.lib.getName pkg) unfreePackages;
              }
            ];
            home-manager.users.jean = import ./hosts/nixos/home.nix;
            home-manager.extraSpecialArgs = {
              nixvim-config = nixvim-pkg;
            };
          }
        ];
      };
    };
}
