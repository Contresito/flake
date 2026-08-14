{...}: {
  home-manager.users.arepita.programs.waybar = {
    enable = true;
    settings.main = {
      modules-left = ["niri/workspaces" "niri/window"];
      modules-right = ["tray" "privacy" "disk" "memory" "cpu" "battery"];
      modules-center = [ "clock" ];

      "niri/window" = {
        icon = true;
        icon-size = 16;
      };

      battery = {
        format = "{icon}{capacity}%";
        format-icons = {
      		default = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          charging = ["󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
        };
      };

      cpu = {
        interval = 1;
        format = " {icon0}{icon1}{icon2}{icon3} {load}%";
        format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
      };

      memory = {
        format = " {percentage}%";
      };

      clock = {
        format = "♥ {:%H:%M}  ♥ ";
        format-alt = "♥ {:%A, %B %d, %Y (%R)} 󰃰 ♥";
       	tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          first-day-of-week = 1;
          on-scroll = 1;
          on-click-right = "mode";
          format = {
            months =  "<span color='#b3f4f3'><b>{}</b></span>";
            days = "<span color='#ffffff'><b>{}</b></span>";
            weeks = "<span color='#99ffdd'><b>W{}</b></span>";
            weekdays = "<span color='#95a6f4'><b>{}</b></span>";
            today = "<span color='#ff79c6'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-click-forward = "tz_up";
          on-click-backward = "tz_down";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };
      disk = {
        format = " {percentage_free}%";
      };
      tray = {
        spacing = 7;
      };
      privacy = {
        icon-spacing = 4;
        icon-size = 16;
        transition-duration = 250;
        modules = [
          {
            type = "screenshare";
            tooltip = true;
            tooltip-icon-size = 16;
          }
          {
            type = "audio-in";
            tooltip = true;
            tooltip-icon-size = 16;
          }
          {
            type = "location";
            icon-name = "location-services-active-symbolic";
          }
        ];
        ignore-monitor = true;
      };
    };
  };
}
