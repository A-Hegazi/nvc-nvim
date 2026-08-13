local parsers = {
  "bash",
  "c",
  "css",
  "dockerfile",
  "gitignore",
  "go",
  "graphql",
  "html",
  "http",
  "java",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "prisma",
  "python",
  "query",
  "regex",
  "ron",
  "rust",
  "svelte",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

local selection = {}

local function select_node(node)
  if not node then
    return
  end

  local start_row, start_col, end_row, end_col = node:range()
  if end_col == 0 and end_row > start_row then
    end_row = end_row - 1
    local end_line = vim.api.nvim_buf_get_lines(0, end_row, end_row + 1, false)[1] or ""
    end_col = #end_line
  end

  end_col = math.max(end_col - 1, 0)
  vim.cmd "normal! \27"
  vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
  vim.cmd "normal! v"
  vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col })
end

local function start_selection()
  local bufnr = vim.api.nvim_get_current_buf()
  local node = vim.treesitter.get_node { bufnr = bufnr }
  if not node then
    return
  end

  selection[bufnr] = { nodes = { node }, index = 1 }
  select_node(node)
end

local function expand_selection()
  local bufnr = vim.api.nvim_get_current_buf()
  local state = selection[bufnr]
  if not state then
    start_selection()
    return
  end

  if state.index == #state.nodes then
    local parent = state.nodes[state.index]:parent()
    if parent then
      table.insert(state.nodes, parent)
    end
  end

  state.index = math.min(state.index + 1, #state.nodes)
  select_node(state.nodes[state.index])
end

local function shrink_selection()
  local bufnr = vim.api.nvim_get_current_buf()
  local state = selection[bufnr]
  if not state then
    return
  end

  state.index = math.max(state.index - 1, 1)
  select_node(state.nodes[state.index])
end

local function setup_textobjects()
  require("nvim-treesitter-textobjects").setup {
    select = { lookahead = true },
    move = { set_jumps = true },
  }

  local select = require "nvim-treesitter-textobjects.select"
  local move = require "nvim-treesitter-textobjects.move"
  local swap = require "nvim-treesitter-textobjects.swap"

  local function map_select(lhs, query, desc)
    vim.keymap.set({ "x", "o" }, lhs, function()
      select.select_textobject(query, "textobjects")
    end, { desc = "Treesitter select " .. desc })
  end

  map_select("af", "@function.outer", "outer function")
  map_select("if", "@function.inner", "inner function")
  map_select("ac", "@class.outer", "outer class")
  map_select("ic", "@class.inner", "inner class")
  map_select("aa", "@parameter.outer", "outer argument")
  map_select("ia", "@parameter.inner", "inner argument")

  vim.keymap.set({ "n", "x", "o" }, "]f", function()
    move.goto_next_start("@function.outer", "textobjects")
  end, { desc = "Treesitter next function" })
  vim.keymap.set({ "n", "x", "o" }, "[f", function()
    move.goto_previous_start("@function.outer", "textobjects")
  end, { desc = "Treesitter previous function" })
  vim.keymap.set({ "n", "x", "o" }, "]a", function()
    move.goto_next_start("@parameter.inner", "textobjects")
  end, { desc = "Treesitter next argument" })
  vim.keymap.set({ "n", "x", "o" }, "[a", function()
    move.goto_previous_start("@parameter.inner", "textobjects")
  end, { desc = "Treesitter previous argument" })

  vim.keymap.set("n", "<leader>msn", function()
    swap.swap_next "@parameter.inner"
  end, { desc = "Treesitter swap with next argument" })
  vim.keymap.set("n", "<leader>msp", function()
    swap.swap_previous "@parameter.inner"
  end, { desc = "Treesitter swap with previous argument" })
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        lazy = false,
      },
    },
    config = function()
      local treesitter = require "nvim-treesitter"
      treesitter.setup {}
      if not vim.env.CI then
        treesitter.install(parsers)
      end

      local group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(args)
          local filetype = vim.bo[args.buf].filetype
          local language = vim.treesitter.language.get_lang(filetype) or filetype
          local ok = pcall(vim.treesitter.start, args.buf, language)
          if ok then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      vim.keymap.set("n", "<CR>", start_selection, { desc = "Treesitter start selection" })
      vim.keymap.set("x", "<CR>", expand_selection, { desc = "Treesitter expand selection" })
      vim.keymap.set("x", "<Tab>", expand_selection, { desc = "Treesitter expand scope selection" })
      vim.keymap.set("x", "<S-Tab>", shrink_selection, { desc = "Treesitter shrink selection" })

      setup_textobjects()
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
    },
  },
}
