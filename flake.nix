{
  description = "Home Manager configuration of chrisj";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      "defaultPackage.${system}" = "home-manager.defaultPackage.${system}";
      homeConfigurations = {
        "chrisj" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Specify your home configuration modules here, for example,
            # the path to your home.nix.
            modules = [
              ./home.nix
            ];

            # Optionally use extraSpecialArgs
            # to pass through arguments to home.nix
        };
        "chrisj@VULTR-V4P9HFH" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Specify your home configuration modules here, for example,
            # the path to your home.nix.
            modules = [
              ./home.nix
              ./personal.nix
              ./work.nix
              ./mac-only.nix
            ];

            # Optionally use extraSpecialArgs
            # to pass through arguments to home.nix
        };
        "chrisj@Chriss-Mac-mini" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Specify your home configuration modules here, for example,
            # the path to your home.nix.
            modules = [
              ./home.nix
              ./personal.nix
              ./mac-only.nix
            ];

            # Optionally use extraSpecialArgs
            # to pass through arguments to home.nix
        };
      };
    };
}
