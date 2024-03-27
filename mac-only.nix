{ config, pkgs, lib, ... }:
{
    home.homeDirectory = lib.mkForce "/Users/chrisj";
}