-- ~/.config/nvim/lua/plugins/treesitter.lua

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Ensure these language parsers are installed
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "css",
          "dockerfile",
          "go",
          "gomod", -- Go modules
          "gosum", -- Go sum file
          "html",
          "javascript",
          "json",
          "lua",
          "python",
          "svelte",
          "typescript",
          "yaml",
          "vim", -- For vimscript in config
          "vimdoc",
          "query", -- For Treesitter query files themselves
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- Enable syntax highlighting
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },

        -- Enable indentation based on treesitter (experimental)
        indent = {
          enable = true,
        },

        -- Add other Treesitter modules here if desired (e.g., incremental selection)
        -- incremental_selection = {
        --   enable = true,
        --   keymaps = {
        --     init_selection = "<c-space>",
        --     node_incremental = "<c-space>",
        --     scope_incremental = "<c-s>",
        --     node_decremental = "<bs>",
        --   },
        -- },
      })
    end,
  },
}
