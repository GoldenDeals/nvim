-- ~/.config/nvim/lua/plugins/finder.lua

return {
{
    "nvim-telescope/telescope-cheat.nvim",
    dependencies = {
        "kkharji/sqlite.lua",
        "nvim-telescope/telescope.nvim"
    }
},
  -- Fuzzy Finder (Telescope)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Extension for project finding integration
      {
        "nvim-telescope/telescope-project.nvim",
        dependencies = { "ahmedkhalf/project.nvim" }, -- Ensure project.nvim is loaded
      },
}, config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          -- Default configuration options
          mappings = {
            i = {
              -- Example: map C-j/C-k to move results up/down
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
        pickers = {
          -- Configuration for specific pickers can go here
        },
        extensions = {
          -- Load the extensions
          project = {
            base_dirs = { -- Customize project discovery directories
              "~/Projects",
            },
            -- theme = "dropdown", -- Example: use a different theme for project picker
            hidden_files = true, -- Show hidden files in project actions?
          },
          cheat = {
            -- cheat.sh extension configuration (if any)
          },
        },
      })

      -- Load the extensions after setup
      telescope.load_extension("project")
      telescope.load_extension("cheat")

      -- Keybindings
      local builtin = require("telescope.builtin")
      local map = vim.keymap.set
      map("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
      map("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
      map("n", "<leader>fs", builtin.current_buffer_fuzzy_find, { desc = "[F]ind in Buffer [S]tring" })
      map("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" }) -- Added for buffer searching
      map("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })   -- Added for help tags
      map("n", "<leader>fm", "<cmd>Telescope man_pages<cr>", { desc = "[F]ind [M]an Pages" })
      map("n", "<leader>fc", "<cmd>Telescope cheat<cr>", { desc = "[F]ind [C]heat Sheet" })
      map("n", "<leader>fp", "<cmd>Telescope project<cr>", { desc = "[F]ind [P]roject" })

    end,
  },

  -- Project Management
  {
    "ahmedkhalf/project.nvim",
    -- event = "VeryLazy", -- project.nvim often needs to scan early
    config = function()
      require("project_nvim").setup({
        -- Manual mode doesn't automatically change directories, which might be safer
        -- detection_methods = { "pattern" }, -- Only use patterns, not LSP
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "go.mod", "Cargo.toml", "pyproject.toml" }, -- Customize project root markers
        -- Configuration options for project.nvim
        -- silent_chdir = false, -- Notify about directory changes
      })
    end,
  },
}
