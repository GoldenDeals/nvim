
-- Set leader key MUST be before lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("Installing lazy.nvim...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load core configuration
require("config.options")
require("config.keymaps")
-- require("config.autocmds")

-- Setup lazy.nvim with plugin specifications from lua/plugins/
require("lazy").setup("plugins", {
  defaults = {
    lazy = false, -- All plugins are lazy-loaded by default, unless specified otherwise
  },
  install = {
    -- Try to load one of these colorschemes when lazy installs plugins
    colorscheme = { "catppuccin-mocha" },
  },
  checker = {
    enabled = true, -- Check for plugin updates automatically
    notify = false, -- Don't notify on startup, use :Lazy check
  },
  change_detection = {
    notify = false, -- Don't notify about config changes detection
  },
})

-- Set Catppuccin colorscheme after plugins are loaded
vim.cmd.colorscheme("catppuccin-mocha")

print("Neovim configured!")
