return {
    {
        "mrcjkb/rustaceanvim",
        version = "^6",
        ft = { "rust" },

        keys = {
            {
                "<leader>lh",
                function()
                    if not vim.lsp.inlay_hint then
                        return
                    end

                    local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
                    vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
                end,
                desc = "LSP toggle inlay hints",
            },

            { "<M-C-a>", function() vim.lsp.buf.hover() end, desc = "Rust hover / type info" },
        },

        init = function()
            vim.g.rustaceanvim = {
                server = {
                    on_attach = function(_, bufnr)
                        if vim.lsp.inlay_hint then
                            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                        end
                    end,

                    default_settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                            },
                            checkOnSave = true,
                            check = {
                                command = "clippy",
                            },
                            procMacro = {
                                enable = true,
                            },
                            inlayHints = {
                                bindingModeHints = { enable = true },
                                chainingHints = { enable = true },
                                closingBraceHints = { enable = true, minLines = 1 },
                                closureReturnTypeHints = { enable = "with_block" },
                                lifetimeElisionHints = {
                                    enable = "skip_trivial",
                                    useParameterNames = true,
                                },
                                parameterHints = { enable = true },
                                reborrowHints = { enable = "mutable" },
                                typeHints = { enable = true },
                            },
                        },
                    },
                },
            }
        end,
    },

    {
        "saecki/crates.nvim",
        ft = { "toml" },
        config = function()
            require("crates").setup()
        end,
    },
}
