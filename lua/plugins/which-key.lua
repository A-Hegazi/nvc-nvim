return {
  "folke/which-key.nvim",
  opts = function()
    dofile(vim.g.base46_cache .. "whichkey")
    return {}
  end,
  config = function(_, opts)
    local wk = require "which-key"
    wk.setup(opts)

    wk.add {
      { "<leader>u", desc = "Undo Tree", icon = { icon = "", color = "red" }, mode = "n" },
      { "<leader>x", desc = "Buffer Close", icon = { icon = "󰅗", color = "red" }, mode = "n" },
      { "<leader>W", desc = "Replace word under cursor globally", icon = { icon = "", color = "red" }, mode = "n" },
      { "<leader>d", desc = "Delete without yanking", icon = { icon = "", color = "red" }, mode = "n" },

      { "<leader>a", group = "Copilot", icon = "", mode = { "n", "v" } },
      { "<leader>D", group = "Debugger", icon = { icon = "", color = "red" }, mode = "n" },
      { "<leader>e", group = "Neo-tree", icon = { icon = "", color = "cyan" }, mode = "n" },
      { "<leader>E", group = "Neo-tree Floating", icon = { icon = "", color = "cyan" }, mode = "n" },
      { "<leader>T", group = "Trouble", mode = "n" },
      { "<leader>f", group = "Telescope & Find", mode = "n" },
      { "<leader>g", group = "Git plugins", mode = "n" },
      { "<leader>gf", group = "Fugitive", mode = "n" },
      { "<leader>gl", group = "Lazygit", mode = "n" },
      { "<leader>gs", group = "Git signs", mode = "n" },
      { "<leader>gw", group = "Git worktree", mode = "n" },
      { "<leader>l", group = "LSP", icon = { icon = "", color = "azure" }, mode = "n" },
      { "<leader>m", group = "Mini-Nvim", icon = "", mode = "n" },
      { "<leader>o", group = "Harpoon", icon = "", mode = "n" },
      { "<leader>p", group = "Snacks Picker", icon = "󰈞", mode = "n" },
      { "<leader>pf", group = "Find", mode = "n" },
      { "<leader>pg", group = "Git", mode = "n" },
      { "<leader>pl", group = "LSP", mode = "n" },
      { "<leader>pr", group = "Grep", mode = "n" },
      { "<leader>ps", group = "Search", mode = "n" },
      { "<leader>r", group = "Run Code", icon = "", mode = "n" },
      { "<leader>R", group = "Rust", icon = { icon = "", color = "orange" }, mode = "n" },
      { "<leader>s", group = "Snacks", icon = "", mode = "n" },
      { "<leader>sl", group = "Snacks Lazygit", mode = "n" },
      { "<leader>t", group = "Tabs", mode = "n" },
      { "<leader>w", group = "Which Key", mode = "n" },
    }
  end,
}
