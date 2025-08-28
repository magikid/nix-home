{ config, pkgs, lib, rustPlatform, pkgsUnstable, ... }:
let
  myPhp = pkgs.php82.buildEnv {
      extensions = ({ enabled, all}: enabled ++ (with all; [
        amqp
        apcu
        imagick
        openssl
        redis
        simplexml
        xdebug
        xsl
      ]));
      extraConfig = ''
        xdebug.mode=debug,coverage,develop
        memory_limit=2G
        openssl.cafile="/Users/chrisj/.config/constant/vultr_cacert.pem"
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

    cargoHash = "sha256-OLq1qTgyJ4UGhbYh+V8sxxUrpWvyZRqJGaqPqOb/tc4=";
  };
in
{
  home.packages = [
    pkgs.ansible
    pkgs.consul
    pkgs.ddosify
    pkgs.envsubst
    pkgs.gh
    pkgs.git-credential-manager
    pkgsUnstable.git-sizer
    pkgs.glab
    pkgs.gnupg
    pkgs.go
    pkgs.grafana-alloy
    pkgs.hiera-eyaml
    pkgs.jetbrains.phpstorm
    pkgs.jetbrains.pycharm-community
    pkgsUnstable.jjui
    pkgs.jrnl
    pkgs.k6
    pkgs.kubernetes-helm
    pkgs.kind
    pkgs.kubectl
    pkgs.k9s
    pkgs.libssh2
    mcfly
    (pkgs.php82Packages.composer.override {php = myPhp;})
    myPhp
    pkgs.mysql-client
    pkgs.ncdu
    pkgs.ngrok
    pkgs.nmap
    pkgs.nodejs_22
    pkgs.openssh
    pkgs.parallel
    pkgs.poetry
    pkgsUnstable.puppet
    pkgs.python3
    pkgs.python312Packages.pip
    pkgs.rabbitmqadmin-ng
    pkgs.rubocop
    pkgs.ruby
    pkgs.s3cmd
    pkgs.shfmt
    pkgsUnstable.teleport_17
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
  home.sessionVariables.TELEPORT_TOOLS_VERSION = "off";
  home.sessionVariables.NIX_SSL_CERT_FILE = "/Users/chrisj/.config/constant/vultr_cacert.pem";
  home.sessionVariables.COMPOSER_HOME = "/Users/chrisj/.config/composer";
  home.sessionVariables.EYAML_CONFIG = "/Users/chrisj/.config/eyaml/config.yaml";
  programs.git.userEmail = lib.mkForce "cjones@vultr.com";
  programs.jujutsu.settings.user.email = lib.mkForce "cjones@vultr.com";
  xdg.configFile."jrnl/jrnl.yaml".text = (builtins.readFile text/jrnl.yaml);
  xdg.configFile."jrnl/jrnl.yaml".onChange = ''
    /usr/bin/sudo chmod 777 ${config.home.homeDirectory}/.config/jrnl/jrnl.yaml
  '';
  xdg.configFile."shellcheckrc/shellcheckrc".text = (builtins.readFile text/shellcheckrc);
}
