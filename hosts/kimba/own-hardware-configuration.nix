{ ... }:
{
  # Nvidia drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;

  # Don't use integrated graphics
  boot.kernelParams = [ "module_blacklist=amdgpu" ];

  # Mount THE VOID drive
  fileSystems."/home/arepita/void" = {
    device = "/dev/disk/by-uuid/4209c52b-f30d-49d5-baf7-4e3093de8261";
    fsType = "ext4";
    options = [
      "nofail"
      "rw"
    ];
  };
}
