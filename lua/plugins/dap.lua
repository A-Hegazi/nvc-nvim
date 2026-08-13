return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
          local dap = require "dap"
          local dapui = require "dapui"

          dapui.setup()

          dap.listeners.before.attach.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.launch.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
          end
          dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
          end
        end,
      },
    },
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debugger start / continue",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Debugger step over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Debugger step into",
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "Debugger step out",
      },
      {
        "<leader>Dc",
        function()
          require("dap").continue()
        end,
        desc = "Debugger continue",
      },
      {
        "<leader>Db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debugger toggle breakpoint",
      },
      {
        "<leader>DB",
        function()
          require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
        end,
        desc = "Debugger conditional breakpoint",
      },
      {
        "<leader>Du",
        function()
          require("dapui").toggle()
        end,
        desc = "Debugger toggle UI",
      },
      {
        "<leader>Dr",
        function()
          require("dap").repl.open()
        end,
        desc = "Debugger open REPL",
      },
      {
        "<leader>Dx",
        function()
          require("dap").terminate()
        end,
        desc = "Debugger terminate",
      },
    },
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      ensure_installed = { "codelldb" },
      automatic_installation = true,
      handlers = {},
    },
  },
}
