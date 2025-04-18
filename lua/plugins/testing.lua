-- ~/.config/nvim/lua/plugins/testing.lua

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter", -- Required for identification
      "MunifTanjim/nui.nvim",
      "nvim-neotest/neotest-go", -- Go adapter
      "mfussenegger/nvim-dap", -- Optional: dependency for debug capabilities
    },
    config = function()
      local neotest = require("neotest")

      neotest.setup({
        -- Library/adapter configuration
        adapters = {
          require("neotest-go")({
            -- Optional: customize 'go test' command arguments if needed
            -- args = { "-v", "-race" }
          }),
        },
        -- Other neotest options
        status = { virtual_text = true },
        output = { enabled = true, open_on_run = "short" }, -- Tweak opening behavior
        quickfix = {
          enabled = true,
          open = function()
             -- Only open quickfix if there are entries
             if #vim.fn.getqflist() > 0 then
                vim.cmd("copen")
             end
          end
        }
        -- summary = { enabled = true, open = "botright" } -- Example: Adjust summary window position
      })

      -- Keymaps for testing
      local map = vim.keymap.set
      map("n", "<leader>tn", function() neotest.run.run() end, { desc = "Run Nearest Test" })
      map("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run File Tests" })
      map("n", "<leader>ts", function() neotest.run.run(vim.uv.cwd()) end, { desc = "Run Suite Tests" }) -- Run tests in current working directory
      map("n", "<leader>ta", function() neotest.run.attach() end, { desc = "Attach to Nearest Test" }) -- For debugging tests
      map("n", "<leader>to", function() neotest.output.open({ enter = true }) end, { desc = "Show Test Output" })
      map("n", "<leader>tS", function() neotest.summary.toggle() end, { desc = "Toggle Test Summary" })
      map("n", "<leader>tx", function() neotest.run.stop() end, { desc = "Stop Nearest Test" })
    end,
  },
}
