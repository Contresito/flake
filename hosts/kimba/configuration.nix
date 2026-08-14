{ pkgs, ... }:
{

  networking.hostName = "kimba";

  programs.firefox.enable = true;
  programs.chromium = {
    enable = true;
    homepageLocation = "https://arepita.moe";
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    package = pkgs.sunshine.override {
      cudaSupport = true;
      cudaPackages = pkgs.cudaPackages;
    };
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
      steam-run
      airshipper
      obs-studio
      zed-editor
      jamulus
      qpwgraph
      lmms-full
      libreoffice-qt

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
