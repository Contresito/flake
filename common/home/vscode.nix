{ pkgs, ... }:
{
  home-manager.users.arepita = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhsWithPackages (
        ps: with ps; [
          nodejs_22
          nixd
          nixfmt
        ]
      );
      profiles.default = {
        enableUpdateCheck = false;
        userSettings = {
          "editor.formatOnSave" = true;
          "editor.tabSize" = 2;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
        };
      };
    };
  };
}
