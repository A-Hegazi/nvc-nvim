return {
  "CRAG666/code_runner.nvim",
  keys = {
    -- Basic runs
    { "<leader>rr", function() require("code_runner").run_code() end, desc = "Run code (auto-detect file/project)" },
    { "<leader>rf", function() require("code_runner").run_filetype() end, desc = "Run current file" },
    { "<leader>rp", function() require("code_runner").run_project() end, desc = "Run current project" },

    -- Views
    { "<leader>rt", function() require("code_runner").run_filetype("tab") end,   desc = "Run file in new tab" },
    { "<leader>rl", function() require("code_runner").run_filetype("float") end, desc = "Run file in floating window" },

    -- Splits (term mode with position switching)
    { "<leader>rs", function() _G.CodeRunnerRunHSplit() end, desc = "Run file in horizontal split" },
    { "<leader>rv", function() _G.CodeRunnerRunVSplit() end, desc = "Run file in vertical split" },

    -- Close
    { "<leader>rc", function() require("code_runner").run_close() end, desc = "Close runner" },

    -- Inspect
    { "<leader>rF", function() require("code_runner").get_filetype_command() end, desc = "Show filetype command" },
    { "<leader>rP", function() require("code_runner").get_project_command() end,  desc = "Show project command" },

    -- Custom
    { "<leader>rR", function() require("code_runner").run_from_fn() end, desc = "Run custom command" },
  },

  config = function()
    local cr = require("code_runner")

    -- your base (default) configuration
    local base_opts = {
      mode = "term", -- use built-in terminal
      focus = true,
      startinsert = true,
      term = { position = "belowright", size = 15 }, -- default to horizontal
      float = { border = "rounded", width = 0.9, x = 0.5, y = 0.5 },
      filetype = {
        java = { "cd $dir &&", "javac $fileName &&", "java $fileNameWithoutExt" },
        python = "python3 -u",
        typescript = "deno run",
        rust = { "cd $dir &&", "rustc $fileName &&", "$dir/$fileNameWithoutExt" },

        -- simple C (non-interactive)
        c = {
          "cd $dir && gcc $fileName -o /tmp/$fileNameWithoutExt",
          "&& /tmp/$fileNameWithoutExt",
        },
      },
    }

    cr.setup(base_opts)

    -- helpers to change split orientation on-the-fly
    local function run_with(opts)
      -- merge without losing your filetype table
      local merged = vim.tbl_deep_extend("force", base_opts, opts or {})
      cr.setup(merged)
      cr.run_filetype()
      -- restore default behavior
      cr.setup(base_opts)
    end

    -- expose as globals for keymaps above
    _G.CodeRunnerRunHSplit = function()
      run_with({ mode = "term", term = { position = "belowright", size = 15 } })
    end

    _G.CodeRunnerRunVSplit = function()
      run_with({ mode = "term", term = { position = "rightbelow vertical", size = 80 } })
    end
  end,
}