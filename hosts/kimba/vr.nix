{
  pkgs,
  wivrn,
  nix-cachyos-kernel,
  nix-gaming-edge,
  ...
}:
{
  nixpkgs.overlays = [
    nix-cachyos-kernel.overlays.pinned
    nix-gaming-edge.overlays.proton-cachyos
  ];

  services.lact.enable = true;
  home-manager.users.arepita.xdg.configFile."openxr/1/active_runtime.json".source =
    "${pkgs.wivrn}/share/openxr/1/openxr_wivrn.json";

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;

  services.wivrn = {
    enable = true;
    defaultRuntime = true;
    openFirewall = true;
    highPriority = true;
    package = wivrn.packages.x86_64-linux.default;
  };

  environment.systemPackages = with pkgs; [
    xrizer
    wlx-overlay-s
  ];

  programs.steam = {
    extraCompatPackages = with pkgs; [
      proton-cachyos-x86_64-v3
    ];
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
