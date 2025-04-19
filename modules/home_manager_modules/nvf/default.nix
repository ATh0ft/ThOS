{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nvf;
in {
  options = {
    imports = [
      ./lazy_plugins/vimtex.nix
    ];
    nvf = {
      enable = lib.mkEnableOption "Enable nvf";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nvf = {
        enable = true;

        settings.vim = {
          ### language support ###
          languages = {
            enableLSP = true;
            enableFormat = true;
            enableTreesitter = true;

            python.enable = true;
            python.lsp.enable = true;
            python.lsp.server = "pyright";
            python.treesitter.enable = true;
            rust.enable = true;
            rust.lsp.enable = true;
            nix.enable = true;
            nix.lsp.enable = true;
            clang.enable = true;
            clang.lsp.enable = true;

            latex.enable = true;
          };
          ### plugins ###
          git.enable = true;

          autocomplete.blink-cmp.enable = true;
          # autocomplete.nvim-cmp.enable = true;
          autopairs.nvim-autopairs.enable = true;

          # autocomplete.nvim-cmp.enable = true;
          snippets.luasnip.enable = true;
          # autopairs.nvim-autopairs.enable = true;
          # filetree.neo-tree.enable = true;
          filetree = {
            nvimTree.enable = true;
            nvimTree.openOnSetup = false;
          };
          telescope.enable = true;

          terminal.toggleterm = {
            enable = true;
            setupOpts.direction = "float";
          };

          statusline.lualine.enable = true;
          binds.cheatsheet.enable = true;
          tabline = {
            nvimBufferline.enable = true;
          };
          comments = {
            comment-nvim.enable = true;
            comment-nvim.mappings.toggleCurrentLine = "<leader>/";
          };
          dashboard = {
            dashboard-nvim.enable = true;
            alpha.enable = true;
          };
          utility = {
            ccc.enable = false;
            diffview-nvim.enable = true;
            yanky-nvim.enable = true;
          };

          ### configuration ###
          viAlias = true;
          vimAlias = true;
          lsp = {
            enable = true;
            formatOnSave = true;
            trouble.enable = true;
          };
          options.tabstop = 4;
          options.shiftwidth = 0;
          diagnostics.enable = true;
          diagnostics.config.virtual_text = {
            format = lib.generators.mkLuaInline ''
              function(diagnostic)
                return string.format("%s [%s]", diagnostic.message, diagnostic.source)
              end
            '';
          };
          useSystemClipboard = true;
          keymaps = [
            {
              key = "<leader>e";
              mode = ["n"];
              action = ":NvimTreeToggle<CR>";
              silent = true;
              desc = "open file tree";
            }
            {
              key = "<M-i>";
              mode = ["n"];
              action = ":ToggleTerm<CR>";
              silent = false;
              desc = "toggle terminal";
            }
            {
              key = "<M-i>";
              mode = ["t"];
              action = "<C-\\><C-n>:ToggleTerm<CR>";
              silent = false;
              desc = "toggle terminal";
            }
          ];
          theme = {
            enable = true;
            name = "rose-pine";
            transparent = false;
            style = "moon";
          };
        };
      };
    }
  ]);
}
