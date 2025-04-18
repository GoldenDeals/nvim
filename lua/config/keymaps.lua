-- ~/.config/nvim/lua/config/keymaps.lua

local map = vim.keymap.set

-- General Keymaps

-- Clear search highlights
map("n", "<leader>/", "<cmd>nohlsearch<CR>", { desc = "Clear Search Highlight" })

-- System Clipboard Operations (using the '+' register)
-- Normal mode: Copy current line to system clipboard
map("n", "<leader>y", '"+y', { desc = "Copy Line to System Clipboard" })
-- Visual mode: Copy selection to system clipboard
map("v", "<leader>y", '"+y', { desc = "Copy Selection to System Clipboard" })
-- Normal mode: Paste from system clipboard after cursor
map("n", "<leader>p", '"+p', { desc = "Paste from System Clipboard After" })
-- Normal mode: Paste from system clipboard before cursor
map("n", "<leader>P", '"+P', { desc = "Paste from System Clipboard Before" })
-- Visual mode: Paste from system clipboard replacing selection
map("v", "<leader>p", '"+p', { desc = "Paste from System Clipboard Over Selection" })

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", { desc = "Next Buffer" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous Buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Close Buffer" })

-- Window management
map("n", "<C-h>", "<C-w>h", { desc = "Move focus to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move focus to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move focus to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move focus to upper window" })

-- Resize window
map("n", "<C-Left>", "<C-w><", { desc = "Decrease window width" })
map("n", "<C-Right>", "<C-w>>", { desc = "Increase window width" })
map("n", "<C-Down>", "<C-w>-", { desc = "Decrease window height" })
map("n", "<C-Up>", "<C-w>+", { desc = "Increase window height" })

map("n", "<C-s>", ":w<CR>", { desc = "Save file" })

-- Terminal toggle (Optional - requires a terminal plugin like toggleterm if you add one)
-- map("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })

-- Diagnostic keymaps (LSP bindings are handled in lsp.lua on_attach)
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to Previous Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to Next Diagnostic" })
map("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show Line Diagnostics" })

-- Plugin Specific Keymaps handled in their respective files (like Neo-tree in ui.lua)
