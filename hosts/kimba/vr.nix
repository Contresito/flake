{
  pkgs,
  # wivrn,
  ...
}:
{

  services.lact.enable = true;
  # home-manager.users.arepita.xdg.configFile."openxr/1/active_runtime.json".source =
  #   "${pkgs.wivrn}/share/openxr/1/openxr_wivrn.json";

  # services.wivrn = {
  #   enable = true;
  #   openFirewall = true;
  #   highPriority = true;
  #   package = wivrn.packages.x86_64-linux.default;
  #   package = nixpkgs-xr.packages.x86_64-linux.wivrn;
  # };

  # environment.systemPackages = with nixpkgs-xr.packages.x86_64-linux; [
  #   xrizer
  #   wayvr
  # ];

  programs.steam = {
    # extraCompatPackages = with pkgs; [
    #   proton-cachyos-x86_64-v3
    # ];
    package = pkgs.steam.override {
      extraProfile = ''
        # Fixes timezones on VRChat/Resonite
        unset TZ
        # Allows Monado/WiVRn to be used
        export PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1
      '';
    };
  };
}
