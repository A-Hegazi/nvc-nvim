return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	opts = {
		focus = true,
	},
	cmd = "Trouble",
	keys = {
		{ "<leader>Tq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
		{ "<leader>Tt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" },
		{"<leader>Tx","<cmd>Trouble diagnostics toggle<cr>",desc = "Workspace Diagnostics (Trouble)",},
		{"<leader>TX","<cmd>Trouble diagnostics toggle filter.buf=0<cr>",desc = "Buffer Diagnostics (Trouble)",},
		{"<leader>TS","<cmd>Trouble symbols toggle focus=false<cr>",desc = "Symbols (Trouble)",},
		{"<leader>Tl","<cmd>Trouble lsp toggle focus=false win.position=right<cr>",desc = "LSP Definitions / references / ... (Trouble)",},
		{"<leader>TL","<cmd>Trouble loclist toggle<cr>",desc = "Location List (Trouble)",},
		{"<leader>TQ","<cmd>Trouble qflist toggle<cr>",desc = "Quickfix List (Trouble)",},
	},
}