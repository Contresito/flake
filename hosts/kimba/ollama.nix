{ pkgs, ... }:
{
  nix.settings = {
    substituters = [
      "https://cache.nixos-cuda.org"
    ];
    trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };

  # nixpkgs.config.cudaSupport = true;

  # services.ollama = {
  #   enable = true;
  #   package = pkgs.ollama-cuda;
  #   environmentVariables = {
  #     OLLAMA_CONTEXT_LENGTH = "32000";
  #   };
  # };
  # services.open-webui = {
  #   enable = true;
  #   openFirewall = true;
  #   port = 7547;
  #   host = "192.168.0.221";
  # };

  # networking.firewall.allowedTCPPorts = [ 7547 ];
  # networking.firewall.allowedUDPPorts = [ 7547 ];
}
