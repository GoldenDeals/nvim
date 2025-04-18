-- ~/.config/nvim/lua/plugins/ui.lua

return {
  -- Catppuccin Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Make sure it loads first
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true, -- << CHANGE THIS TO true
        show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
        term_colors = true,             -- sets terminal colors (e.g. `g:terminal_color_0`)
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = false, -- Use neo-tree instead
          treesitter = true,
          notify = true,
          mason = true,
          neotree = true,
          -- For more plugins integrations check ./lua/plugins/extras/integrations
        },
      })
      -- Setup must be called before loading
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  -- Neo-tree File Explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        window = {
          position = "float",
          width = 40,
          float = {
            win_options = {
              -- winblend = 0, -- Keep float opaque (0) or make it transparent too (e.g., 15)
                           -- Note: This blends with the nvim background, which is now transparent.
                           -- So, 0 means the float keeps its catppuccin background color.
            },
          },
        },
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
          },
          follow_current_file = {
            enabled = true,
          },
          hijack_netrw_behavior = "open_current",
        },
        git_status = {
          window = {
            position = "float",
          },
        },
      })

      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle float<CR>", { desc = "Toggle Neo-tree (Float)" })
    end,
  },
}
