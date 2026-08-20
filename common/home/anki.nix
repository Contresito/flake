{ pkgs, ... }:
let
  kanji-grid-kuuube = pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
    pname = "kanji-grid-kuuube";
    version = "2.5.6";
    src = pkgs.fetchFromGitHub {
      owner = "Kuuuube";
      repo = "kanjigrid";
      rev = finalAttrs.version;
      hash = "sha256-2Q2PNY/NMob5qHsQrpTC3Zukz7A2amkXgqQagqL2gyk=";
    };
    sourceRoot = "${finalAttrs.src.name}/src";
  });
  kanji-table = pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
    pname = "kanji-table";
    version = "f6c49e0";
    src = pkgs.fetchFromGitHub {
      owner = "AustinHasten";
      repo = "AnkiKanjiTable";
      rev = "f6c49e013c7ab5490cc866ae9078064d0acd85b8";
      hash = "sha256-8taowMZfbq97TJ+GpmsOzR7kxm1kwyg0K/Mln7M2KRk=";
    };
  });

  anki-connect = pkgs.ankiAddons.anki-connect.withConfig {
    config = {
      webCorsOriginList = [
        "http://localhost"
        "https://app.asbplayer.dev"
      ];
    };
  };
in
{
  home-manager.users.arepita.programs.anki = {
    enable = true;
    addons = [
      anki-connect
      kanji-grid-kuuube
      kanji-table
    ];
  };
}
