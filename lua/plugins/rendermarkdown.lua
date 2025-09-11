return{
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { "markdown", "rmd", "org", "norg" },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
          bullet = { enabled = true },
    checkbox = {
      enabled = true,
      -- DO NOT set `position` (removed in v8+). Just custom icons:
      unchecked = { icon = "   󰄱 ", highlight = "RenderMarkdownUnchecked" },
      checked   = { icon = "   󰱒 ", highlight = "RenderMarkdownChecked" },
    },
    },
}