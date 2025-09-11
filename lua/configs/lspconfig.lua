require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "basedpyright" }
vim.lsp.enable(servers)

-- override NVChad's LSP keymaps
local aug = vim.api.nvim_create_augroup("MyLspKeymaps", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = aug,
  callback = function(args)
    local bufnr = args.buf

    -- 1) remove NVChad defaults you want to change
    local del = function(mode, lhs)
      pcall(vim.keymap.del, mode, lhs, { buffer = bufnr })
    end

    del("n", "<leader>D")
    del("n", "<leader>wa")
    del("n", "<leader>wr")
    del("n", "<leader>wl")
    del("n", "<leader>ra") -- NVChad renamer

    -- 2) add mappings (buffer-local)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP " .. (desc or "") })
    end

    -- examples (change to your taste)

    map("n", "K",  vim.lsp.buf.hover, "Hover")

    map("n", "<leader>la", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    map("n", "<leader>lo", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")

    map("n", "<leader>ll", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders")

    map("n", "<leader>lt", vim.lsp.buf.type_definition, "Go to type definition")
    map("n", "<leader>lr", require "nvchad.lsp.renamer", "NvRenamer")
  end,
})

-- read :h vim.lsp.config for changing options of lsp servers 
