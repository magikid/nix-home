{ config, pkgs, lib, ... }:
let
  myPhp = pkgs.php82.buildEnv {
      extensions = ({ enabled, all}: enabled ++ (with all; [
        amqp
        apcu
        imagick
        xdebug
      ]));
      extraConfig = ''
        xdebug.mode=debug
        memory_limit=512M
      '';
    };
in
{
  home.packages = [
    pkgs.jetbrains.phpstorm
    pkgs.jetbrains.pycharm-professional
    (pkgs.php82Packages.composer.override {php = myPhp;})
    myPhp

    (pkgs.writeShellScriptBin "phpstorm-url-handler"
      (builtins.readFile bin/phpstorm-url-handler.sh))

    (pkgs.writeShellScriptBin "pstorm" ''
      "${pkgs.jetbrains.phpstorm}/bin/phpstorm.sh" "$@"
    '')
  ];
}
