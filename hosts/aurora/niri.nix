{ pkgs, niri, ... }:
{

  programs.niri.enable = true;

  nixpkgs.overlays = [ niri.overlays.niri ];
  programs.niri.package = pkgs.niri-stable;



  home-manager.users.arepita.programs.niri = {
    settings = {
      input.touchpad.accel-speed = 0.3;
      input.focus-follows-mouse = {
        enable = true;
      };
      layout = {
        gaps = 4;
        preset-column-widths = [
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          { proportion = 2. / 3.; }
        ];
      };
      cursor = {
        hide-after-inactive-ms = 10000;
      };
      prefer-no-csd = true;
      binds = {
        "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];
        "Mod+F".action.maximize-column = [ ];
        "Mod+Shift+F".action.fullscreen-window = [ ];
        "Mod+C".action.center-column = [ ];
        "Mod+O".action.toggle-overview = [ ];
        "Mod+Q".action.close-window = [ ];

        "Mod+Shift+E".action.quit = [ ];
        "Ctrl+Alt+Delete".action.quit = [ ];

        "Mod+Up".action.focus-window-up = [ ];
        "Mod+Down".action.focus-window-down = [ ];
        "Mod+Left".action.focus-column-left = [ ];
        "Mod+Right".action.focus-column-right = [ ];

        "Mod+Shift+Up".action.move-window-up = [ ];
        "Mod+Shift+Down".action.move-window-down = [ ];
        "Mod+Shift+Left".action.move-column-left = [ ];
        "Mod+Shift+Right".action.move-column-right = [ ];

        "Mod+Ctrl+Up".action.focus-workspace-up = [ ];
        "Mod+Ctrl+Down".action.focus-workspace-down = [ ];
        "Mod+Ctrl+Shift+Up".action.move-column-to-workspace-up = [ ];
        "Mod+Ctrl+Shift+Down".action.move-column-to-workspace-down = [ ];

        "Mod+Alt+Left".action.consume-or-expel-window-left = [ ];
        "Mod+Alt+Right".action.consume-or-expel-window-right = [ ];

        "Mod+Comma".action.consume-window-into-column = [ ];
        "Mod+Period".action.expel-window-from-column = [ ];

        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Alt+Minus".action.set-column-width = "-5%";
        "Mod+Alt+Equal".action.set-column-width = "+5%";
        "Mod+Ctrl+Equal".action.expand-column-to-available-width = [ ];
        "Mod+R".action.switch-preset-column-width = [ ];

        "Mod+V".action.toggle-window-floating = [ ];
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [ ];


        "Print".action.screenshot = [ ];
        "Ctrl+Print".action.screenshot-screen = [ ];
        "Alt+Print".action.screenshot-window = [ ];


        "Mod+Escape" = {
          allow-inhibiting = false;
          action.toggle-keyboard-shortcuts-inhibit = [ ];
        };

        "Mod+Shift+P".action.power-off-monitors = [ ];

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        "Mod+Ctrl+6".action.move-column-to-workspace = 6;
        "Mod+Ctrl+7".action.move-column-to-workspace = 7;
        "Mod+Ctrl+8".action.move-column-to-workspace = 8;
        "Mod+Ctrl+9".action.move-column-to-workspace = 9;

        "Mod+T".action.spawn = "ghostty";
        "Mod+P".action.spawn-sh = "wdisplays";
        "XF86Calculator".action.spawn = "gnome-calculator";

      };

      window-rules = [
        {
          geometry-corner-radius =
            let
              r = 8.0;
            in
            {
              top-left = r;
              top-right = r;
              bottom-left = r;
              bottom-right = r;
            };
          clip-to-geometry = true;
        }
        {
          matches = [ { app-id = ''^org\.keepassxc\.KeePassXC$''; } ];
          block-out-from = "screen-capture";
        }
        {
          matches = [ {app-id = ''org.gnome.Calculator'';}];
          open-floating = true;
        }
        {
          matches = [ {app-id = ''org.gnome.Nautilus'';}];
          open-floating = true;
        }
        {
          matches = [ {app-id = ''org.gnome.Loupe'';}];
          open-floating = true;
        }
      ];
    };
  };

  services.udisks2.enable = true;
  home-manager.users.arepita.services.udiskie.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol
    nautilus
    nautilus-open-any-terminal
    mission-center
    wdisplays
    xwayland-satellite
    hyprpicker
    gnome-calculator
    loupe
  ];

  programs.ssh.startAgent = false;
  services.gnome.gcr-ssh-agent.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;

}
