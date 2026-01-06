{ inputs, ... }:
{
  home-manager = {
    sharedModules = [ inputs.zen-browser.homeModules.beta ];
    users.arepita.programs.zen-browser = {
      enable = true;
      profiles.default = {
        search = {
          force = true;
          default = "@k";
          engines = {
            kagi = {
              name = "Kagi";
              urls = [
                {
                  template = "https://kagi.com/search?q={searchTerms}";
                  params = [
                    {
                      name = "query";
                      value = "searchTerms";
                    }
                  ];
                }
              ];
              definedAliases = [ "@k" ];
            };
          };
        };
        extensions.packages = with inputs.firefox-addons.packages.x86_64-linux; [
          ublock-origin
          clearurls
          plasma-integration
          fastforwardteam
          yomitan
          kagi-search
        ];
      };
      policies = {
        DisableFirefoxStudies = true;
        DisableTelemetry = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        DontCheckDefaultBrowser = true;
        DisablePocket = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };
    };
  };
}
