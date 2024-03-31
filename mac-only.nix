{ config, pkgs, lib, ... }:
{
    home.packages = [
        pkgs.iterm2
        pkgs.openssl
    ];
}
