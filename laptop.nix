{ config, pkgs, lib, ... }:
{
  home.packages = [
    pkgs.jetbrains.phpstorm
    pkgs.jetbrains.pycharm-professional
    (pkgs.php83.buildEnv {
      extensions = ({ enabled, all}: enabled ++ (with all; [
        amqp
        imagick
        xdebug
      ]));
      extraConfig = ''
        xdebug.mode=debug
      '';
    })
    pkgs.php83Packages.composer

    (pkgs.writeShellScriptBin "phpstorm-url-handler"
      (builtins.readFile bin/phpstorm-url-handler.sh))

    (pkgs.writeShellScriptBin "pstorm" ''
      "${pkgs.jetbrains.phpstorm}/bin/phpstorm.sh" "$@"
    '')
  ];
}
