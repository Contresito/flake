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
          "editor.formatOnSave" = true;
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "editor.tabSize" = 2;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.hiddenLanguageServerErrors" = [ "textDocument/definition" ];
          "chat.disableAIFeatures" = true;
          "svelte.enable-ts-plugin" = true;
        };
      };
    };
  };
}
