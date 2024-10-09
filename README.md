# nix-home

My nix home manager configuration.  This will eventually replace my [dotfiles](https://github.com/magikid/LinuxConfigFiles/) repository and maybe even my [ansible](https://github.com/magikid/ansible) repository once I get NixOS figured out.

## Usage

This repository expects nix to already be installed.  See [home-manager docs](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone) for info on how to install home-manager.  Once nix and home-manager are installed, clone this repository to `~/.config/home-manager` and run `home-manager switch` to activate the configuration.

1. Install [Nix](https://nixos.org/download/)
2. Clone this repo to ~/.config/home-manager
  ```
  mkdir -p ~/.config/home-manager
  git clone https://github.com/magikid/nix-home.git ~/.config/home-manager
  ```
3. Install Home Manager
  ```
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
  nix-channel --update
  nix-shell '<home-manager>' -A install
  ```
4. Wait
5. Reopen your terminal.  You may want to reboot too.



## Useful links:

- https://nix-community.github.io/home-manager
- https://nixos.wiki/wiki/Home_Manager

## License

Licensed under GNU General Public License v3.0 only.  See [LICENSE](LICENSE) file for details.
