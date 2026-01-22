{ pkgs, ... }:
{
  programs.nvf = {
    enable = true;
    
    enableManpages = true;

    settings.vim = {
      vimAlias = true;
      syntaxHighlighting = true;
      
      options = {
        tabstop = 2;
        shiftwidth = 0;
      };
      
      theme = {
        enable = true;
        name = "catppuccin";
        style = "macchiato";
      };

      treesitter = {
        highlight.enable = true;
        autotagHtml.enable = true;
        context.enable = true;
        context.setupOpts.max_lines = 1;
      };

      statusline.lualine.enable = true;
      telescope.enable = true;

      withNodeJs = true;

      git.enable = true;
      autocomplete.blink-cmp.enable = true;

      lsp.enable = true;

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;
        nix = {
          enable = true;
          lsp.servers = [ "nixd" ];
        };
        astro.enable = true;
        css.enable = true;
        html.enable = true;
        svelte.enable = true; 
        tailwind.enable = true;
        ts.enable = true;
        json.enable = true;
        markdown = {
          enable = true;
          extensions = {
            render-markdown-nvim.enable = true;
          };
        };

      };

      utility = {
        undotree.enable = true;
      };

      projects.project-nvim = {
        enable = true;
        setupOpts.manual_mode = false;
      };
      filetree.nvimTree = {
        enable = true;
        openOnSetup = false;
        setupOpts = {
          disable_netrw = true;
          view.centralize_selection = true;
          git.enable = true;
          modified.enable = true;
          view.float.enable = true;
        };
      };

      ui = {
        colorizer.enable = true;
        breadcrumbs.enable = true;
        colorful-menu-nvim.enable = true;
        illuminate.enable = true;
        modes-nvim.enable = true;
        smartcolumn.enable = true;
      };
      
      startPlugins = with pkgs.vimPlugins.nvim-treesitter.queries; [ ecma html_tags tsx svelte];
    };
  };
}
