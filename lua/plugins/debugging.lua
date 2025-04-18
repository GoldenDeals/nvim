-- ~/.config/nvim/lua/plugins/debugging.lua

return {
  -- Debug Adapter Protocol Client
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI for DAP
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {"nvim-neotest/nvim-nio"}, -- Recommended dependency for dap-ui
        config = function()
          local dapui = require("dapui")
          dapui.setup({
            layouts = {
              {
                elements = {
                  { id = "scopes", size = 0.25 },
                  { id = "breakpoints", size = 0.25 },
                  { id = "stacks", size = 0.25 },
                  { id = "watches", size = 0.25 },
                },
                size = 40, -- Width of the sidebar
                position = "left",
              },
              {
                elements = {
                  { id = "repl", size = 0.5 },
                  { id = "console", size = 0.5 },
                },
                size = 0.25, -- Height of the bottom panel
                position = "bottom",
              },
            },
            -- Other dapui config options...
            render = {
                 max_value_lines = 100, -- Increase max lines shown for variables
            }
          })

          -- Close dapui if DAP session ends
          local dap = require("dap")
          dap.listeners.after.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Configure Delve debugger adapter for Go
      dap.adapters.go = {
        type = "server",
        port = "${port}", -- Placeholder replaced during launch
        executable = {
          command = "dlv",
          -- Start delve in headless DAP mode, listening on the specified address/port
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      -- Define launch configurations for Go
      dap.configurations.go = {
        {
          type = "go",
          name = "Debug Current File",
          request = "launch",
          program = "${file}", -- Debug the current file
        },
        {
          type = "go",
          name = "Debug test (go test)", -- Matches neotest configuration
          request = "launch",
          mode = "test", -- Important: Tells Delve to run in test mode
          program = "${fileDirname}", -- Pass the directory for 'go test'
        },
        -- Add more configurations if needed (e.g., attach to process)
         {
           type = "go",
           name = "Attach to process",
           request = "attach",
           mode = "local",
           processId = require('dap.utils').pick_process, -- Helper to pick a process
         },
      }

      -- Keymaps for debugging
      local map = vim.keymap.set
      map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Set Conditional Breakpoint"})
      map("n", "<leader>dl", function() dap.launch_auto() end, { desc = "Launch Debugger (Auto)" }) -- Tries to guess config based on filetype
      map("n", "<leader>dc", dap.continue, { desc = "Continue" })
      map("n", "<leader>do", dap.step_over, { desc = "Step Over" })
      map("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      map("n", "<leader>ds", dap.step_out, { desc = "Step Out" }) -- 'S' for Step Out
      map("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
      map("n", "<leader>dk", dap.terminate, { desc = "Terminate Debugger" }) -- 'k' for kill/terminate

      -- Keymaps for DAP UI
      map("n", "<leader>du", dapui.toggle, { desc = "Toggle Debug UI" })
      map("n", "<leader>de", dapui.eval, { desc = "Eval under cursor"}) -- Eval expression under cursor
    end,
  }
}
