return {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    rust = { "rustfmt" },
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback",
  },
}
