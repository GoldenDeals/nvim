local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

return {
  "codescovery/lazy-remap.nvim",
  event = "VeryLazy",
  name = "remap",
  config = function()
    map("i", "jk", "<esc>")
    map({ "n", "v" }, "<leader>e", "<cmd>Neotree toggle float<cr>", "Toggle file explorer")

    -- Quick access to some common actions
    map("n", "<C-s>", "<cmd>w<cr>", "Write")
    map("n", "<C-S>", "<cmd>wa<cr>", "Write all")
    map("n", "<leader>qq", "<cmd>q<cr>", "Quit")
    map("n", "<leader>qa", "<cmd>qa!<cr>", "Quit all")
    map("n", "<leader>xw", "<cmd>close<cr>", "Window")

    -- Diagnostic keymaps
    map("n", "gx", vim.diagnostic.open_float, "Show diagnostics under cursor")

    -- Easier access to beginning and end of lines
    map("n", "<M-h>", "^", "Go to beginning of line")
    map("n", "<M-l>", "$", "Go to end of line")

    -- Better window navigation
    map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
    map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
    map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
    map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

    -- Move with shift-arrows
    map("n", "<S-Left>", "<C-w><S-h>", "Move window to the left")
    map("n", "<S-Down>", "<C-w><S-j>", "Move window down")
    map("n", "<S-Up>", "<C-w><S-k>", "Move window up")
    map("n", "<S-Right>", "<C-w><S-l>", "Move window to the right")

    -- Resize with arrows
    map("n", "<C-Up>", ":resize +2<CR>")
    map("n", "<C-Down>", ":resize -2<CR>")
    map("n", "<C-Left>", ":vertical resize +2<CR>")
    map("n", "<C-Right>", ":vertical resize -2<CR>")

    -- Deleting buffers
    local function noop()
      print("NOOP")
    end
    local delete_this
    local delete_all
    local delete_others
    local ok, close_buffers = pcall(require, "close_buffers")
    if ok then
      delete_this = function()
        close_buffers.delete({ type = "this" })
      end
      delete_all = function()
        close_buffers.delete({ type = "all", force = true })
      end
      delete_others = function()
        close_buffers.delete({ type = "other", force = true })
      end
    else
      delete_this = function()
        vim.cmd.bdelete()
      end
      delete_all = noop
      delete_others = noop
    end

    map("n", "<leader>xb", delete_this, "Current buffer")
    map("n", "<leader>xo", delete_others, "Other buffers")
    map("n", "<leader>xa", delete_all, "All buffers")

    -- Navigate buffers
    map("n", "<S-l>", ":bnext<CR>")
    map("n", "<S-h>", ":bprevious<CR>")

    -- Stay in indent mode
    map("v", "<", "<gv")
    map("v", ">", ">gv")

    -- Switch between light and dark modes
    map("n", "<leader>ut", function()
      if vim.o.background == "dark" then
        vim.o.background = "light"
      else
        vim.o.background = "dark"
      end
    end, "Toggle between light and dark themes")

    -- Clear after search
    map("n", "<leader>ur", "<cmd>nohl<cr>", "Clear highlights")

    vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
    vim.keymap.set("n", "<leader>Y", [["+Y]])

    vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
    vim.keymap.set("n", "<leader>P", [["+P]])

    vim.keymap.set({ "n", "v" }, "y", [[""y]])
    vim.keymap.set("n", "Y", [[""Y]])

    vim.keymap.set({ "n", "v" }, "p", [[""p]])
    vim.keymap.set("n", "P", [[""P]])

    map("n", "<leader>fr", require("telescope.builtin").oldfiles, "Recently opened")
    map("n", "<leader><space>", require("telescope.builtin").buffers, "Open buffers")
    map("n", "<leader>/", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, "Search in current buffer")

    map("n", "<leader>sf", require("telescope.builtin").find_files, "Files")
    map("n", "<leader>sh", require("telescope.builtin").help_tags, "Help")
    map("n", "<leader>sw", require("telescope.builtin").grep_string, "Current word")
    map("n", "<leader>fw", require("telescope.builtin").live_grep, "Grep")
    map("n", "<leader>sd", require("telescope.builtin").diagnostics, "Diagnostics")

    map("n", "<C-p>", require("telescope.builtin").keymaps, "Search keymaps")
  end,
}
