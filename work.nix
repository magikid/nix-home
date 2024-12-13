{ config, pkgs, lib, rustPlatform, pkgsUnstable, ... }:
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
        memory_limit=2G
      '';
    };
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
    pkgs.consul
    pkgs.ddosify
    pkgs.git-credential-manager
    pkgsUnstable.git-sizer
    pkgs.go
    pkgs.gnupg
    pkgs.jetbrains.phpstorm
    pkgs.jetbrains.pycharm-community
    pkgs.k6
    pkgs.kubernetes-helm
    pkgs.kind
    pkgs.k9s
    pkgs.libssh2
    mcfly
    (pkgs.php82Packages.composer.override {php = myPhp;})
    myPhp
    pkgs.mysql-client
    pkgs.nmap
    pkgs.nodejs_20
    pkgs.nomad
    pkgs.openssh
    pkgs.poetry
    pkgs.python3
    pkgs.rubocop
    pkgs.ruby
    pkgs.s3cmd
    pkgs.shfmt
    pkgs.slack
    pkgs.teleport_14
    pkgs.terraform
    pkgs.vault
    pkgs.vscode
    pkgs.vultr-cli
    pkgs.yq-go
    pkgs.yubikey-manager
    pkgs.yubikey-personalization

    (pkgs.writeShellScriptBin "phpstorm-url-handler"
      (builtins.readFile bin/phpstorm-url-handler.sh))

    (pkgs.writeShellScriptBin "pstorm" ''
      "${pkgs.jetbrains.phpstorm}/bin/phpstorm.sh" "$@"
    '')
  ];
  programs.zsh.initExtra = ''
    eval "$(mcfly init zsh)"
    export PROMPT="%(?:$emoji[smiling_face_with_sunglasses]:$emoji[fire])  $PROMPT"
    export NIX_SSL_CERT_FILE="$XDG_CONFIG_HOME/constant/internal-chain.crt"
    source <(kubectl completion zsh)
  '';
}
