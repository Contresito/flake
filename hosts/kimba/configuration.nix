{ pkgs, ... }:
{

  networking.hostName = "kimba";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };

  programs.firefox.enable = true;
  programs.chromium = {
    enable = true;
    homepageLocation = "https://arepita.moe";
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  environment.systemPackages =
    with pkgs;
    let
      rebuild = pkgs.writeShellApplication {
        name = "rebuild";
        text = ''
          sudo nixos-rebuild switch --flake ~/void/Documents/Code/Nix/system
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
      azahar
      android-studio
      rebuild
      rebuild-desktop-item
      element-desktop
      lastpass-cli
      ungoogled-chromium
      (python3Packages.toPythonApplication python313Packages.manga-ocr)
      wl-clipboard
      pkgs.steam-run
      pkgs.airshipper
    ];

  # Set-up vscode intellisense for this flake
  # by specifying where my flake is on this machine
  home-manager.users.arepita.programs.vscode.profiles.default.userSettings."nix.options.nixd.nixos"."expr" =
    "(builtins.getFlake \"~/void/Documents/Code/Nix/system\")";

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    14005
    14004
  ];
  networking.firewall.allowedUDPPorts = [
    14005
    14004
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
