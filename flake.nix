{
  description = "Home Manager configuration of chrisj";

  inputs = {
    nixpkgs-fix-ghostscript.url = "github:nixos/nixpkgs/aecd17c0dbd112d6df343827d9324f071ef9c502";
    nixpkgs.follows = "nixpkgs-fix-ghostscript";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, nixpkgs-unstable, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgsUnstable = nixpkgs-unstable.legacyPackages.${system};
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
              ./work.nix
              ./mac-only.nix
            ];

            # Optionally use extraSpecialArgs
            # to pass through arguments to home.nix
            extraSpecialArgs = { inherit pkgsUnstable; };
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
            extraSpecialArgs = { inherit pkgsUnstable; };
        };
      };
    };
}
