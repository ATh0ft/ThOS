{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nvf;
in {
  options = {
    imports = [];
    nvf = {
      enable = lib.mkEnableOption "Enable nvf";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nvf = {
        enable = true;

        settings = {
          vim.viAlias = true;
          vim.vimAlias = true;
          vim.lsp = {
            enable = true;
            formatOnSave = true;
            trouble.enable = true;
          };
          vim.diagnostics.enable = true;
          vim.diagnostics.config.virtual_text = {
            format = lib.generators.mkLuaInline ''
              function(diagnostic)
                return string.format("%s [%s]", diagnostic.message, diagnostic.source)
              end
            '';
          };

          vim.languages = {
            enableLSP = true;
            enableFormat = true;
            enableTreesitter = true;

            python.enable = true;
            python.lsp.enable = true;
            rust.enable = true;
            rust.lsp.enable = true;
            nix.enable = true;
            nix.lsp.enable = true;
            clang.enable = true;
            clang.lsp.enable = true;
          };

          vim.git.enable = true;

          vim.autocomplete.blink-cmp.enable = true;

          vim.filetree.neo-tree.enable = true;
          vim.telescope.enable = true;

          vim.binds.cheatsheet.enable = true;
          vim.tabline = {
            nvimBufferline.enable = true;
          };
          vim.comments = {
            comment-nvim.enable = true;
          };
          vim.dashboard = {
            dashboard-nvim.enable = true;
            alpha.enable = true;
          };
          vim.utility = {
            ccc.enable = false;
            vim-wakatime.enable = false;
            diffview-nvim.enable = true;
            yanky-nvim.enable = false;
            icon-picker.enable = false;
            surround.enable = false;
            leetcode-nvim.enable = false;
            multicursors.enable = false;

            motion = {
              hop.enable = false;
              leap.enable = false;
              precognition.enable = false;
            };
            images = {
              image-nvim.enable = false;
            };
          };

          vim.keymaps = [
            {
              key = "<leader>e";
              mode = ["n"];
              action = ":Neotree<CR>";
              silent = true;
              desc = "open file tree";
            }
          ];
        };
      };
    }
  ]);
}
