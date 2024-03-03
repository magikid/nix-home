{ config, pkgs, lib, rustPlatform, ... }:
let
  myPhp = pkgs.php82.buildEnv {
      extensions = ({ enabled, all}: enabled ++ (with all; [
        amqp
        apcu
        imagick
        xdebug
        xsl
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
        --add-flags "--enable-features=UseOzonePlatform,WebRTCPipeWireCapturer"
    '';
  });
  mcfly = pkgs.rustPlatform.buildRustPackage rec {
    pname = "mcfly";
    version = "v0.8.4";

    src = pkgs.fetchFromGitHub {
      owner = "cantino";
      repo = pname;
      rev = version;
      sha256 = "sha256-beoXLTy3XikdZBS0Lh3cugHflNJ51PbqsCE3xtCHpj0=";
    };

    cargoSha256 = "sha256-DywlkQoQoWspqm/5LxJj4XK/HZsgAPYvNpLfy0kqlBc=";
  };
in
{
  home.packages = [
    pkgs.ansible
    pkgs.dbeaver
    pkgs.ddosify
    pkgs.jetbrains.phpstorm
    pkgs.jetbrains.pycharm-professional
    pkgs.k6
    pkgs.kcachegrind
    mcfly
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
  programs.zsh.initExtra = ''
    eval "$(mcfly init zsh)"
    export PROMPT="%(?:$emoji[smiling_face_with_sunglasses]:$emoji[fire])  $PROMPT"
  '';
}
