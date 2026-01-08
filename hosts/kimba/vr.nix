{
  pkgs,
  wivrn,
  nix-cachyos-kernel,
  ...
}:
{
  nixpkgs.overlays = [
    nix-cachyos-kernel.overlays.pinned
  ];

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;

  services.wivrn = {
    enable = true;
    openFirewall = true;
    highPriority = true;
    package = wivrn.packages.x86_64-linux.default;
  };

  environment.systemPackages = with pkgs; [
    xrizer
    wlx-overlay-s
  ];

  programs.steam = {
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
