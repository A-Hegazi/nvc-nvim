-- Linting configuration using nvim-lint
local lint = require("lint")

lint.linters_by_ft = {
  python = { "ruff" }, 
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})