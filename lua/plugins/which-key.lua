return {
  "folke/which-key.nvim",
  opts = function()
    dofile(vim.g.base46_cache .. "whichkey")
    return {
      -- optional: keep which-key’s own icons for mappings/groups
      -- icons = { mappings = true },
    }
  end,
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- ✅ Add icons to existing mappings
    wk.add({
      -- Keys mapping icons
      { "<leader>u",  desc = "Undo Tree", icon = { icon = "", color = "red" }, mode = "n" },
      { "<leader>x",  desc = "Buffer Close", icon = { icon = "󰅗", color = "red" }, mode = "n" },
      { "<leader>W",  desc = "Replace word under cursor globally", icon = { icon = "", color = "red" }, mode = "n" },
      { "<leader>d",  desc = "Delete without yanking", icon = { icon = "", color = "red" }, mode = "n" },

      -- Group icons (applies to the group line)
    { "<leader>e", group = "Neo-tree", mode = "n", icon = { icon = "", color = "cyan" } },
    { "<leader>E", group = "Neo-tree Floating", mode = "n", icon = { icon = "", color = "cyan" } },
    { "<leader>T", group = "Trouble", mode = "n" },
    { "<leader>f", group = "Telescope & Find", mode = "n" },
    { "<leader>m", group = "Mini-Nvim", mode = "n",icon = "" },
    { "<leader>o", group = "Harpoon", mode = "n",icon = ""},
    { "<leader>s", group = "Snacks", mode = "n",icon = ""},
    { "<leader>sl", group = "Snacks Lazygit", mode = "n" },
    { "<leader>r", group = "Run Code", mode = "n",icon = "" },
    { "<leader>t", group = "Tabs stuff", mode = "n" },
    { "<leader>p", group = "Snacks Picker", mode = "n",icon ="󰈞" },
    { "<leader>pf", group = "Find", mode = "n" },
    { "<leader>pg", group = "Git", mode = "n" },
    { "<leader>ps", group = "Search", mode = "n" },
    { "<leader>pl", group = "LSP", mode = "n" },
    { "<leader>pr", group = "Grep", mode = "n" },
    { "<leader>w", group = "Which Key", mode = "n" },
    { "<leader>g", group = "git plugins", mode = "n" },
    { "<leader>gl", group = "Lazy Git", mode = "n" },
    { "<leader>gf", group = "fugitive", mode = "n" },
    { "<leader>gs", group = "Git signs", mode = "n" },
    { "<leader>gw", group = "Git worktree", mode = "n" },
    { "<leader>l", group = "LSP", mode = "n",icon = { icon = "", color = "azure" } },
    { "<leader>a", group = "Copilot", mode = "n","v"},
    })

  end,
}

--icon colors: azure, blue, cyan, green, grey, orange, purple, red, yellow