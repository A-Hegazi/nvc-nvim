return {
  "thePrimeagen/harpoon",
  enabled = true,
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  -- All keymaps are now defined in this table
  keys = {
    { "<leader>oa", function() require("harpoon"):list():add() end,desc = "Harpoon: Add file",},
    { "<leader>ot", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon: Toggle quick menu",},
    {"<leader>o1", function() require("harpoon"):list():select(1) end, desc = "Harpoon: Go to file 1",},
    {"<leader>o2", function() require("harpoon"):list():select(2) end, desc = "Harpoon: Go to file 2",},
    {"<leader>o3", function() require("harpoon"):list():select(3) end, desc = "Harpoon: Go to file 3",},
    {"<leader>o4", function() require("harpoon"):list():select(4) end, desc = "Harpoon: Go to file 4",},
    {"<leader>op",function() require("harpoon"):list():prev() end, desc = "Harpoon: Go to previous file",},
    {"<leader>on",function() require("harpoon"):list():next() end, desc = "Harpoon: Go to next file",},

  },
  -- The config function is now only used for setting up the plugin
  config = function()
    require("harpoon"):setup({
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
      },
    })
  end,
}