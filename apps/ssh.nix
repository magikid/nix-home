{
    programs.ssh = {
        controlMaster = "auto";
        controlPath = "/tmp/ssh-%h-%p-%r";
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
        };
        serverAliveInterval = 5;
        serverAliveCountMax = 2;
    };
}
