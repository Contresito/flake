{ pkgs, ... }:
{

  networking.hostName = "kimba";

  # Install firefox.
  programs.firefox.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  environment.systemPackages = with pkgs; let 
    rebuild = pkgs.writeShellApplication {
      name = "rebuild";
      text = ''
        sudo nixos-rebuild switch --flake ~/void/Documents/Code/Nix/system 
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
  in [
    azahar
    rebuild
    rebuild-desktop-item
  ];

  # Set-up vscode intellisense for this flake
  # by specifying where my flake is on this machine
  home-manager.users.arepita.programs.vscode.profiles.default.userSettings."nix.options.nixd.nixos"."expr" =
    "(builtins.getFlake \"~/void/Documents/Code/Nix/system\")";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
