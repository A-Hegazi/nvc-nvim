return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- This legacy branch matches Neovim 0.11 and the current NvChad setup.
    -- Migrate to the maintained Treesitter branch together with Neovim 0.12.
    branch = "master",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
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
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
          },
        },
        additional_vim_regex_highlighting = false,
      }
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
