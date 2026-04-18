{ config, pkgs, ... }:

{
  programs.neovim = {
    withPython3 = true;
    withRuby = true;
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      lualine-nvim
      nvim-treesitter.withAllGrammars
      plenary-nvim 
      telescope-nvim
    ];

    # ALL Lua configuration grouped together safely
    initLua = ''
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.smartindent = true
      vim.opt.termguicolors = true
      
      -- Load the colorscheme
      vim.cmd[[colorscheme tokyonight]]

      -- 2. Plugin Setups
      require('lualine').setup { 
        options = { theme = 'tokyonight' } 
      }

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    '';
  };
}
