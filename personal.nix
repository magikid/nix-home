{ config, pkgs, lib, rustPlatform, pkgsUnstable, ... }:
let
  mcfly = pkgs.rustPlatform.buildRustPackage rec {
    pname = "mcfly";
    version = "v0.8.4";

    src = pkgs.fetchFromGitHub {
      owner = "cantino";
      repo = pname;
      rev = version;
      sha256 = "sha256-beoXLTy3XikdZBS0Lh3cugHflNJ51PbqsCE3xtCHpj0=";
    };

    cargoHash = "sha256-OLq1qTgyJ4UGhbYh+V8sxxUrpWvyZRqJGaqPqOb/tc4=";
  };
in
{
  home.packages = [
    mcfly
    pkgs.ansible
    pkgs.avrdude
    pkgs.awscli2
    pkgs.black
    pkgs.coursier
    pkgs.cyberduck
    pkgs.ddosify
    pkgs.dfu-util
    pkgs.element-desktop
    pkgs.ffmpeg
    pkgs.flyctl
    pkgs.gcc-arm-embedded
    pkgs.getmail6
    pkgs.gnupg
    pkgs.go
    pkgs.jetbrains.phpstorm
    pkgs.k6
    pkgs.k9s
    pkgs.kind
    pkgs.kubectl
    pkgs.mkdocs
    pkgs.mpd
    pkgs.ncmpcpp
    pkgs.nixos-rebuild
    pkgs.nmap
    pkgs.nodejs_20
    pkgs.openssh
    pkgs.packer
    pkgs.php84
    pkgs.php84Packages.composer
    pkgs.python3
    pkgs.rubocop
    pkgs.sbt
    pkgs.symfony-cli
    pkgs.temurin-bin-17
    pkgs.terraform
    pkgs.vscode
    pkgs.yq-go
    pkgs.yt-dlp
    pkgs.yubikey-manager
    pkgs.yubikey-personalization
    pkgsUnstable.jjui
    pkgsUnstable.ruby
    pkgsUnstable.vscodium

    (pkgs.writeShellScriptBin "phpstorm-url-handler"
      (builtins.readFile bin/phpstorm-url-handler.sh))

    (pkgs.writeShellScriptBin "pstorm" ''
      "${pkgs.jetbrains.phpstorm}/bin/phpstorm.sh" "$@"
    '')
  ];
}
