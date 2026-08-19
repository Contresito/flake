{ noctalia, pkgs, ... }: {

  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org "];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
  };

  home-manager.sharedModules = [ noctalia.homeModules.default ];

  programs.noctalia-greeter = {
    enable = true;
  };
  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

  home-manager.users.arepita = {
    programs.noctalia = {
      enable = true;
      settings = {
        shell.polkit_agent = true;
      };
    };
    programs.niri.settings = {
      spawn-at-startup = [
        { argv = [ "noctalia" ]; }
      ];

      window-rules = [
        {
          matches = [ { app-id = ''dev.noctalia.Noctalia''; } ];
          open-floating = true;
          default-column-width = { fixed = 1080; };
          default-window-height = { fixed = 920; };
        }
      ];

      layer-rules = [
        {
          matches = [ { namespace="^noctalia-backdrop"; } ];
          place-within-backdrop = true;
        }
      ];

      layout = {
        background-color = "transparent";
      };

      overview = {
        workspace-shadow = {
          enable = false;
        };
      };

      binds = {
        "Mod+B".action.spawn-sh = "noctalia msg bar-reserve-toggle && noctalia msg bar-toggle";
        "Mod+D".action.spawn-sh = "noctalia msg panel-open launcher";
        "Mod+H".action.spawn-sh = "noctalia msg panel-open clipboard";

        "XF86AudioRaiseVolume".action.spawn = [
          "noctalia"
          "msg"
          "volume-up"
        ];
        "XF86AudioLowerVolume".action.spawn = [
          "noctalia"
          "msg"
          "volume-down"
        ];
        "XF86AudioMute".action.spawn = [
          "noctalia"
          "msg"
          "volume-mute"
        ];

        "XF86MonBrightnessUp".action.spawn = [
          "noctalia"
          "msg"
          "brightness-up"
        ];
        "XF86MonBrightnessDown".action.spawn = [
          "noctalia"
          "msg"
          "brightness-down"
        ];

      };
    };

    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
    };
  };
}
