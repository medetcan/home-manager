{
  description = "Home Manager configuration of can";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};

      mkHome = profile: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = { inherit inputs profile; };
        modules = [ ./home.nix ];
      };
    in
    {
      homeConfigurations = {
        "personal" = mkHome {
          username = "can";
          homeDirectory = "/Users/can";
          email = "medet@canakus.com";
        };
        "work" = mkHome {
          username = "medet.akus";
          homeDirectory = "/Users/medet.akus";
          email = "medet.akus@axelspringer.com";
        };
      };
    };
}
