-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- integrate with system clipboard
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("v", "<D-c>", '"+y')

-- Setup Lazy.nvim with LazyVim AND your custom plugins
require("lazy").setup({
  spec = {
    -- 1. Load LazyVim Core (This restores Neo-tree, Dashboard, etc.)
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- 2. Import your plugins (We will create this file next)
    { import = "plugins" },
  },
  install = { colorscheme = { "night-owl", "habamax" } },
  checker = { enabled = true, notify = false },
})

vim.opt.number = true
vim.opt.relativenumber = false

-- Autoread
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})
