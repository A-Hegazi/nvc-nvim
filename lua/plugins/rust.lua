local function rust_root(bufnr)
  local file = vim.api.nvim_buf_get_name(bufnr)
  return vim.fs.root(file, { "Cargo.toml" }) or vim.fn.getcwd()
end

local function run_clippy(bufnr)
  vim.cmd "botright 15new"

  local job = vim.fn.jobstart({ "cargo", "clippy", "--all-targets" }, {
    cwd = rust_root(bufnr),
    term = true,
  })

  if job <= 0 then
    vim.notify("Unable to start cargo clippy", vim.log.levels.ERROR)
    return
  end

  vim.cmd "startinsert"
end

local function peek_inlay_hints(bufnr)
  if not vim.lsp.inlay_hint then
    return
  end

  local group = vim.api.nvim_create_augroup("RustPeekInlayHints", { clear = false })
  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  vim.api.nvim_clear_autocmds { group = group, buffer = bufnr }

  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertEnter", "BufLeave", "WinLeave" }, {
    group = group,
    buffer = bufnr,
    once = true,
    callback = function()
      if vim.api.nvim_buf_is_valid(bufnr) and vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
      end
    end,
  })
end

local function map_rust(bufnr, lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, {
    buffer = bufnr,
    silent = true,
    desc = "Rust " .. desc,
  })
end

local function map_crates(bufnr, mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, {
    buffer = bufnr,
    silent = true,
    desc = "Crates " .. desc,
  })
end

return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    ft = { "rust" },
    dependencies = { "mfussenegger/nvim-dap" },
    init = function()
      vim.g.rustaceanvim = {
        tools = {
          test_executor = "background",
        },
        server = {
          on_attach = function(_, bufnr)
            if vim.lsp.inlay_hint then
              vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
            end

            map_rust(bufnr, "<leader>Ra", function()
              vim.cmd.RustLsp "codeAction"
            end, "code action")
            map_rust(bufnr, "<leader>Rh", function()
              vim.cmd.RustLsp { "hover", "actions" }
            end, "hover actions")
            map_rust(bufnr, "<leader>Rr", function()
              vim.cmd.RustLsp "runnables"
            end, "runnables")
            map_rust(bufnr, "<leader>Rt", function()
              vim.cmd.RustLsp "testables"
            end, "testables")
            map_rust(bufnr, "<leader>Re", function()
              vim.cmd.RustLsp "expandMacro"
            end, "expand macro")
            map_rust(bufnr, "<leader>Rp", function()
              vim.cmd.RustLsp "parentModule"
            end, "parent module")
            map_rust(bufnr, "<leader>Rf", function()
              vim.cmd.RustLsp { "flyCheck", "run" }
            end, "run check")
            map_rust(bufnr, "<leader>Rc", function()
              run_clippy(bufnr)
            end, "cargo clippy")
            map_rust(bufnr, "<leader>Rd", function()
              vim.cmd.RustLsp "debuggables"
            end, "debuggables")
            map_rust(bufnr, "<leader>Ri", function()
              if not vim.lsp.inlay_hint then
                return
              end

              local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
              vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
            end, "toggle inlay hints")
            map_rust(bufnr, "<leader>RI", function()
              peek_inlay_hints(bufnr)
            end, "peek inlay hints")
            map_rust(bufnr, "<leader>Ro", function()
              require("rustowl").toggle(bufnr)
            end, "toggle RustOwl ownership hints")
          end,

          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                features = {},
              },
              checkOnSave = true,
              check = {
                command = "check",
              },
              procMacro = {
                enable = true,
              },
              inlayHints = {
                bindingModeHints = { enable = true },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true, minLines = 1 },
                closureReturnTypeHints = { enable = "with_block" },
                lifetimeElisionHints = {
                  enable = "skip_trivial",
                  useParameterNames = true,
                },
                parameterHints = { enable = true },
                typeHints = { enable = true },
              },
            },
          },
        },
      }
    end,
  },

  {
    "saecki/crates.nvim",
    ft = { "toml" },
    opts = {
      on_attach = function(bufnr)
        local crates = require "crates"

        map_crates(bufnr, "n", "<leader>Ct", crates.toggle, "toggle virtual text")
        map_crates(bufnr, "n", "<leader>Cr", crates.reload, "reload data")
        map_crates(bufnr, "n", "<leader>Cv", crates.show_versions_popup, "show versions")
        map_crates(bufnr, "n", "<leader>Cf", crates.show_features_popup, "show features")
        map_crates(bufnr, "n", "<leader>Cd", crates.show_dependencies_popup, "show dependencies")
        map_crates(bufnr, "n", "<leader>Cu", crates.update_crate, "update crate")
        map_crates(bufnr, "v", "<leader>Cu", crates.update_crates, "update selected crates")
        map_crates(bufnr, "n", "<leader>Ca", crates.update_all_crates, "update all crates")
        map_crates(bufnr, "n", "<leader>CU", crates.upgrade_crate, "upgrade crate")
        map_crates(bufnr, "v", "<leader>CU", crates.upgrade_crates, "upgrade selected crates")
        map_crates(bufnr, "n", "<leader>CA", crates.upgrade_all_crates, "upgrade all crates")
        map_crates(bufnr, "n", "<leader>CH", crates.open_homepage, "open homepage")
        map_crates(bufnr, "n", "<leader>CR", crates.open_repository, "open repository")
        map_crates(bufnr, "n", "<leader>CD", crates.open_documentation, "open documentation")
        map_crates(bufnr, "n", "<leader>CC", crates.open_crates_io, "open crates.io")
      end,
    },
  },

  {
    "cordx56/rustowl",
    version = "^0.4",
    build = "cargo install rustowl",
    lazy = false,
    opts = {
      auto_attach = true,
      auto_enable = false,
      idle_time = 500,
    },
  },
}
