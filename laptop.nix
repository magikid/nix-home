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
  slack = pkgs.slack.overrideAttrs (old: {
    installPhase = old.installPhase + ''
      rm $out/bin/slack

      makeWrapper $out/lib/slack/slack $out/bin/slack \
        --prefix XDG_DATA_DIRS : $GSETTINGS_SCHEMAS_PATH \
        --prefix PATH : ${lib.makeBinPath [pkgs.xdg-utils]} \
        --add-flags "--ozone-platform=wayland --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer"
    '';
  });
in
{
  home.packages = [
    pkgs.ansible
    pkgs.ddosify
    pkgs.jetbrains.phpstorm
    pkgs.jetbrains.pycharm-professional
    pkgs.kcachegrind
    (pkgs.php82Packages.composer.override {php = myPhp;})
    myPhp
    pkgs.nixos-rebuild
    slack
    pkgs.vlc
    pkgs.vscode

    (pkgs.writeShellScriptBin "phpstorm-url-handler"
      (builtins.readFile bin/phpstorm-url-handler.sh))

    (pkgs.writeShellScriptBin "pstorm" ''
      "${pkgs.jetbrains.phpstorm}/bin/phpstorm.sh" "$@"
    '')
  ];
}
