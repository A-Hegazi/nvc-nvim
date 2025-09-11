return {
  ---------------------------------------------------------------------------
  -- 1) Copilot.vim — inline completions
  ---------------------------------------------------------------------------
  {
    "github/copilot.vim",
    event = "InsertEnter",
    keys = {
      -- NORMAL mode
      { "<leader>aa", "<cmd>Copilot<cr>",         desc = "Copilot: Panel / Toggle" },
      { "<leader>al", "<cmd>Copilot setup<cr>",   desc = "Copilot: Login / Setup" },
      { "<leader>as", "<cmd>Copilot status<cr>",  desc = "Copilot: Status" },
      { "<leader>aS", "<cmd>Copilot stop<cr>",    desc = "Copilot: Stop suggestions" },
      { "<leader>ae", "<cmd>Copilot enable<cr>",  desc = "Copilot: Enable" },
      { "<leader>ad", "<cmd>Copilot disable<cr>", desc = "Copilot: Disable" },

      -- INSERT mode
      { "<C-l>", 'copilot#Accept("<CR>")', mode = "i", expr = true, replace_keycodes = false, desc = "Copilot: Accept" },

      -- Use Alt+] / Alt+[ to cycle (avoid <C-[> which is <Esc>)
      { "<A-]>", "<Plug>(copilot-next)",     mode = "i", desc = "Copilot: Next suggestion" },
      { "<A-[>", "<Plug>(copilot-previous)", mode = "i", desc = "Copilot: Previous suggestion" },

      -- Dismiss
      { "<C-\\>", "<Plug>(copilot-dismiss)", mode = "i", desc = "Copilot: Dismiss suggestion" },

      -- Optional granular accept:
      -- { "<A-w>", "<Plug>(copilot-accept-word)", mode = "i", desc = "Copilot: Accept word" },
      -- { "<A-e>", "<Plug>(copilot-accept-line)", mode = "i", desc = "Copilot: Accept line" },
    },
  },

  ---------------------------------------------------------------------------
  -- 2) CopilotChat.nvim — chat about selection/file/repo
  ---------------------------------------------------------------------------
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "github/copilot.vim",
      "nvim-telescope/telescope.nvim",  -- optional picker
      "stevearc/dressing.nvim",         -- optional UI
    },
    cmd = {
      "CopilotChat", "CopilotChatOpen", "CopilotChatClose", "CopilotChatToggle",
      "CopilotChatExplain", "CopilotChatReview", "CopilotChatFix",
      "CopilotChatOptimize", "CopilotChatTests", "CopilotChatCommit",
      "CopilotChatReset", "CopilotChatStop", "CopilotChatModels",
    },
    opts = {
      window = {
        layout = "vertical",
        width = 0.38,
        border = "rounded",
      },
      prompts = {
        ExplainSelection = {
          prompt = "Explain this selection briefly, then suggest minimal safe improvements. Return patch if changes are needed.",
          selection = true,
        },
        RefactorSelection = {
          prompt = "Refactor the selected code to be clearer and safer. Preserve behavior. Return a unified diff patch.",
          selection = true,
        },
        ReviewFile = {
          prompt = "Review this file. Find bugs, edge cases, and style issues. Propose minimal diffs with explanations.",
          selection = false,
        },
        WriteTests = {
          prompt = "Write unit tests for the changed/selected code with clear Arrange-Act-Assert structure.",
          selection = true,
        },
      },
    },
    keys = {
      -- Chat panel
      { "<leader>ac", "<cmd>CopilotChatToggle<cr>", desc = "AI Chat: Toggle panel" },
      -- Quick ask about cursor/selection
      { "<leader>aq", "<cmd>CopilotChat<cr>", mode = { "n", "v" }, desc = "AI Chat: Quick ask" },
      -- Common tasks
      { "<leader>ax", "<cmd>CopilotChatExplain<cr>",  mode = { "n", "v" }, desc = "Explain code" },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>",   mode = { "n", "v" }, desc = "Review code" },
      { "<leader>af", "<cmd>CopilotChatFix<cr>",      mode = { "n", "v" }, desc = "Fix issues" },
      { "<leader>ao", "<cmd>CopilotChatOptimize<cr>", mode = { "n", "v" }, desc = "Optimize code" },
      { "<leader>at", "<cmd>CopilotChatTests<cr>",    mode = { "n", "v" }, desc = "Generate tests" },
      { "<leader>ag", "<cmd>CopilotChatCommit<cr>",   desc = "Generate commit message (staged)" },
      -- Session control
      { "<leader>aR", "<cmd>CopilotChatReset<cr>",    desc = "Reset chat session" },
      { "<leader>az", "<cmd>CopilotChatStop<cr>",     desc = "Stop current response" },
      { "<leader>am", "<cmd>CopilotChatModels<cr>",   desc = "Choose Copilot model" },
    },
  },
}