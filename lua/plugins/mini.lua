return {
  -- Mini Trailspace (This plugin is separate and was configured correctly)
  {
    "nvim-mini/mini.trailspace",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>mh", function() require("mini.trailspace").highlight() end, desc = "Highlight trailing spaces" },
      { "<leader>mu", function() require("mini.trailspace").unhighlight() end, desc = "Unhighlight trailing spaces" },
      { "<leader>mt", function() require("mini.trailspace").trim() end, desc = "Trim trailing spaces" },
      { "<leader>mr", function() require("mini.trailspace").trim_last_lines() end, desc = "Trim empty lines at EOF" },
    },
    config = function()
      require("mini.trailspace").setup({
        only_in_normal_buffers = true,
      })

      vim.api.nvim_create_autocmd("CursorMoved", {
        callback = function()
          require("mini.trailspace").unhighlight()
        end,
      })
    end,
  },

  -- This single entry correctly downloads the entire 'mini.nvim' suite (the "toolbox")
  {
    "echasnovski/mini.nvim",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>ms", function() require("mini.splitjoin").split() end, mode = { "n", "x" }, desc = "Split arguments" },
      { "<leader>mj", function() require("mini.splitjoin").join() end, mode = { "n", "x" }, desc = "Join arguments" },
    },
    config = function()
      -- Inside here, we enable the specific modules ("tools") you want to use.

      require("mini.surround").setup()
      require("mini.splitjoin").setup({ mappings = { toggle = "" } })
      
      -- This line will now work because the main package is loaded correctly.
      require("mini.cursorword").setup()
    end,
  },
}