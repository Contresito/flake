{ nixcord, ... }:
{
  home-manager = {
    sharedModules = [
      nixcord.homeModules.nixcord
    ];
    users.arepita.programs.nixcord = {
      enable = true;
      config = {
        plugins = {
          quickReply.enable = true;
          imageZoom.enable = true;
          ClearURLs.enable = true;
          fakeNitro = {
            enable = true;
            enableEmojiBypass = false;
            enableStickerBypass = false;
            transformCompoundSentence = true;
          };
          favoriteEmojiFirst.enable = true;
          expressionCloner.enable = true;
          greetStickerPicker.enable = true;
          fixYoutubeEmbeds.enable = true;
          reverseImageSearch.enable = true;
          sendTimestamps.enable = true;
          shikiCodeblocks.enable = true;
          unindent.enable = true;
          unlockedAvatarZoom.enable = true;
          validReply.enable = true;
          viewIcons.enable = true;
          voiceDownload.enable = true;
          voiceMessages.enable = true;
          volumeBooster.enable = true;
          youtubeAdblock.enable = true;
        };
      };
    };
  };
}
