require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")


-- Resizing
map("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })

-- Better J behavior
map("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- -- File Explorer
-- map("n", "<leader>m", "<Cmd>NvimTreeFocus<CR>", { desc = "Focus on File Explorer" })

--Move lines up and down
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Paste stuff
map("x", "<leader>l", [["_dP]], { desc = "Paste over selection without overwriting clipboard" })
map("v", "<leader>P", '"_dp', { desc = "Paste over selection and after courser without overwriting clipboard" })

-- leader d delete wont remember as yanked/clipboard when delete pasting
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })


-- Replace the word cursor is on globally
map("n", "<leader>W", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word cursor is on globally" })

-- tab stuff
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "close current tab" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "go to next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "go to pre tab" })
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "open current tab in new tab" })

-- Copy filepath to the clipboard
map("n", "<leader>i", function()
    local filePath = vim.fn.expand("%:~")                -- Gets the file path relative to the home directory
    vim.fn.setreg("+", filePath)                         -- Copy the file path to the clipboard register
    print("File path copied to clipboard: " .. filePath) -- Optional: print message to confirm
end, { desc = "Copy file path to clipboard" })

-- Toggle LSP diagnostics visibility
local isLspDiagnosticsVisible = true
map("n", "<leader>ld", function()
    isLspDiagnosticsVisible = not isLspDiagnosticsVisible
    vim.diagnostic.config({
        virtual_text = isLspDiagnosticsVisible,
        underline = isLspDiagnosticsVisible
    })
end, { desc = "Toggle LSP diagnostics" })



-- ================================================================================================
--remove & change NvChad old keymaps
-- ================================================================================================
-- Change relative number toggle
vim.keymap.del("n", "<leader>rn")
map("n", "<leader>.", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })

-- Remove nvim-tree keymaps
vim.keymap.del("n", "<leader>e")
vim.keymap.del("n", "<C-n>")

-- Change Telescope old keymaps
vim.keymap.del("n", "<leader>ma")
vim.keymap.del("n", "<leader>cm")
vim.keymap.del("n", "<leader>gt")
vim.keymap.del("n", "<leader>pt")
vim.keymap.del("n", "<leader>th")
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fc", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>fg", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>fr", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>ft", function() require("nvchad.themes").open() end, { desc = "telescope nvchad themes" })

-- global lsp mappings
vim.keymap.del("n", "<leader>ds")
map("n", "<leader>ls", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })
-- Show diagnostic error under cursor in a floating window
map("n", "gl", vim.diagnostic.open_float, { desc = "Show floating diagnostic" })

-- Change format file to leader + z
map({ "n", "x" }, "<leader>z", function()
    require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

-- Change sheetche keymap to <leader>c
vim.keymap.del("n", "<leader>ch")
map("n", "<leader>c", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })
