{
  description = "Home Manager Dotfiles";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim-config = {
      url = "github:jemaw/nixvim-config";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixvim.follows = "nixvim";
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
      home-manager,
      nixvim,
      nixvim-config,
      noctalia-shell,
      llm-agents,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ llm-agents.overlays.default ];
      };
      nixvimModules = [
        nixvim.homeModules.nixvim
        nixvim-config.homeManagerModules.default
      ];
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
      formatter.x86_64-linux = nixpkgs.legacyPackages.${system}.nixfmt-tree;

      homeConfigurations.jean = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./hosts/arch/home.nix
          {
            nixpkgs.config.nvidia.acceptLicense = true;
            nixpkgs.config.allowUnfreePredicate =
              pkg:
              builtins.elem (nixpkgs.lib.getName pkg) (
                unfreePackages
                ++ [
                  "nvidia"
                  "nvidia-x11"
                ]
              );
          }
        ]
        ++ nixvimModules;
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [ llm-agents.overlays.default ];
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.sharedModules = [
              noctalia-shell.homeModules.default
              {
                home.enableNixpkgsReleaseCheck = false;
                nixpkgs.overlays = [ llm-agents.overlays.default ];
                nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) unfreePackages;
              }
            ]
            ++ nixvimModules;
            home-manager.users.jean = import ./hosts/nixos/home.nix;
          }
        ];
      };
    };
}
