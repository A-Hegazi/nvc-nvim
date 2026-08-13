return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
    "mrcjkb/rustaceanvim",
  },
  keys = {
    {
      "<leader>Nn",
      function()
        require("neotest").run.run()
      end,
      desc = "Tests run nearest",
    },
    {
      "<leader>Nf",
      function()
        require("neotest").run.run(vim.fn.expand "%")
      end,
      desc = "Tests run current file",
    },
    {
      "<leader>Na",
      function()
        require("neotest").run.run(vim.uv.cwd())
      end,
      desc = "Tests run project",
    },
    {
      "<leader>Nd",
      function()
        require("neotest").run.run { strategy = "dap" }
      end,
      desc = "Tests debug nearest",
    },
    {
      "<leader>Ns",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Tests toggle summary",
    },
    {
      "<leader>No",
      function()
        require("neotest").output.open { enter = true, auto_close = true }
      end,
      desc = "Tests show nearest output",
    },
    {
      "<leader>Np",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Tests toggle output panel",
    },
    {
      "<leader>Nw",
      function()
        require("neotest").watch.toggle(vim.fn.expand "%")
      end,
      desc = "Tests watch current file",
    },
    {
      "<leader>Nx",
      function()
        require("neotest").run.stop()
      end,
      desc = "Tests stop nearest",
    },
  },
  config = function()
    require("neotest").setup {
      adapters = {
        require "rustaceanvim.neotest",
      },
      output = {
        open_on_run = false,
      },
    }
  end,
}
