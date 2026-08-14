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
          pnpm
        ]
      );
      profiles.default = {
        enableUpdateCheck = false;
        userSettings = {
          "workbench.colorTheme" = "Dark Modern";
          "editor.formatOnSave" = true;
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "editor.tabSize" = 2;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.hiddenLanguageServerErrors" = [ "textDocument/definition" ];
          "svelte.enable-ts-plugin" = true;
          "[nix]" = {
            "editor.defaultFormatter" = "jnoortheen.nix-ide";
          };
          "[odin]" = {
            "editor.defaultFormatter" = "DanielGavin.ols";
          };
          "redhat.telemetry.enabled" = false;
          "update.mode" = "none";
          "terminal.integrated.initialHint" = false;
          "editor.minimap.enabled" = false;
          "json.schemaDownload.trustedDomains" = {
            "https://developer.microsoft.com/json-schemas/" = true;
            "https://json-schema.org/" = true;
            "https://json.schemastore.org/" = true;
            "https://raw.githubusercontent.com/DanielGavin/ols/master/misc/ols.schema.json" = true;
            "https://raw.githubusercontent.com/devcontainers/spec/" = true;
            "https://raw.githubusercontent.com/microsoft/vscode/" = true;
            "https://schemastore.azurewebsites.net/" = true;
            "https://www.schemastore.org/" = true;
          };
          "aws.cloudformation.telemetry.enabled" = false;
        };
      };
    };
  };
}
