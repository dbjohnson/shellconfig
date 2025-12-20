-- ~/.config/nvim/lua/plugins/my-legacy-plugins.lua
return {
  -- Your Theme
  {
    "oxfist/night-owl.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("night-owl")
    end,
  },

  -- Vim Slime
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "neovim" -- Changed to neovim for integrated terminal support
      vim.g.slime_python_ipython = 1
      vim.g.slime_dont_ask_default = 1
    end,
  },

  -- Copilot (LazyVim handles this better usually, but here is your config)
  { "github/copilot.vim" },

  -- Rainbow Parentheses
  { "frazrepo/vim-rainbow" },

  -- Note: I removed 'syntastic' (LazyVim uses LSP/null-ls)
  -- and 'vim-airline' (LazyVim uses lualine) to prevent UI conflicts.
}
