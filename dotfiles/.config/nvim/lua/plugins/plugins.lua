return {
  {
    "oxfist/night-owl.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("night-owl")
    end,
  },
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "neovim" -- Changed to neovim for integrated terminal support
      vim.g.slime_python_ipython = 1
      vim.g.slime_dont_ask_default = 1
    end,
  },
  { "github/copilot.vim" },
  { "frazrepo/vim-rainbow" },
}
