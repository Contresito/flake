{ inputs, ... }:
{
  imports = [ ./home ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    sharedModules = [
      inputs.nixcord.homeModules.nixcord
    ];

    users.arepita = {
      home.stateVersion = "25.11";

      programs = {
        git = {
          enable = true;
          lfs.enable = true;

          settings = {
            user = {
              name = "Contresito";
              email = "contresito@gmail.com";
            };
          };
        };

      };

    };
  };
}
