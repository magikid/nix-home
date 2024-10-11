{ config, pkgs, lib, ... }:

with lib;

{
    config = mkIf pkgs.stdenv.hostPlatform.isDarwin {
        home.packages = with pkgs; [
            dockutil
            iterm2
            openssl
        ];

        programs.zsh.shellAliases.c = mkForce "pbcopy";
        programs.zsh.shellAliases.v = mkForce "pbpaste";

        # Install MacOS applications to the user Applications folder. Also update Docked applications
        home.activation = {
            aliasApplications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
                ORIGIFS=$IFS
                IFS=$'\n\t'
                app_folder=$(echo ~/Applications/Home\ Manager\ Trampolines);
                for app in $(find "$genProfilePath/home-path/Applications" -type l); do
                    echo "Linking $app to $app_folder"
                    $DRY_RUN_CMD rm -f $app_folder/$(basename $app)
                    $DRY_RUN_CMD /usr/bin/osascript -e "tell app \"Finder\"" -e "make new alias file at POSIX file \"$app_folder\" to POSIX file \"$app\"" -e "set name of result to \"$(basename $app)\"" -e "end tell"
                done
                IFS=$ORIGIFS
            '';
        };
    };
}
