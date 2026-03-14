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
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      nixvim-config,
      noctalia-shell,
      llm-agents,
      ...
    }:
    let
      system = "x86_64-linux";
      nixvim-pkg = nixvim-config.packages.${system}.default;
      claude-code-pkg = llm-agents.packages.${system}.claude-code;
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
          claude-code = claude-code-pkg;
        };
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
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
              claude-code = claude-code-pkg;
            };
          }
        ];
      };
    };
}
