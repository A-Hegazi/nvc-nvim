return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    -- create the mappings early; they also become lazy-load triggers
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Oil: open parent directory" },
      { "<leader>-", function() require("oil").toggle_float() end, desc = "Oil: toggle float" },
    },

    opts = {
      columns = {},
      keymaps = {
        ["<C-h>"] = false,
        ["<C-c>"] = false,
        ["<M-h>"] = "actions.select_split",
        ["q"]     = "actions.close",
      },
      delete_to_trash = true,
      view_options = { show_hidden = true },
      skip_confirm_for_simple_edits = true,
    },

    config = function(_, opts)
      require("oil").setup(opts)

      -- oil buffer tweaks / conflict fixes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function()
          vim.opt_local.cursorline = true
          -- Neutralize NvChad’s global <C-h>/<C-l>/<C-j>/<C-k> in Oil buffer
          for _, lhs in ipairs({ "<C-h>", "<C-j>", "<C-k>", "<C-l>" }) do
            vim.keymap.set("n", lhs, "<NOP>", { buffer = true, silent = true })
          end
        end,
      })
    end,
  },
}