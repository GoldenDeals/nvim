-- ~/.config/nvim/lua/plugins/editing.lua

return {
	-- Surround plugin
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	-- Commenting plugin
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		opts = {}, -- Use opts = {} for lazy loading with default setup
		-- config = function() require('Comment').setup() end -- Alternatively use config function
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2", -- Use the recommended harpoon2 branch
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			-- REQUIRED: Setup harpoon BEFORE defining keymaps
			harpoon.setup({})

			local map = vim.keymap.set

			-- Basic Harpoon bindings
			map("n", "<leader>a", function()
				harpoon:list():add()
			end, { desc = "[A]dd file to Harpoon list" })
			map("n", "<leader>A", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Toggle Harpoon Menu" })

			-- Navigation bindings (<leader>1 through <leader>9)
			for i = 1, 9 do
				map("n", string.format("<leader>%d", i), function()
					harpoon:list():select(i)
				end, { desc = string.format("Harpoon to file %d", i) })
			end

			-- Navigation binding for <leader>0 (maps to 10th item)
			map("n", "<leader>0", function()
				harpoon:list():select(10)
			end, { desc = "Harpoon to file 10" })

			--Optional: Cycle through marks
			map("n", "<C-h>", function()
				harpoon:list():prev()
			end, { desc = "Harpoon previous" })
			map("n", "<C-l>", function()
				harpoon:list():next()
			end, { desc = "Harpoon next" })
		end,
		event = "VeryLazy", -- Or load on startup if you use it constantly
	},

	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "isort", "black" },
					-- You can customize some of the format options for the filetype (:help conform.format)
					rust = { "rustfmt", lsp_format = "fallback" },
					-- Conform will run the first available formatter
					javascript = { "prettierd", "prettier", stop_after_first = true },
					go = { "gofumt", "goimports", "golines" },
					c = { "astyle" },
					cpp = { "astyle" },
				},
			})
		end,
	},
}
