-- ~/.config/nvim/lua/custom/themes/monokai_pro.lua

local M = {}

--------------------------------------------------------------------------------
-- The Main Palette (M.base_30)
--------------------------------------------------------------------------------
M.base_30 = {
  -- Core Backgrounds & Foregrounds
  white = "#fcfcfa",          ---@ Sourced from editor.foreground
  darker_black = "#38353a",      ---@ Sourced from activityBar.background
  black = "#2d2a2e",          ---@ Sourced from editor.background
  black2 = "#49444b",          ---@ Sourced from sideBar.background
  one_bg = "#403e41",          ---@ Sourced from panel.background (for floats)
  one_bg2 = "#4a484b",          ---@ A slightly lighter version of one_bg
  one_bg3 = "#545255",          ---@ An even lighter version of one_bg
  
  -- Greys
  grey = "#5b595c",          ---@ Sourced from editorLineNumber.foreground
  grey_fg = "#727072",          ---@ Sourced from comment color
  grey_fg2 = "#939293",          ---@ Sourced from sideBar.foreground
  light_grey = "#c1c0c0",          ---@ Sourced from activityBar.foreground

  -- Reds & Pinks
  red = "#ff6188",           ---@ Main red
  baby_pink = "#ff6188",       ---@ Using main red
  pink = "#ff6188",           ---@ Using main red

  -- UI Elements
  line = "#403e41",          ---@ A border color
  statusline_bg = "#3f3a41",      ---@ Sourced from statusBar.background
  lightbg = "#403e41",          ---@ Same as one_bg, for popups
  pmenu_bg = "#5b595c",          ---@ Sourced from editorSuggestWidget.selectedBackground
  folder_bg = "#78dce8",          ---@ Using cyan for folder icons

  -- Accent Colors
  green = "#a9dc76",           ---@ Main green
  vibrant_green = "#a9dc76",       ---@ Using main green
  nord_blue = "#78dce8",       ---@ Using main cyan as a substitute
  blue = "#ab9df2",           ---@ Main purple/blue
  yellow = "#ffd866",         ---@ Main yellow
  sun = "#ffd866",           ---@ Using main yellow
  purple = "#ab9df2",         ---@ Main purple
  dark_purple = "#ab9df2",       ---@ Using main purple
  teal = "#78dce8",           ---@ Using main cyan
  orange = "#fc9867",         ---@ Main orange
  cyan = "#78dce8",           ---@ Main cyan
}

--------------------------------------------------------------------------------
-- Base16 Palette (for broader plugin compatibility)
--------------------------------------------------------------------------------
M.base_16 = {
  base00 = M.base_30.black,         -- bg
  base01 = M.base_30.black2,        -- bg_alt
  base02 = M.base_30.grey_fg,       -- comment
  base03 = M.base_30.grey_fg2,      -- fg_dark
  base04 = M.base_30.light_grey,    -- selection
  base05 = M.base_30.white,         -- fg
  base06 = "#ffffff",               -- fg_light
  base07 = "#ffffff",               -- fg_brightest
  base08 = M.base_30.red,           -- red
  base09 = M.base_30.orange,        -- orange
  base0A = M.base_30.yellow,        -- yellow
  base0B = M.base_30.green,         -- green
  base0C = M.base_30.cyan,          -- cyan
  base0D = M.base_30.blue,          -- blue
  base0E = M.base_30.purple,        -- magenta
  base0F = M.base_30.orange,        -- another accent
}

--------------------------------------------------------------------------------
-- UI and Plugin Polishing (Tree-sitter only)
--------------------------------------------------------------------------------
M.polish_hl = {
    defaults = {},
  treesitter = {
    ["@string"] = { fg = M.base_30.yellow },
    ["@string.escape"] = { fg = M.base_30.red },
    ["@character"] = { fg = M.base_30.yellow },
    ["@number"] = { fg = M.base_30.blue },
    ["@float"] = { fg = M.base_30.blue },
    ["@boolean"] = { fg = M.base_30.blue },
    ["@function"] = { fg = M.base_30.green },
    ["@function.call"] = { fg = M.base_30.green },
    ["@function.builtin"] = { fg = M.base_30.green, italic = true },
    ["@method"] = { fg = M.base_30.green },
    ["@method.call"] = { fg = M.base_30.green },
    ["@variable.parameter"] = { fg = M.base_30.orange, italic = true },
    ["@variable"] = { fg = M.base_30.white },
    ["@field"] = { fg = M.base_30.white },
    ["@property"] = { fg = M.base_30.white },
    ["@keyword"] = { fg = M.base_30.red },
    ["@keyword.function"] = { fg = M.base_30.red },
    ["@keyword.operator"] = { fg = M.base_30.red },
    ["@keyword.return"] = { fg = M.base_30.red },
    ["@keyword.conditional"] = { fg = M.base_30.red },
    ["@exception"] = { fg = M.base_30.red },
    ["@include"] = { fg = M.base_30.red },
    ["@conditional"] = { fg = M.base_30.red },
    ["@repeat"] = { fg = M.base_30.red },
    ["@operator"] = { fg = M.base_30.red },
    ["@type"] = { fg = M.base_30.cyan, italic = true },
    ["@type.builtin"] = { fg = M.base_30.cyan, italic = true },
    ["@namespace"] = { fg = M.base_30.cyan },
    ["@constructor"] = { fg = M.base_30.green },
    ["@constant"] = { fg = M.base_30.blue },
    ["@constant.builtin"] = { fg = M.base_30.blue },
    ["@constant.macro"] = { fg = M.base_30.blue },
    ["@punctuation.delimiter"] = { fg = M.base_30.grey_fg2 },
    ["@punctuation.bracket"] = { fg = M.base_30.grey_fg2 },
  },
}

--------------------------------------------------------------------------------
-- Final Setup
--------------------------------------------------------------------------------

M.type = "dark"

-- The "monokai_pro" name should be unique to your theme.
M = require("base46").override_theme(M, "monokai_pro")

return M