{ pkgs, plasma-manager, ... }:
let
  wallpapers = pkgs.runCommand "wallpapers" { } ''
    mkdir -p $out/share/wallpapers/
    cp -ar ${../../assets/wallpapers}/* $out/share/wallpapers/
  '';
in
{

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = [
    pkgs.kdePackages.kate
    pkgs.kdePackages.elisa
  ];

  environment.systemPackages = [
    pkgs.kdePackages.kalk
    pkgs.kdePackages.partitionmanager
  ];

  home-manager = {
    sharedModules = [ plasma-manager.homeModules.plasma-manager ];
    users.arepita.programs.plasma = {
      enable = true;
      overrideConfig = true;
      powerdevil.AC.autoSuspend.action = "nothing";
      kwin.virtualDesktops.number = 3;
      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        theme = "breeze-dark";
        colorScheme = "BreezeDark";
        wallpaperSlideShow.path = "${wallpapers}/share/wallpapers/primary";
      };
      kscreenlocker.appearance.wallpaperSlideShow.path = "${wallpapers}/share/wallpapers/secondary";

      panels = [

        {
          location = "bottom";
          hiding = "autohide";
          widgets = [
            {
              kickoff = {
                icon = "nix-snowflake-white";
              };
            }
            {
              pager = {
                size = {
                  width = 10000;
                  height = 500;
                };
              };
            }
            "org.kde.plasma.marginsseparator"
            {
              iconTasks = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:zen-beta.desktop"
                  "applications:org.telegram.desktop.desktop"
                  "applications:discord.desktop"
                ];
                behavior.unhideOnAttentionNeeded = false;
              };
            }
            "org.kde.plasma.marginsseparator"
            {
              systemTray.items = {
                shown = [
                  "org.kde.plasma.bluetooth"
                ];
                hidden = [
                  "org.kde.plasma.battery"
                ];
              };
            }
            "org.kde.plasma.digitalclock"
            "org.kde.plasma.showdesktop"
          ];
        }
      ];

      configFile.kwinrc.Wayland."InputMethod" = {
        value = "/run/current-system/sw/share/applications/fcitx5-wayland-launcher.desktop";
        shellExpand = true;
      };
    };
  };
}
