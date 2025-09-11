-- ================================================================================================
-- TITLE : NeoVim options
-- ABOUT : basic settings native to neovim
-- ================================================================================================
require "nvchad.options"

-- add yours here!

-- o.cursorlineopt ='both' -- to enable cursorline!
local o = vim.o
local opt = vim.opt

--Enable the abuslute row numbers
o.number = true -- Line numbers
o.relativenumber = true -- Relative line numbers

--add fold column
o.foldcolumn = "1" -- Show fold column


-- Tabbing / Indentation
o.tabstop = 4 -- Tab width
o.shiftwidth = 4 -- Indent width
o.softtabstop = 4 -- Soft tab stop
o.expandtab = true -- Use spaces instead of tabs
o.smartindent = true -- Smart auto-indenting
o.autoindent = true -- Copy indent from current line
o.grepprg = "rg --vimgrep" -- Use ripgrep if available
o.grepformat = "%f:%l:%c:%m" -- filename, line number, column, content



-- Basic Settings
o.cursorline = true -- Highlight current line
o.scrolloff = 10 -- Keep 10 lines above/below cursor
o.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
o.wrap = false -- Don't wrap lines
o.cmdheight = 1 -- Command line height


-- Search Settings
o.ignorecase = true -- Case-insensitive search
o.smartcase = true -- Case-sensitive if uppercase in search
o.incsearch = true -- Show matches as you type
o.inccommand = "split"

-- gets rid of line with white spaces
vim.g.editorconfig = true

-- Visual Settings
o.termguicolors = true -- Enable 24-bit colors
o.signcolumn = "yes" -- Always show sign column
o.colorcolumn = "100" -- Show column at 100 characters
o.showmatch = true -- Highlight matching brackets
o.matchtime = 2 -- How long to show matching bracket
o.completeopt = "menuone,noinsert,noselect" -- Completion options
o.showmode = false -- Don't show mode in command line
o.pumheight = 10 -- Popup menu height
o.pumblend = 10 -- Popup menu transparency
o.winblend = 0 -- Floating window transparency
o.conceallevel = 0 -- Don't hide markup
o.concealcursor = "" -- Show markup even on cursor line
o.lazyredraw = false -- redraw while executing macros (butter UX)
o.redrawtime = 10000 -- Timeout for syntax highlighting redraw
o.maxmempattern = 20000 -- Max memory for pattern matching
o.synmaxcol = 300 -- Syntax highlighting column limit

-- File Handling
o.backup = false -- Don't create backup files
o.writebackup = false -- Don't backup before overwriting
o.swapfile = false -- Don't create swap files
o.undofile = true -- Persistent undo
o.updatetime = 300 -- Time in ms to trigger CursorHold
o.timeoutlen = 500 -- Time in ms to wait for mapped sequence
o.ttimeoutlen = 0 -- No wait for key code sequences
o.autoread = true -- Auto-reload file if changed outside
o.autowrite = false -- Don't auto-save on some events
opt.diffopt:append("vertical") -- Vertical diff splits
opt.diffopt:append("algorithm:patience") -- Better diff algorithm
opt.diffopt:append("linematch:60") -- Better diff highlighting (smart line matching)

-- Set undo directory and ensure it exists
local undodir = "~/.local/share/nvim/undodir" -- Undo directory path
o.undodir = vim.fn.expand(undodir) -- Expand to full path
local undodir_path = vim.fn.expand(undodir)
if vim.fn.isdirectory(undodir_path) == 0 then
	vim.fn.mkdir(undodir_path, "p") -- Create if not exists
end

-- Behavior Settings
o.errorbells = false -- Disable error sounds
o.backspace = "indent,eol,start" -- Make backspace behave naturally
o.autochdir = false -- Don't change directory automatically
opt.iskeyword:append("-") -- Treat dash as part of a word
opt.path:append("**") -- Search into subfolders with `gf`
o.selection = "inclusive" -- Use inclusive selection
o.mouse = "a" -- Enable mouse support
opt.clipboard:append("unnamedplus") -- Use system clipboard
o.modifiable = true -- Allow editing buffers
o.encoding = "UTF-8" -- Use UTF-8 encoding
o.wildmenu = true -- Enable command-line completion menu
o.wildmode = "longest:full,full" -- Completion mode for command-line
o.wildignorecase = true -- Case-insensitive tab completion in commands

-- Cursor Settings
opt.guicursor = {
	"n-v-c:block", -- Normal, Visual, Command-line
	"i-ci-ve:ver25", -- Insert, Command-line Insert, Visual-exclusive
	"r-cr:hor20", -- Replace, Command-line Replace
	"o:hor50", -- Operator-pending
	"a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor", -- All modes: blinking & highlight groups
	"sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch mode
}

-- Folding Settings
o.foldmethod = "expr" -- Use expression for folding
o.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding
o.foldlevel = 99 -- Keep all folds open by default

-- Split Behavior
o.splitbelow = true -- Horizontal splits open below
o.splitright = true -- Vertical splits open to the right