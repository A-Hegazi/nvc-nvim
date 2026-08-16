return {

    --conform formatter
    {
        "stevearc/conform.nvim",
        event = 'BufWritePre',
        opts = require "configs.conform",
    },

    -- lsp config for lsp servers
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },

    -- linting
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.lint")
        end,
    },


    -- test new blink
    { import = "nvchad.blink.lazyspec", },
    {
        "saghen/blink.cmp",
        opts = {
            keymap = {
                preset    = "default",
                --   -- ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
                --   -- ['<C-e>'] = false,
                --   -- ["<C-@>"]     = { "show" },
                ["<C-d>"] = { "scroll_documentation_down" },
                ["<C-u>"] = { "scroll_documentation_up" },
                ["<C-k>"] = { "show_documentation" },
                ["<C-j>"] = { "hide_documentation" },
                ["<C-s>"] = { "show_signature" },
                ["<C-h>"] = { "hide_signature" },
            },
            completion = {
                menu = { border = 'rounded' },
                documentation = { window = { border = 'rounded' } },
                ghost_text = { enabled = true },
            },
            signature = {
    enabled = true,
    window = {
        border = "rounded",
    },
},
            sources = { default = { "lsp", "path", "snippets", "buffer" } },
        },
    },

}
