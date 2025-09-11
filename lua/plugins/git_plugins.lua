return {
  -- 1) Fugitive
  {
    "tpope/vim-fugitive",
    keys = {
      -- status / main
      { "<leader>gfg", "<cmd>Git<CR>", desc = "Fugitive: Git status", mode = "n" },

      -- blame / log / diff
      { "<leader>gfb", "<cmd>G blame<CR>", desc = "Fugitive: Blame", mode = "n" },
      { "<leader>gfl", "<cmd>Git log --oneline --decorate --graph --all<CR>", desc = "Fugitive: Log (graph)", mode = "n" },
      { "<leader>gfd", "<cmd>G diff<CR>", desc = "Fugitive: Diff", mode = "n" },
      { "<leader>gfs", "<cmd>Gvdiffsplit<CR>", desc = "Fugitive: Vsplit Diff", mode = "n" },

      -- staging / commit / push-pull
      { "<leader>gfa", "<cmd>Git add %<CR>", desc = "Fugitive: Add current file", mode = "n" },
      { "<leader>gfc", "<cmd>Git commit<CR>", desc = "Fugitive: Commit", mode = "n" },
      { "<leader>gfp", "<cmd>Git push<CR>", desc = "Fugitive: Push", mode = "n" },
      { "<leader>gfP", "<cmd>Git pull --rebase<CR>", desc = "Fugitive: Pull (rebase)", mode = "n" },

      -- checkout / branch
      { "<leader>gfo", "<cmd>Git checkout %<CR>", desc = "Fugitive: Checkout current file", mode = "n", cond = false }, -- example alt
      { "<leader>gfB", "<cmd>Git branch<CR>", desc = "Fugitive: Branch list", mode = "n", cond = false },
    },
  },

  -- 2) Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    keys = {
      -- hunk operations
      { "<leader>gss", function() require("gitsigns").stage_hunk() end, desc = "Gitsigns: Stage hunk", mode = { "n", "v" } },
      { "<leader>gsu", function() require("gitsigns").undo_stage_hunk() end, desc = "Gitsigns: Undo stage hunk", mode = "n" },
      { "<leader>gsr", function() require("gitsigns").reset_hunk() end, desc = "Gitsigns: Reset hunk", mode = { "n", "v" } },
      { "<leader>gsR", function() require("gitsigns").reset_buffer() end, desc = "Gitsigns: Reset buffer", mode = "n" },
      { "<leader>gsp", function() require("gitsigns").preview_hunk() end, desc = "Gitsigns: Preview hunk", mode = "n" },

      -- info / blame / diff
      { "<leader>gsb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Gitsigns: Blame line", mode = "n" },
      { "<leader>gsd", function() require("gitsigns").diffthis() end, desc = "Gitsigns: Diff this", mode = "n" },
      { "<leader>gsD", function() require("gitsigns").diffthis("~") end, desc = "Gitsigns: Diff against ~", mode = "n" },

      -- navigate hunks
      { "<leader>gsn", function() require("gitsigns").next_hunk() end, desc = "Gitsigns: Next hunk", mode = "n" },
      { "<leader>gsP", function() require("gitsigns").prev_hunk() end, desc = "Gitsigns: Previous hunk", mode = "n" },
    },
  },

  -- 3) Git Worktree
  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("git-worktree").setup()
    end,
    keys = {
      { "<leader>gwc", function() require("telescope").extensions.git_worktree.create_git_worktree() end, desc = "Worktree: Create", mode = "n" },
      { "<leader>gws", function() require("telescope").extensions.git_worktree.git_worktrees() end,     desc = "Worktree: Switch", mode = "n" },
      { "<leader>gwd", function() require("git-worktree").delete_worktree() end,                        desc = "Worktree: Delete", mode = "n" },
    },
  },

    --   -- Lazy git 
    -- {
    --     "kdheepak/lazygit.nvim",
    --     --NOTE: Trying out lazygit in Snacks nvim
    --     enabled = false,
    --     cmd = {
    --         "LazyGit",
    --         "LazyGitConfig",
    --         "LazyGitCurrentFile",
    --         "LazyGitFilter",
    --         "LazyGitFilterCurrentFile",
    --     },
    --     -- window border thing
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --     },
    --     -- setting up with keys={} allows plugin to load when command runs at the start
    --     keys = {
    --         { "<leader>gll", function() require("snacks").lazygit() end, desc = "Lazygit" },
    --         { "<leader>glg", function() require("snacks").lazygit.log() end, desc = "Lazygit Logs" },
    --     },
    -- }
}