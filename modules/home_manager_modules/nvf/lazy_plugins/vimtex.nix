{pkgs, ...}: {
  config.vim.lazy.plugins = {
    vimtex = {
      package = pkgs.vimPlugins.vimtex;

      lazy = false;

      init = ''
        vim.g.vimtex_view_method = "zathura"
      '';
    };
  };
}
