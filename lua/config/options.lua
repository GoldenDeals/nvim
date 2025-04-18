-- ~/.config/nvim/lua/config/options.lua

local opt = vim.opt -- local options handle

-- Line Numbers
opt.number = true         -- Show absolute line number for the current line
opt.relativenumber = true -- Show relative line numbers for other lines << ADD OR CONFIRM THIS LINE

-- Tabs and Indentation
opt.tabstop = 4        -- Number of spaces a tab counts for
opt.shiftwidth = 4     -- Size of an indent
opt.expandtab = true   -- Use spaces instead of tabs
opt.autoindent = true  -- Copy indent from current line when starting new line
opt.smartindent = true -- Smart autoindenting for C-like programs

-- Search Settings
opt.ignorecase = true  -- Ignore case when searching
opt.smartcase = true   -- Ignore case if search pattern is all lowercase, case-sensitive otherwise
opt.hlsearch = true    -- Highlight search results
opt.incsearch = true   -- Show search results incrementally

-- Appearance
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.scrolloff = 8      -- Minimum number of screen lines to keep above and below the cursor
opt.sidescrolloff = 8  -- Minimum number of screen columns to keep to the left and right of the cursor
opt.signcolumn = "yes" -- Always show the sign column, otherwise it would shift the text each time
opt.wrap = false       -- Disable line wrapping

-- Behavior
opt.clipboard = "" -- Use Neovim's unnamed register, DON'T sync with system clipboard by default
opt.completeopt = "menuone,noselect" -- Autocomplete options
opt.hidden = true      -- Allow buffers to be hidden without saving
opt.mouse = "a"        -- Enable mouse support in all modes
opt.splitright = true  -- Default vertical split to the right
opt.splitbelow = true  -- Default horizontal split below

-- Performance
opt.updatetime = 250   -- Time in ms to wait for trigger events (e.g. CursorHold)
opt.timeoutlen = 500   -- Time in ms to wait for a mapped sequence to complete

-- Backup/Swap
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
opt.undofile = true -- Enable persistent undo
