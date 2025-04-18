 -- ~/.config/nvim/lua/plugins/lsp.lua

return {
  -- LSP Configuration & Management
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and formatters to stdpath for Neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim", -- Optional: Auto install tools

      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim", opts = {} },

      -- Autocompletion
      "hrsh7th/nvim-cmp",         -- Required
      "hrsh7th/cmp-nvim-lsp",     -- Required
      "hrsh7th/cmp-buffer",       -- Optional
      "hrsh7th/cmp-path",         -- Optional
      "hrsh7th/cmp-cmdline",      -- Optional
      "L3MON4D3/LuaSnip",         -- Required for snippet support
      "saadparwaiz1/cmp_luasnip", -- Required for snippet support with nvim-cmp
    },
    config = function()
      -- Setup Mason
      require("mason").setup()
      require("mason-lspconfig").setup({
        -- Ensure these servers are installed automatically via Mason
        ensure_installed = {
          "gopls",
          "pyright",        -- Python LSP
          "svelte",         -- Svelte LSP
          "tailwindcss",    -- TailwindCSS LSP
          "html",           -- HTML LSP
          "cssls",          -- CSS LSP
          "clangd",         -- C/C++ LSP
          "yamlls",         -- YAML LSP (for Helm, etc.)
          "jsonls",         -- JSON LSP
          "dockerls",       -- Dockerfile LSP
          "bashls",         -- Bash LSP (good for scripts, sometimes Dockerfiles)
          "golangci_lint_ls", 
        },
      })

      -- Optional: Automatically install mason tools listed in ensure_installed
      require("mason-tool-installer").setup({
        ensure_installed = {
           "stylua", -- Lua formatter
           "gofumpt", -- Go formatter
           "goimports", -- Go imports tool
           "prettierd", -- JS/TS/CSS/HTML/JSON/YAML Formatter
           "black", -- Python formatter
           "isort", -- Python import sorter
           "clang-format", -- C/C++ formatter
            "delve",
            "golangci-lint",
           -- Add other linters/formatters here
        }
      })

      -- Setup nvim-cmp.
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- <<< CHANGE/ADD THIS
          ["<C-j>"] = cmp.mapping.select_next_item(), -- <<< CHANGE/ADD THIS
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For snippets
          { name = "buffer" },  -- For buffer word completion
          { name = "path" },    -- For path completion
        }),
      })

      -- Set up lspconfig.
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Define the on_attach function to enable keybindings for LSP actions
      local on_attach = function(client, bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr, noremap = true, silent = true }

        -- Enable completion triggered by <c-x><c-o>
        -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- LSP Keybindings (use opts defined above)
        map("n", "gd", vim.lsp.buf.definition, opts)                     -- Go to definition
        map("n", "gD", vim.lsp.buf.declaration, opts)                   -- Go to declaration
        map("n", "gr", vim.lsp.buf.references, opts)                    -- Show references
        map("n", "gi", vim.lsp.buf.implementation, opts)                -- Go to implementation
        map("n", "K", vim.lsp.buf.hover, opts)                          -- Show hover information
        map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)      -- Workspace symbols
        map("n", "<leader>vd", vim.diagnostic.open_float, opts)         -- Show diagnostics for line
        map("n", "[d", vim.diagnostic.goto_prev, opts)                  -- Go to previous diagnostic
        map("n", "]d", vim.diagnostic.goto_next, opts)                  -- Go to next diagnostic
        map("n", "<leader>ca", vim.lsp.buf.code_action, opts)           -- Show code actions
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)                -- Rename symbol
        -- map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts) -- Format buffer

        --Optional: Highlight symbol under cursor
       --if client.server_capabilities.documentHighlightProvider then
       --  vim.cmd([[
       --    hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
       --    hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
       --    hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
       --  ]])
       --  vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
       --  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
       --    buffer = bufnr,
       --    group = "lsp_document_highlight",
       --    callback = vim.lsp.buf.document_highlight,
       --  })
       --  vim.api.nvim_create_autocmd("CursorMoved", {
       --    buffer = bufnr,
       --    group = "lsp_document_highlight",
       --    callback = vim.lsp.buf.clear_references,
       --  })
       --end
      end

      -- Get the list of servers setup by mason-lspconfig
      local servers = require("mason-lspconfig").get_installed_servers()

      -- Setup LSP servers
      local lspconfig = require("lspconfig")
      for _, server_name in ipairs(servers) do
        if server_name ~= "gopls" and server_name ~= "golangci_lint_ls" and server_name ~= "yamlls" and server_name ~= "tailwindcss" and server_name ~= "pyright" then
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
        end
      end

      -- Specific server configurations (if needed)
      -- Example: Configure gopls
      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            -- Example: Enable staticcheck analysis
            analyses = {
              staticcheck = false,
            },
            -- Example: Use goimports for formatting
            usePlaceholders = true,
            gofumpt = true, -- Requires gofumpt installed via mason
          },
        },
      })

     lspconfig.golangci_lint_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        -- Crucial: Specify filetypes otherwise it might attach everywhere
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        -- Optional: If you have a specific config file or need arguments
        -- cmd = {"golangci-lint-langserver", "--config", "/path/to/.golangci.yml"},
         -- root_dir = lspconfig.util.root_pattern(".git", ".golangci.yml", "go.mod"), -- Default root detection is usually sufficient
      })

       -- Example: Configure pyright to use black and isort (requires them installed via mason)
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              -- typeCheckingMode = "basic", -- or "strict"
            },
          },
        },
      })


       -- Example: Configure tailwindcss-language-server
       lspconfig.tailwindcss.setup({
         on_attach = on_attach,
         capabilities = capabilities,
         -- filetypes = { "svelte", "typescriptreact", "javascriptreact", "html", "css" }, -- Add other filetypes if needed
         -- Add any other specific tailwindcss settings here
       })

      -- Example: Configure yamlls for Helm charts
      lspconfig.yamlls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          yaml = {
            schemas = require('schemastore').yaml.schemas(), -- Use JSON schema store
            -- Add custom schemas if needed, e.g., for Helm
            --[[
            schemas = {
              ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/helm/all.json"] = "Chart.yaml",
              ["kubernetes"] = "*.yaml" -- Generic Kubernetes schema
            },
            --]]
            validate = true,
            -- hover = true,
            -- completion = true,
          },
        },
      })

      -- Add other custom LSP server configurations here if needed

    end,
  },

  -- Optional: Add SchemaStore for JSON/YAML schema validation (if yamlls doesn't provide enough)
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
  }

}
