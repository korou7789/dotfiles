{ pkgs, ... }:

{
  home.username = "korou";
  home.homeDirectory = "/home/korou";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  xdg.configFile."nix/nix.conf".text = ''
    extra-experimental-features = nix-command flakes
  '';

  home.packages = [
    pkgs.git
    pkgs.vim
  ];
}
