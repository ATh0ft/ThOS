{
  description = "NixOS configuration for my laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nvf, agenix, ... }: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };  # ← ADD THIS
      modules = [
        ./hosts/laptop/configuration.nix
        ./modules/nixos_modules/git
        ./modules/nixos_modules/hyprland
        #./secrets/secrets.nix
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default
      ];

    };

    homeConfigurations.laptop = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      modules = [
        nvf.homeManagerModules.default # <- this imports the home-manager module that provides the options
        ./hosts/laptop/home.nix
      ];
      extraSpecialArgs = { inherit inputs; };
    };
  };
}


