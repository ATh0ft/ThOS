{ config, lib, pkgs, ... }:

let
  cfg = config.nvf;
in {
  options = {
  imports = [ ];
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
          vim.lsp.enable = true;
          vim.languages = {
            python.lsp.enable = true;
            rust.lsp.enable = true;
          };
          vim.filetree.neo-tree.enable = true;
          vim.telescope.enable = true;
        
          vim = {
            autocomplete.nvim-cmp = {
              enable = true;
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
  }]);
}
