return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false, -- neo-tree will lazily load itself
    keys = {
      {"<leader>ef","<cmd>Neotree toggle focus filesystem reveal left<CR>",desc = "Neo-tree: Toggle file explorer",},
      {"<leader>eg","<cmd>Neotree toggle focus git_status reveal left<CR>",desc = "Neo-tree: Toggle Git status",},
      {"<leader>eb","<cmd>Neotree toggle focus buffers reveal left<CR>",desc = "Neo-tree: Toggle buffers",},
      {"<leader>Ef","<cmd>Neotree float filesystem reveal=true<CR>",desc = "Neo-tree: Float file explorer",},
      {"<leader>Eg","<cmd>Neotree float git_status reveal=true<CR>",desc = "Neo-tree: Float Git status",},
      {"<leader>Eb","<cmd>Neotree float buffers reveal=true<CR>",desc = "Neo-tree: Float buffers",},
      {"<leader>es","<cmd>Neotree toggle document_symbols<CR>",desc = "Neo-tree: Toggle document symbols",},
    },
    config = function()
      require("neo-tree").setup({
        -- filesystem = { follow_current_file = { enabled = true } },
         window = {
          mappings = {
            ["<Tab>"] = {
                "toggle_node",
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
          },
        },
          sources = {
    "filesystem",
    "buffers",
    "git_status",
    "document_symbols",
  },
  source_selector = {
    winbar = true,  -- show tabs in the window bar
    statusline = false, -- or true if you want it there instead
  },

  filesystem = {
    follow_current_file = { enabled = true },
    hijack_netrw_behavior = "open_default", -- recommended
  },
  buffers = {
    follow_current_file = { enabled = true },
  },
      })
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    version = "2.*",
    config = function()
      require("window-picker").setup({
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal", "quickfix" },
          },
        },
      })
    end,
  },
}