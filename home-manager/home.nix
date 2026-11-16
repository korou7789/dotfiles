{ config, pkgs, ... }:

let
  configDir = "${config.home.homeDirectory}/dotfiles/config";
  link = path: config.lib.file.mkOutOfStoreSymlink "${configDir}/${path}";
in
{
  home.username = "korou";
  home.homeDirectory = "/home/korou";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  xdg.configFile = {
    "fontconfig".source = link "fontconfig";
    "foot".source = link "foot";
    "fuzzel".source = link "fuzzel";
    "gtklock".source = link "gtklock";
    "mako".source = link "mako";
    "nvim".source = link "nvim";
    "sway".source = link "sway";
    "swayidle".source = link "swayidle";
    "vim".source = link "vim";
    "waybar".source = link "waybar";
    "wireplumber".source = link "wireplumber";
    "wob".source = link "wob";

    "nix/nix.conf".text = ''
      extra-experimental-features = nix-command flakes
    '';
  };

  home.packages = with pkgs; [
    git
    vim
  ];
}
