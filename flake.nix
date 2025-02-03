{
  description = "Liren's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Lirens-MacBook-Pro
    darwinConfigurations."Lirens-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        ./modules/workflow.nix
        ./modules/common.nix
        ./modules/proscia.nix
        ./modules/pta.nix
      ];
      specialArgs = { inherit inputs; };
    };

    # $ darwin-rebuild build --flake .#Lirens-MacBook-Air
    darwinConfigurations."Lirens-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [
        ./modules/workflow.nix
        ./modules/common.nix
        ./modules/proscia.nix
        ./modules/pta.nix
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
