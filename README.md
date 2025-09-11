# 🌟 NvChad 2.5 – Neovim Config

A Neovim setup built on top of **NvChad 2.5** .

> **Quick summary:**  
> 1) Backup/remove any old Neovim config  
> 2) Install **NvChad 2.5**  
> 3) **Overlay this repo** on top of NvChad  
> 4) Start Neovim and let Lazy.nvim sync

---

## 📑 Table of Contents
- [1. Prerequisites](#-1-prerequisites)
- [2. Backup & Remove Old Neovim Config](#-2-backup--remove-old-neovim-config)
- [3. Install NvChad 2.5](#-3-install-nvchad-25)
- [4. Apply This Config (Overlay/Replace)](#%EF%B8%8F-4-apply-this-config-overlayreplace)
- [5. First Launch & Plugin Sync](#-5-first-launch--plugin-sync)
- [6. Adding LSPs, Linters, and Formatters](#%EF%B8%8F-6-adding-lsps-linters-and-formatters)
- [7. Repo Layout](#-7-repo-layout)
- [8. Optional: GitHub Copilot](#-8-optional-github-copilot)
- [9. Troubleshooting](#-9-troubleshooting)
- [10. Uninstall / Revert](#-10-uninstall--revert)
- [11. Plugins Used](#-11-plugins-used)
- [12. Keymaps](#%EF%B8%8F-12-keymaps)

---
## 🧩 1. Prerequisites

- **Neovim** ≥ 0.9 (0.10+ recommended)
- **Git**
- (For Copilot) **Node.js ≥ 18**
- A **Nerd Font** set in your terminal (e.g., “FiraCode Nerd Font”)

### ✅ Check versions (Linux/WSL)
```bash
nvim --version
git --version
node --version   # only required for GitHub Copilot
```
[🔼 Back to top](#-table-of-contents)

---

## 🧹 2. Backup & Remove Old Neovim Config

> ⚠️ Do this **before installing NvChad** to avoid conflicts.

### 🐧 Linux / WSL
```bash
# Backup (recommended)
mv ~/.config/nvim ~/.config/nvim-old 2>/dev/null || true

# OR remove old config (if you don’t need a backup)
rm -rf ~/.config/nvim

# Remove local Neovim state/cache
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
```

### 🪟 Windows (PowerShell)
```powershell
# Backup (recommended)
if (Test-Path $env:LOCALAPPDATA\nvim) {
  Rename-Item $env:LOCALAPPDATA\nvim "$($env:LOCALAPPDATA)\nvim-old" -ErrorAction SilentlyContinue
}

# OR remove old config
Remove-Item $env:LOCALAPPDATA\nvim -Recurse -Force -ErrorAction SilentlyContinue

# Remove local state/cache
Remove-Item "$env:LOCALAPPDATA\nvim-data\state\nvim" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\nvim-data\share\nvim" -Recurse -Force -ErrorAction SilentlyContinue
```
[🔼 Back to top](#-table-of-contents)

---

## ⚡ 3. Install NvChad 2.5

Follow the official quickstart: [NvChad Docs → Quickstart](https://nvchad.com/docs/quickstart/install/)

### 🐧 Linux / WSL
```bash
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
nvim
```

### 🪟 Windows (PowerShell)
```powershell
git clone https://github.com/NvChad/NvChad $env:LOCALAPPDATA\nvim --depth 1
nvim
```
[🔼 Back to top](#-table-of-contents)

---

## ⚙️ 4. Apply This Config (Overlay/Replace)

> This repo is a **user layer** on top of NvChad.  
> First install NvChad (step 3) then apply this config.

### ✅ Option A — Overlay (recommended; keeps NvChad core intact)

#### 🐧 Linux / WSL
```bash
git clone https://github.com/A-Hegazi/nvc-nvim.git ~/.config/nvim-config
rsync -av --progress ~/.config/nvim-config/ ~/.config/nvim/
```

#### 🪟 Windows (PowerShell)
```powershell
git clone https://github.com/A-Hegazi/nvc-nvim "$env:LOCALAPPDATA\nvim-config"
robocopy "$env:LOCALAPPDATA\nvim-config" "$env:LOCALAPPDATA\nvim" /E
```

### ⚠️ Option B — Replace

#### 🐧 Linux / WSL
```bash
rm -rf ~/.config/nvim
git clone https://github.com/A-Hegazi/nvc-nvim.git ~/.config/nvim
nvim
```

#### 🪟 Windows (PowerShell)
```powershell
Remove-Item $env:LOCALAPPDATA\nvim -Recurse -Force -ErrorAction SilentlyContinue
git clone https://github.com/A-Hegazi/nvc-nvim $env:LOCALAPPDATA\nvim
nvim
```
[🔼 Back to top](#-table-of-contents)

---

## 🚀 5. First Launch & Plugin Sync

```bash
nvim
```

- **Lazy.nvim** will automatically install and sync plugins.
- Install LSP/Linters/formatters with:
```vim
:MasonInstallAll
```
[🔼 Back to top](#-table-of-contents)

---

## ⚙️ 6. Adding LSPs, Linters, and Formatters

This config already comes with basic setup for **LSP**, **linters**, and **formatters**.  
You can easily add more by editing the config files inside `lua/configs/`.

---

### 🧠 1. Add LSP Servers

Open:  
`lua/configs/lspconfig.lua`

```lua
-- Add your LSP server names here
local servers = { "html", "cssls", "basedpyright" }
vim.lsp.enable(servers)
```

📚 **Available LSP servers:**  
🔗 [nvim-lspconfig — list of servers](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md)

---

### 🧪 2. Add Linters

Open:  
`lua/configs/lint.lua`

```lua
lint.linters_by_ft = {
  python = { "ruff" },  -- Add more linters here
}
```

📚 **Available linters:**  
🔗 [nvim-lint — available linters](https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters)

---

### 🖊️ 3. Add Formatters

Open:  
`lua/configs/conform.lua`

```lua
formatters_by_ft = {
  lua = { "stylua" },
  python = { "black" },
  -- css = { "prettier" },
  -- html = { "prettier" },
}
```

📚 **Available formatters:**  
🔗 [conform.nvim — formatters](https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters)

---

💡 **Tip:**  
After adding any new LSP/linters/formatters, run:

```vim
:MasonInstallAll
```
[🔼 Back to top](#-table-of-contents)

---

## 📁 7. Repo Layout

```
.
├── LICENSE
├── README.md
├── init.lua
├── lazy-lock.json
└── lua
    ├── autocmds.lua
    ├── chadrc.lua
    ├── configs/
    ├── current-theme.lua
    ├── mappings.lua
    ├── options.lua
    ├── plugins/
    └── themes/
```
[🔼 Back to top](#-table-of-contents)

---

## 🤖 8. Optional: GitHub Copilot

- Requires **GitHub Copilot subscription** and **Node.js ≥ 18**
- In Neovim:
  - `\<leader> a l` → login/setup  
  - `\<leader> a s` → status  

**Insert-mode keys:**
- `Ctrl+L` → accept  
- `Alt+]` / `Alt+[` → next / previous  
- `Ctrl+\\` → dismiss  
[🔼 Back to top](#-table-of-contents)

---

## 🧪 9. Troubleshooting

**Blank icons** → Use a Nerd Font  
**Copilot not working** → `\<leader> a l` to sign in  
**Alt keys broken** → Remap in `lua/plugins/copilot.lua`  
**Reset everything**:
```bash
mv ~/.config/nvim ~/.config/nvim.reset-$(date +%F)
rm -rf ~/.local/state/nvim ~/.local/share/nvim
```
[🔼 Back to top](#-table-of-contents)

---

## 🗑 10. Uninstall / Revert

### 🐧 Linux / WSL
```bash
mv ~/.config/nvim ~/.config/nvim.removed-$(date +%F)
mv ~/.config/nvim-old ~/.config/nvim 2>/dev/null || true
```

### 🪟 Windows (PowerShell)
```powershell
Rename-Item $env:LOCALAPPDATA\nvim "$($env:LOCALAPPDATA)\nvim.removed-$(Get-Date -f yyyy-MM-dd)"
if (Test-Path "$env:LOCALAPPDATA\nvim-old") {
  Rename-Item "$env:LOCALAPPDATA\nvim-old" "$env:LOCALAPPDATA\nvim"
}
```
[🔼 Back to top](#-table-of-contents)

---
## 📦 11. Plugins Used

<details>
<summary>📋 Click to expand the full plugin list</summary>

<br>

| Plugin Name            | Link                                              | Notes                                               | Status     |
|--------------------------|---------------------------------------------------|-------------------------------------------------------|--------------|
| Snacks                   | [folke/snacks.nvim](https://github.com/folke/snacks.nvim)                         | needed `fd-find`                                     | Installed   |
| TODO Comment             | [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)           | Needed Treesitter                                    | Installed   |
| Mini                     | [nvim-mini/mini.nvim](https://github.com/nvim-mini/mini.nvim)                     | surround / trailspace / cursorword / splitjoin        | Installed   |
| Telescope                 | [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) |                                                       | Installed   |
| Undo tree                 | [mbbill/undotree](https://github.com/mbbill/undotree)                             |                                                       | Installed   |
| Harpoon                    | [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon)                   |                                                       | Installed   |
| Treesitter                 | [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) |                                                 | Installed   |
| Vim Maximizer               | [szw/vim-maximizer](https://github.com/szw/vim-maximizer)                       |                                                       | Installed   |
| Fugitive                      | [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)                     |                                                       | Installed   |
| Gitsigns                         | [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)         |                                                       | Installed   |
| Git Worktree                         | [ThePrimeagen/git-worktree.nvim](https://github.com/ThePrimeagen/git-worktree.nvim) |                                           | Installed   |
| nvim-cmp (disabled)                         | [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                         | Comes with NvChad but replaced with blink               | Disabled    |
| Noice                         | [folke/noice.nvim](https://github.com/folke/noice.nvim)                         |                                                       | Installed   |
| Conform                         | [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)                         |                                                   | Installed   |
| Linting                         | [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint)                         |                                                   | Installed   |
| Trouble                         | [folke/trouble.nvim](https://github.com/folke/trouble.nvim)                         |                                                   | Installed   |
| Render Markdown                         | [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) |                                     | Installed   |
| indent-blankline.nvim (disabled)                         | [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)                         | Comes with NvChad but replaced with Snacks               | Disabled    |
| nvim-tree.lua (disabled)                         | [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)                         | Comes with NvChad but replaced with others               | Disabled    |
| Which-key                         | [folke/which-key.nvim](https://github.com/folke/which-key.nvim)                         |                                                   | Installed   |
| Neo-tree                         | [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)                         |                                                   | Installed   |
| Oil                         | [stevearc/oil.nvim](https://github.com/stevearc/oil.nvim)                         |                                                   | Installed   |
| nvim-ufo                         | [kevinhwang91/nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)                         |                                                   | Installed   |
| Neotab                         | [kawre/neotab.nvim](https://github.com/kawre/neotab.nvim)                         |                                                   | Installed   |
| Code Runner                         | [CRAG666/code_runner.nvim](https://github.com/CRAG666/code_runner.nvim)                         |                                                   | Installed   |
| Copilot                         | [github/copilot.vim](https://github.com/github/copilot.vim)                         |                                                   | Installed   |
| CopilotChat                         | [CopilotC-Nvim/CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim)                         |                                                   | Installed   |

</details>
[🔼 Back to top](#-table-of-contents)

---

## ⌨️ 12. Keymaps

<details>
<summary>🖥️ Click to expand the full keymap list</summary>

<br>

| Plugin / Section | Description | Mode | Key |
|---|---|---|---|
| Added by NvChad | move beginning of line | Insert | `<C-b>` |
| Added by NvChad | move end of line | Insert | `<C-e>` |
| Added by NvChad | move left | Insert | `<C-h>` |
| Added by NvChad | move right | Insert | `<C-l>` |
| Added by NvChad | move down | Insert | `<C-j>` |
| Added by NvChad | move up | Insert | `<C-k>` |
| Added by NvChad | switch window left | Normal | `<C-h>` |
| Added by NvChad | switch window right | Normal | `<C-l>` |
| Added by NvChad | switch window down | Normal | `<C-j>` |
| Added by NvChad | switch window up | Normal | `<C-k>` |
| Added by NvChad | general clear highlights | Normal | `<Esc>` |
| Added by NvChad | general save file | Normal | `<C-s>` |
| Added by NvChad | general copy whole file | Normal | `<C-c>` |
| Added by NvChad | toggle line number | Normal | `<Leader> n` |
| Added by NvChad | toggle relative number | Normal | `<Leader> .` |
| Added by NvChad | buffer new | Normal | `<Leader> b` |
| Added by NvChad | terminal escape terminal mode | Terminal | `<C-x>` |
| Added by NvChad | Next search result (centered) | Normal | `n` |
| Added by NvChad | Previous search result (centered) | Normal | `N` |
| Added by NvChad | Half page down (centered) | Normal | `<C-d>` |
| Added by NvChad | Half page up (centered) | Normal | `<C-u>` |
| Added by me | Increase window height | Normal | `<C-Up>` |
| Added by me | Decrease window height | Normal | `<C-Down>` |
| Added by me | Decrease window width | Normal | `<C-Left>` |
| Added by me | Increase window width | Normal | `<C-Right>` |
| Added by me | Join lines and keep cursor position | Normal | `J` |
| Added by me | Edit config | Normal | `<Leader> r c` |
| Added by me | Focus on File Explorer | Normal | `<Leader> m` |
| Added by me | Move lines down in visual selection | Visual | `<A-j>` |
| Added by me | Move lines up in visual selection | Visual | `<A-k>` |
| Added by me | Indent left and reselect | Visual | `<` |
| Added by me | Indent right and reselect | Visual | `>` |
| Added by me | Paste over selection without overwriting clipboard | Visual | `<Leader> p` |
| Added by me | Paste over selection and after cursor without overwriting clipboard | Visual | `<Leader> P` |
| Added by me | Delete without yanking | Normal-Visual | `<Leader> d` |
| Added by me | Replace word under cursor globally | Normal | `<Leader> W` |
| Added by me | open new tab | Normal | `<Leader> t o` |
| Added by me | close current tab | Normal | `<Leader> t x` |
| Added by me | go to next tab | Normal | `<Leader> t n` |
| Added by me | go to pre tab | Normal | `<Leader> t p` |
| Added by me | Open current file in new tab | Normal | `<Leader> t f` |
| Added by me | Make splits equal size | Normal | `<Leader> s e` |
| Added by me | Copy file path to clipboard | Normal | `<Leader> i` |
| Code Runner | Run code (auto-detect file/project) | Normal | `<Leader> r r` |
| Code Runner | Run current file | Normal | `<Leader> r f` |
| Code Runner | Run current project | Normal | `<Leader> r p` |
| Code Runner | Run file in new tab | Normal | `<Leader> r t` |
| Code Runner | Run file in floating window | Normal | `<Leader> r l` |
| Code Runner | Run file in horizontal split | Normal | `<Leader> r s` |
| Code Runner | Run file in vertical split | Normal | `<Leader> r v` |
| Code Runner | Close runner | Normal | `<Leader> r c` |
| Code Runner | Show filetype command | Normal | `<Leader> r F` |
| Code Runner | Show project command | Normal | `<Leader> r P` |
| Code Runner | Run custom command | Normal | `<Leader> r R` |
| Comment.nvim | toggle comment | Normal | `<Leader> /` |
| Comment.nvim | toggle comment | Visual | `<Leader> /` |
| Conform.nvim | general format file | Normal-Visual | `<Leader> z` |
| Copilot.vim | Copilot: Panel / Toggle | Normal | `<Leader> a a` |
| Copilot.vim | Copilot: Login / Setup | Normal | `<Leader> a l` |
| Copilot.vim | Copilot: Status | Normal | `<Leader> a s` |
| Copilot.vim | Copilot: Stop suggestions | Normal | `<Leader> a S` |
| Copilot.vim | Copilot: Enable | Normal | `<Leader> a e` |
| Copilot.vim | Copilot: Disable | Normal | `<Leader> a d` |
| Copilot.vim | Copilot: Accept suggestion | Insert | `<C-l>` |
| Copilot.vim | Copilot: Next suggestion | Insert | `<A-]>` |
| Copilot.vim | Copilot: Previous suggestion | Insert | `<A-[>` |
| Copilot.vim | Copilot: Dismiss suggestion | Insert | `<C-\\>` |
| Copilot.vim | (Optional) Copilot: Accept word | Insert | `<A-w>` |
| Copilot.vim | (Optional) Copilot: Accept line | Insert | `<A-e>` |
| CopilotChat.nvim | AI Chat: Toggle panel | Normal | `<Leader> a c` |
| CopilotChat.nvim | AI Chat: Quick ask | Normal-Visual | `<Leader> a q` |
| CopilotChat.nvim | Explain code | Normal-Visual | `<Leader> a x` |
| CopilotChat.nvim | Review code | Normal-Visual | `<Leader> a r` |
| CopilotChat.nvim | Fix issues | Normal-Visual | `<Leader> a f` |
| CopilotChat.nvim | Optimize code | Normal-Visual | `<Leader> a o` |
| CopilotChat.nvim | Generate tests | Normal-Visual | `<Leader> a t` |
| CopilotChat.nvim | Generate commit message (staged) | Normal | `<Leader> a g` |
| CopilotChat.nvim | Reset chat session | Normal | `<Leader> a R` |
| CopilotChat.nvim | Stop current response | Normal | `<Leader> a z` |
| CopilotChat.nvim | Choose Copilot model | Normal | `<Leader> a m` |
| Fugitive | Fugitive: Git status | Normal | `<Leader> g f g` |
| Fugitive | Fugitive: Blame | Normal | `<Leader> g f b` |
| Fugitive | Fugitive: Log (graph) | Normal | `<Leader> g f l` |
| Fugitive | Fugitive: Diff | Normal | `<Leader> g f d` |
| Fugitive | Fugitive: Vsplit Diff | Normal | `<Leader> g f s` |
| Fugitive | Fugitive: Add current file | Normal | `<Leader> g f a` |
| Fugitive | Fugitive: Commit | Normal | `<Leader> g f c` |
| Fugitive | Fugitive: Push | Normal | `<Leader> g f p` |
| Fugitive | Fugitive: Pull (rebase) | Normal | `<Leader> g f P` |
| Fugitive | Fugitive: Checkout current file (cond=false) | Normal | `<Leader> g f o` |
| Fugitive | Fugitive: Branch list (cond=false) | Normal | `<Leader> g f B` |
| Gitsigns | Gitsigns: Stage hunk | Normal-Visual | `<Leader> g s s` |
| Gitsigns | Gitsigns: Undo stage hunk | Normal | `<Leader> g s u` |
| Gitsigns | Gitsigns: Reset hunk | Normal-Visual | `<Leader> g s r` |
| Gitsigns | Gitsigns: Reset buffer | Normal | `<Leader> g s R` |
| Gitsigns | Gitsigns: Preview hunk | Normal | `<Leader> g s p` |
| Gitsigns | Gitsigns: Blame line | Normal | `<Leader> g s b` |
| Gitsigns | Gitsigns: Diff this | Normal | `<Leader> g s d` |
| Gitsigns | Gitsigns: Diff against ~ | Normal | `<Leader> g s D` |
| Gitsigns | Gitsigns: Next hunk | Normal | `<Leader> g s n` |
| Gitsigns | Gitsigns: Previous hunk | Normal | `<Leader> g s P` |
| Harpoon | add the current file to harpoon | Normal | `<Leader> o a` |
| Harpoon | toggle harpoon list | Normal | `<Leader> o t` |
| Harpoon | first file quick jump | Normal | `<Leader> o 1` |
| Harpoon | second file quick jump | Normal | `<Leader> o 2` |
| Harpoon | third file quick jump | Normal | `<Leader> o 3` |
| Harpoon | fourth file quick jump | Normal | `<Leader> o 4` |
| Harpoon | toggle previous buffer | Normal | `<Leader> o p` |
| Harpoon | toggle next buffer within harpoon | Normal | `<Leader> o n` |
| LSP Config | Toggle LSP diagnostics next to each line | Normal | `<Leader> l d` |
| LSP Config | Hover | Normal | `K` |
| LSP Config | Add workspace folder | Normal | `<Leader> l a` |
| LSP Config | Remove workspace folder | Normal | `<Leader> l o` |
| LSP Config | List workspace folder | Normal | `<Leader> l l` |
| LSP Config | go to type definition | Normal | `<Leader> l t` |
| LSP Config | NvRenamer | Normal | `<Leader> l r` |
| LSP Config | LSP diagnostic loclist | Normal | `<Leader> l s` |
| Mini.Splitjoin | Split arguments | Normal | `<Leader> m s` |
| Mini.Splitjoin | Join arguments | Normal | `<Leader> m j` |
| Mini.Surround | Add surrounding in Normal and Visual modes | Normal-Visual | `sa` |
| Mini.Surround | Delete surrounding | Normal | `sd` |
| Mini.Surround | Find surrounding (to the right) | Normal | `sf` |
| Mini.Surround | Find surrounding (to the left) | Normal | `sF` |
| Mini.Surround | Highlight surrounding | Normal | `sh` |
| Mini.Surround | Replace surrounding | Normal | `sr` |
| Mini.Surround | Update n_lines | Normal | `sn` |
| Mini.Surround | Suffix to search with prev method | Normal | `l` |
| Mini.Surround | Suffix to search with next method | Normal | `n` |
| Mini.Trailspace | Highlight trailing spaces | Normal | `<Leader> m h` |
| Mini.Trailspace | Unhighlight trailing spaces | Normal | `<Leader> m u` |
| Mini.Trailspace | Trim trailing spaces | Normal | `<Leader> m t` |
| Mini.Trailspace | Trim empty lines at EOF | Normal | `<Leader> m r` |
| neo-tree | Neotree toggle focus filesystem reveal left | Normal | `<Leader> e f` |
| neo-tree | Neotree toggle focus git_status reveal left | Normal | `<Leader> e g` |
| neo-tree | Neotree toggle focus buffers reveal left | Normal | `<Leader> e b` |
| neo-tree | Neotree float filesystem reveal=true | Normal | `<Leader> E f` |
| neo-tree | Neotree float git_status reveal=true | Normal | `<Leader> E g` |
| neo-tree | Neotree float buffers reveal=true | Normal | `<Leader> E b` |
| neo-tree | Neotree toggle document_symbols | Normal | `<Leader> e s` |
| NvChad (NvCheatsheet) | toggle nvcheatsheet | Normal | `<Leader> c` |
| NvChad (tabufline) | buffer goto next | Normal | `<Tab>` |
| NvChad (tabufline) | buffer goto prev | Normal | `<S-Tab>` |
| NvChad (tabufline) | buffer close | Normal | `<Leader> x` |
| NvChad (term) | terminal new horizontal term | Normal | `<Leader> h` |
| NvChad (term) | terminal new vertical term | Normal | `<Leader> v` |
| NvChad (term) | terminal toggleable vertical term | Normal-Terminal | `<A-v>` |
| NvChad (term) | terminal toggleable horizontal term | Normal-Terminal | `<A-h>` |
| NvChad (term) | terminal toggle floating term | Normal-Terminal | `<A-i>` |
| NvChad (themes) | telescope nvchad themes | Normal | `<Leader> f t` |
| nvim-tree.lua | nvimtree toggle window | Normal | `<C-n>` |
| nvim-tree.lua | nvimtree focus window | Normal | `<Leader> e` |
| Nvim-ufo | Fold at cursor | Normal | `za` |
| Nvim-ufo | Open All Folds | Normal | `zR` |
| Nvim-ufo | Close all Folds | Normal | `zM` |
| Oil | Open Oil | Normal | `-` |
| Oil | Open Oil Float | Normal | `<Leader> -` |
| Snacks | Lazygit | Normal | `<Leader> g l l` |
| Snacks | Lazygit Logs | Normal | `<Leader> g l g` |
| Snacks | Open Snacks Explorer | Normal | `<Leader> s f` |
| Snacks | Fast Rename Current File | Normal | `<Leader> s r` |
| Snacks | Delete or Close Buffer (Confirm) | Normal | `<Leader> s d B` |
| Snacks | Smart Find Files | Normal | `<Leader> p <space>` |
| Snacks | Notification History | Normal | `<Leader> p n` |
| Snacks | Buffers | Normal | `<Leader> p f b` |
| Snacks | Find Config File | Normal | `<Leader> p f c` |
| Snacks | Find Files | Normal | `<Leader> p f f` |
| Snacks | Find Git Files | Normal | `<Leader> p f g` |
| Snacks | Projects | Normal | `<Leader> p f p` |
| Snacks | Recent | Normal | `<Leader> p f r` |
| Snacks | Git Branches | Normal | `<Leader> p g b` |
| Snacks | Git Log | Normal | `<Leader> p g l` |
| Snacks | Git Log Line | Normal | `<Leader> p g L` |
| Snacks | Git Status | Normal | `<Leader> p g s` |
| Snacks | Git Stash | Normal | `<Leader> p g S` |
| Snacks | Git Diff (Hunks) | Normal | `<Leader> p g d` |
| Snacks | Git Log File | Normal | `<Leader> p g f` |
| Snacks | Grep Open Buffers | Normal | `<Leader> p r b` |
| Snacks | Open Grep | Normal | `<Leader> p r g` |
| Snacks | Visual selection or word | Normal-Visual | `<Leader> p r w` |
| Snacks | Registers | Normal | `<Leader> p s r` |
| Snacks | Search History | Normal | `<Leader> p s i` |
| Snacks | Autocmds | Normal | `<Leader> p s a` |
| Snacks | Buffer Lines | Normal | `<Leader> p s b` |
| Snacks | Command History | Normal | `<Leader> p s c` |
| Snacks | Commands | Normal | `<Leader> p s C` |
| Snacks | Diagnostics | Normal | `<Leader> p s d` |
| Snacks | Buffer Diagnostics | Normal | `<Leader> p s D` |
| Snacks | Help Pages | Normal | `<Leader> p s h` |
| Snacks | Highlights | Normal | `<Leader> p s H` |
| Snacks | Icons | Normal | `<Leader> p s I` |
| Snacks | Jumps | Normal | `<Leader> p s j` |
| Snacks | Keymaps | Normal | `<Leader> p s k` |
| Snacks | Location List | Normal | `<Leader> p s l` |
| Snacks | Marks | Normal | `<Leader> p s m` |
| Snacks | Man Pages | Normal | `<Leader> p s M` |
| Snacks | Search for Plugin Spec | Normal | `<Leader> p s p` |
| Snacks | Quickfix List | Normal | `<Leader> p s q` |
| Snacks | Resume | Normal | `<Leader> p s R` |
| Snacks | Undo History | Normal | `<Leader> p s u` |
| Snacks | Colorschemes | Normal | `<Leader> p s S` |
| Snacks | Goto Definition | Normal | `<Leader> p l d` |
| Snacks | Goto Declaration | Normal | `<Leader> p l D` |
| Snacks | References | Normal | `<Leader> p l r` |
| Snacks | Goto Implementation | Normal | `<Leader> p l i` |
| Snacks | Goto Type Definition | Normal | `<Leader> p l t` |
| Snacks | LSP Symbols | Normal | `<Leader> p l s` |
| Snacks | LSP Workspace Symbols | Normal | `<Leader> p l S` |
| Snacks | Find Todo | Normal | `<Leader> p s t` |
| Snacks | Find Todo/Fix/Fixme | Normal | `<Leader> p s T` |
| Telescope | telescope live grep | Normal | `<Leader> f w` |
| Telescope | telescope find buffers | Normal | `<Leader> f b` |
| Telescope | telescope help page | Normal | `<Leader> f h` |
| Telescope | telescope find marks | Normal | `<Leader> f m` |
| Telescope | find word under cursor | Normal | `<Leader> f W` |
| Telescope | telescope find oldfiles | Normal | `<Leader> f o` |
| Telescope | telescope find in current buffer | Normal | `<Leader> f z` |
| Telescope | telescope git commits | Normal | `<Leader> f c` |
| Telescope | telescope git status | Normal | `<Leader> f g` |
| Telescope | telescope pick hidden term | Normal | `<Leader> f r` |
| Telescope | telescope find files | Normal | `<Leader> f f` |
| Telescope | telescope find all files (follow/no_ignore/hidden) | Normal | `<Leader> f a` |
| TODO Comment | next todo | Normal | `] n` |
| TODO Comment | previous todo | Normal | `[ n` |
| Trouble | Open trouble quickfix list | Normal | `<Leader> T q` |
| Trouble | Open todos in trouble | Normal | `<Leader> T t` |
| Trouble | Workspace Diagnostics (Trouble) | Normal | `<Leader> T x` |
| Trouble | Buffer Diagnostics (Trouble) | Normal | `<Leader> T X` |
| Trouble | Symbols (Trouble) | Normal | `<Leader> T S` |
| Trouble | LSP Definitions / references / ... (Trouble) | Normal | `<Leader> T l` |
| Trouble | Location List (Trouble) | Normal | `<Leader> T L` |
| Trouble | Quickfix List (Trouble) | Normal | `<Leader> T Q` |
| Undotree | Open Undo Tree | Normal | `<Leader> u` |
| Vim Maximizer | Max / Min split | Normal | `<Leader> +` |
| which-key.nvim | whichkey all keymaps | Normal | `<Leader> w K` |
| which-key.nvim | whichkey query lookup | Normal | `<Leader> w k` |
| Worktree | Worktree: Create | Normal | `<Leader> g w c` |
| Worktree | Worktree: Switch | Normal | `<Leader> g w s` |
| Worktree | Worktree: Delete | Normal | `<Leader> g w d` |

</details>
[🔼 Back to top](#-table-of-contents)

---

🎉 That’s it 


# Credits

1) NvChad https://nvchad.com/
