{
    programs.ssh = {
        controlMaster = "auto";
        controlPath = "/tmp/ssh-%C";
        controlPersist = "yes";
        enable = true;
        extraConfig = ''
            TCPKeepAlive yes
        '';
        matchBlocks = {
            "*" = {
                extraOptions = {
                    visualHostKey = "yes";
                };
                forwardAgent = true;
            };

            "*.repo.borgbase.com" = {
                extraOptions = {
                    controlMaster = "no";
                    controlPersist = "no";
                };
                identityFile = "~/.ssh/2021_borg_id_ed25519";
            };

            "git.hilandchris.com" = {
                port = 2222;
                identityFile = "~/.ssh/gogs";
            };

            "zoidberg.vpn.hilandchris.com" = {
                port = 1102;
            };

            "truenas.hilandchris.com" = {
                extraOptions = {
                    preferredAuthentications = "password";
                    pubkeyAuthentication = "no";
                };
            };

            "load-balancer-2" = {
                hostname = "192.168.104.29";
                extraOptions = {
                    preferredAuthentications = "password";
                    pubkeyAuthentication = "no";
                };
            };

            "gitlab.choopa.com" = {
                user = "git";
                identityFile = "/Users/chrisj/.ssh/id_ed25519_sk_yk1";
            };
        };
        serverAliveInterval = 5;
        serverAliveCountMax = 2;
    };
}
