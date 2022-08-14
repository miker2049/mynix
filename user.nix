{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mik";
  home.homeDirectory = "/home/mik";

  home.packages = [
    pkgs.htop
    pkgs.ffmpeg
    pkgs.jq
    pkgs.sysz
    pkgs.fzf
    pkgs.ripgrep
    pkgs.silver-searcher
    pkgs.nixfmt
    pkgs.iosevka
    pkgs.bc
    pkgs.lf
    pkgs.font-awesome
    # pkgs.borgbackup
    # pkgs.borgmatic
    # pkgs.gimp-with-plugins
    # pkgs.aseprite
    # pkgs.nodejs
    # pkgs.nodePackages.pnpm
    # pkgs.nodePackages.npm
    # pkgs.supercollider-with-plugins
    # pkgs.tiled
    pkgs.vlc
  ];

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/emacs-overlay/archive/e0f99212b780c7f55af5d5b9d6ed20528d9fbee2.tar.gz";
      sha256 = "sha256:0b6cf2ingvlm4jj8lkfl26qnsd5ba7snmybgfbdfsaqw7sz4q4d6";
    }))
  ];

  programs.git = {
    enable = true;
    userName = "miker2049";
    userEmail = "russomichaelb@gmail.com";
    lfs = { enable = true; };
  };

  fonts.fontconfig.enable = true;

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm epkgs.all-the-icons ];
    # package = pkgs.emacsPgtkNativeComp;
  };
  services.emacs = {
    # package = pkgs.emacsPgtkNativeComp;
    enable = true;
    client.enable = true;
  };

  xdg.configFile."wallpapers/wallpaper.png".source = ./wallpaper.png;
  xdg.configFile."flashfocus/flashfocus.yml".source = ./flashfocus.yml;
  xdg.configFile."sway/config".source = ./sway.conf;
  xdg.configFile."waybar/config".source = ./waybar.conf;
  xdg.configFile."waybar/style.css".source = ./waybar.css;
  xdg.configFile."swayr/config.toml".source = ./swayr.toml;
  xdg.configFile."i3status-rust/config.toml".source = ./i3status-rust.toml;

  programs.direnv.enable = true;
  services.lorri.enable = true;

  programs.zsh = {
    enable = true;
    profileExtra = ''
      if [ "$(tty)" = "/dev/tty1" ] ; then
          # Your environment variables
              export QT_QPA_PLATFORM=wayland
              export MOZ_ENABLE_WAYLAND=1
              export MOZ_WEBRENDER=1
              export XDG_SESSION_TYPE=wayland
              export XDG_CURRENT_DESKTOP=sway
              exec sway
      fi
    '';
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline vim-nix ];
    extraConfig = ''
      set mouse=a
    '';
  };

  #utils.swaylock.enable = true;
  services.kanshi.enable = true;
  programs.mako.enable = true;
  services.swayidle.enable = true;


  programs.ssh.enable = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
}
