{ pkgs, ... }:
{

  networking.hostName = "aurora";

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;

  programs.firefox.enable = true;
  home-manager.users.arepita.programs = {
    chromium = {
      enable = true;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
        { id = "likgccmbimhjbgkjambclfkhldnlhbnn"; } # yomitan
      ];
    };

    zed-editor = {
      enable = true;
      defaultEditor = true;
      package = pkgs.zed-editor-fhs;
    };

    jujutsu = {
      enable = true;
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  programs.nix-index = {
    enable = true;
  };

  environment.systemPackages =
    with pkgs;
    let
      rebuild = pkgs.writeShellApplication {
        name = "rebuild";
        text = ''
          sudo nixos-rebuild switch --flake ~/system
          echo "Press Enter to exit..."
          read -r
        '';
      };
      rebuild-desktop-item = pkgs.makeDesktopItem {
        name = "rebuild";
        desktopName = "Rebuild NixOS";
        comment = "Switch to the latest flake changes";
        exec = "rebuild";
        icon = "nix-snowflake-white";
        categories = [ "System" ];
        terminal = true;
      };
    in
    [
      rebuild
      rebuild-desktop-item
      obs-studio
      nixd
      nixfmt
      lmms-full
      pika-backup
      fastfetch
      ghostty
      moonlight-qt
    ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 GB
    }
  ];

  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
