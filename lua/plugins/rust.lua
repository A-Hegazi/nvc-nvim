return {
    {
        "mrcjkb/rustaceanvim",
        version = "^6",
        ft = { "rust" },

        keys = {
            {
                "<leader>lp",
                function()
                    if not vim.lsp.inlay_hint then
                        return
                    end

                    local bufnr = vim.api.nvim_get_current_buf()
                    local group = vim.api.nvim_create_augroup("RustPeekInlayHints", { clear = false })

                    -- show hints now
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

                    -- remove old autocmds for this buffer/group so it does not stack
                    vim.api.nvim_clear_autocmds({
                        group = group,
                        buffer = bufnr,
                    })

                    -- hide hints on the next meaningful action
                    vim.api.nvim_create_autocmd({
                        "CursorMoved",
                        "CursorMovedI",
                        "InsertEnter",
                        "BufLeave",
                        "WinLeave",
                    }, {
                        group = group,
                        buffer = bufnr,
                        once = true,
                        callback = function()
                            if vim.api.nvim_buf_is_valid(bufnr) and vim.lsp.inlay_hint then
                                vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
                            end
                        end,
                    })
                end,
                desc = "LSP peek inlay hints",
            },

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
                            vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
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
