{ pkgs, plasma-manager, ... }:
let
  wallpapers = pkgs.runCommand "wallpapers" { } ''
    mkdir -p $out/share/wallpapers/
    cp -ar ${../../assets/wallpapers}/* $out/share/wallpapers/
  '';

  create-steamdeck-display = pkgs.writeShellApplication {
    name = "create-steamdeck-display";
    text = ''
      krfb-virtualmonitor --resolution 1280x800 --name steamdeck-vm --password pass --port 5905 &
      kscreen-doctor output.Virtual-steamdeck-vm.addCustomMode.1280.800.90000.full
      kscreen-doctor output.Virtual-steamdeck-vm.mode.1280x800@90
      kscreen-doctor output.Virtual-steamdeck-vm.position.0,0
      kscreen-doctor output.DP-0.position.1280,0
      kscreen-doctor output.Virtual-steamdeck-vm.primary

      echo "Done! Press any key to close."
      read -r
    '';
  };
  create-steamdeck-display-item = pkgs.makeDesktopItem {
    name = "create-steamdeck-display";
    desktopName = "Start Steam Deck Virtual Display";
    comment = "Creates a virtual display to use when streaming a game to the Steam Deck";
    exec = "create-steamdeck-display";
    icon = "nix-snowflake-white";
    categories = [ "System" ];
    terminal = true;
  };
in
{

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;

  environment.plasma6.excludePackages = [
    pkgs.kdePackages.kate
    pkgs.kdePackages.elisa
  ];

  environment.systemPackages = [
    pkgs.kdePackages.kalk
    pkgs.kdePackages.partitionmanager

    pkgs.kdePackages.krfb
pkgs.kdePackages.kscreen

    create-steamdeck-display
    create-steamdeck-display-item
  ];

  home-manager = {
    sharedModules = [ plasma-manager.homeModules.plasma-manager ];
    users.arepita.home.file.".local/share/user-places.xbel" = {
      source = ./static/plasma-bookmarks.xbel;
      force = true;
    };
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
      session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

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
                  "applications:org.keepassxc.KeePassXC.desktop"
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

      configFile = {
        kwinrc.Wayland."InputMethod" = {
          value = "/etc/profiles/per-user/arepita/share/applications/fcitx5-wayland-launcher.desktop";
          shellExpand = true;
        };
        kdeglobals.General = {
          TerminalApplication="ghostty";
          TerminalService = "com.mitchellh.ghostty.desktop";
        };
      };


    };
  };
}
