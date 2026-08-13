# NvChad 2.5 – Neovim 0.12 Rust configuration

This repository is a complete Neovim user configuration built on NvChad 2.5. It includes Rust Analyzer integration, Cargo-aware run/test/debug commands, rustfmt, Cargo checks, crates.nvim, Neotest, RustOwl ownership visualization, Treesitter textobjects, DAP/codelldb, Git tooling, multiple pickers, and multiple file explorers.

## Requirements

- Neovim 0.12.4 or newer within the 0.12 release line
- Git
- A Nerd Font configured in the terminal
- Rust installed through rustup
- ripgrep and fd
- make and a C compiler (required by native plugins)
- tree-sitter-cli 0.26.1 or newer
- lazygit, if the Snacks Lazygit integration is used
- Node.js 18 or newer, only for GitHub Copilot

Install the required Rust components:

```bash
rustup component add rust-analyzer rustfmt clippy
```

Rustaceanvim recommends using the rust-analyzer that belongs to the active Rust toolchain instead of installing a separate copy through Mason.

Install the RustOwl language server with its official prebuilt installer:

```bash
curl -L https://raw.githubusercontent.com/cordx56/rustowl/refs/heads/main/scripts/installer | sh
export PATH="$HOME/.rustowl:$PATH"
```

Add the `export` line to `~/.zshrc`, `~/.bashrc`, or the equivalent profile for the shell that launches Neovim. The plugin remains available when the binary is missing, but it will not auto-attach and `<leader>Ro` will show an installation warning instead of spawning a broken language-server process.

## Installation

Back up an existing configuration first.

### Linux / WSL

```bash
mv ~/.config/nvim ~/.config/nvim-old 2>/dev/null || true
git clone https://github.com/A-Hegazi/nvc-nvim.git ~/.config/nvim
nvim
```

### Windows PowerShell

```powershell
if (Test-Path $env:LOCALAPPDATA\nvim) {
  Rename-Item $env:LOCALAPPDATA\nvim "$($env:LOCALAPPDATA)\nvim-old"
}

git clone https://github.com/A-Hegazi/nvc-nvim.git $env:LOCALAPPDATA\nvim
nvim
```

NvChad is installed automatically by `init.lua`; do not clone NvChad separately or overlay this repository on another NvChad checkout.

On the first launch, wait for Lazy to install the plugins and Treesitter parsers. Mason will install codelldb for DAP. RustOwl is installed separately with the prebuilt installer above because building it with a normal `cargo install` does not provide its pinned compiler toolchain. Other external development tools should be installed through the language's normal toolchain.

## Rust workflow

Rust Analyzer is managed exclusively by rustaceanvim. Do not also enable `rust_analyzer` through nvim-lspconfig.

- `cargo check` runs through rust-analyzer when a Rust file is saved.
- rustfmt formats Rust files on save through Conform.
- Clippy is intentionally manual so saving remains responsive.
- Cargo runnables, tests, macro expansion, code actions, and debuggables are provided by rustaceanvim.
- Rustaceanvim testables run in the background and report failures as diagnostics.
- Neotest provides nearest/file/project test runs, output panels, watch mode, and DAP debugging.
- codelldb is installed through Mason and used through nvim-dap.
- DAP virtual text shows values inline while debugging.
- RustOwl ownership and lifetime hints are opt-in with `<leader>Ro`, so its deeper analysis does not run continuously.

### Rust mappings

| Mapping | Action |
|---|---|
| `<leader>Ra` | Rust grouped code action |
| `<leader>Rh` | Rust hover actions |
| `<leader>Rr` | Select a Cargo runnable |
| `<leader>Rt` | Select Rust tests |
| `<leader>Re` | Expand the macro under the cursor |
| `<leader>Rp` | Open the parent module |
| `<leader>Rf` | Run rust-analyzer's check now |
| `<leader>Rc` | Run `cargo clippy --all-targets` in a terminal |
| `<leader>Rd` | Select a debuggable Cargo target |
| `<leader>Ri` | Toggle inlay hints |
| `<leader>RI` | Show inlay hints until the next movement |
| `<leader>Ro` | Toggle RustOwl ownership and lifetime hints |

The `<leader>R` mappings are buffer-local and exist only while editing Rust.

### Debugger mappings

| Mapping | Action |
|---|---|
| `<F5>` / `<leader>Dc` | Start or continue |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>Db` | Toggle breakpoint |
| `<leader>DB` | Set conditional breakpoint |
| `<leader>Du` | Toggle the debugger UI |
| `<leader>Dr` | Open the debugger REPL |
| `<leader>Dx` | Terminate the session |
| `<leader>Dv` | Toggle inline debugger values |

Use `<leader>Rd` in a Rust buffer to select a Cargo debug target.

## General mappings

The configuration contains many plugin mappings. Press `<leader>` and use which-key to discover them. The primary groups are:

| Prefix | Group |
|---|---|
| `<leader>a` | Copilot |
| `<leader>C` | Cargo dependencies |
| `<leader>D` | Debugger |
| `<leader>e` / `<leader>E` | Neo-tree |
| `<leader>f` | Telescope |
| `<leader>g` | Git tools |
| `<leader>l` | LSP |
| `<leader>m` | mini.nvim |
| `<leader>N` | Tests |
| `<leader>o` | Harpoon |
| `<leader>p` | Snacks Picker |
| `<leader>r` | Code Runner |
| `<leader>R` | Rust, in Rust buffers only |
| `<leader>s` | Snacks |
| `<leader>T` | Trouble |
| `<leader>t` | Tabs |

Important standalone mappings:

| Mapping | Action |
|---|---|
| `<leader>z` | Format through Conform |
| `<leader>ld` | Toggle inline diagnostics |
| `gl` | Show diagnostic under the cursor |
| `-` | Open Oil |
| `<leader>-` | Open Oil in a floating window |
| `<leader>u` | Toggle Undotree |
| `<leader>+` | Maximize or restore a window |
| `[t` / `]t` | Previous or next TODO comment |

## Pickers and file explorers

The overlapping navigation tools are intentional and remain enabled:

- Snacks Picker and Telescope
- Neo-tree and Snacks Explorer
- Oil for directory-buffer editing

## Plugin inventory

The overlapping pickers and explorers are intentional. This table lists the configured plugin stack, including NvChad components that this repository extends or replaces.

| Area | Plugins | Purpose |
|---|---|---|
| Distribution | NvChad 2.5, lazy.nvim | Base configuration and plugin manager |
| Completion | blink.cmp, LuaSnip, friendly-snippets | Completion, snippets, documentation, and signatures |
| Rust | rustaceanvim, crates.nvim, RustOwl | Rust Analyzer, Cargo actions, crate versions, ownership visualization, and Rust DAP integration |
| Testing | neotest, nvim-nio, rustaceanvim Neotest adapter | Test discovery, execution, output, watch mode, and DAP debugging |
| LSP and tools | nvim-lspconfig, Mason, mason-lspconfig | Language servers and external tool installation |
| Formatting and linting | conform.nvim, nvim-lint | Formatting and diagnostics |
| Debugging | nvim-dap, nvim-dap-ui, nvim-dap-virtual-text, nvim-nio, mason-nvim-dap, codelldb | Debug adapter, UI, inline values, and Rust debugger |
| Syntax | nvim-treesitter, nvim-treesitter-textobjects, nvim-ts-autotag | Parsing, highlighting, structural selection/movement, and automatic tag closing |
| Pickers | snacks.nvim, telescope.nvim, telescope-fzf-native.nvim, telescope-themes | File, text, symbol, Git, LSP, and theme pickers |
| File explorers | neo-tree.nvim, snacks.nvim explorer, oil.nvim | Tree views and editable directory buffers |
| Git | vim-fugitive, gitsigns.nvim, git-worktree.nvim, snacks.nvim Lazygit | Git commands, hunks, worktrees, and Lazygit |
| Navigation | harpoon, todo-comments.nvim, trouble.nvim, undotree, vim-maximizer | Marks, TODOs, lists, undo history, and window zoom |
| Editing | mini.nvim, mini.trailspace, neotab.nvim, nvim-ufo | Surround/split-join, whitespace, tabout, and folding |
| Running code | code_runner.nvim | File, project, and custom commands |
| AI | copilot.vim, CopilotChat.nvim | Suggestions and chat |
| UI | noice.nvim, nvim-notify, which-key.nvim, render-markdown.nvim | Messages, notifications, key discovery, and Markdown rendering |
| Neo-tree support | nvim-lsp-file-operations, nvim-window-picker | LSP-aware file moves and window selection |
| Disabled/replaced | nvim-tree.lua, nvim-cmp, indent-blankline.nvim | Replaced by the explorers above, blink.cmp, and Snacks indent guides |

## Complete shortcut reference

`<leader>` is the Space key. The tables below include the mappings declared by this repository plus the important NvChad mappings retained by the configuration. Rust mappings are buffer-local. Some picker and explorer actions intentionally overlap.

### Core editing, buffers, windows, and tabs

| Mode | Mapping | Action |
|---|---|---|
| Normal | `;` | Enter command-line mode |
| Insert | `jk` | Return to normal mode |
| Normal | `<Esc>` | Clear search highlighting |
| Normal | `<C-s>` | Save the file |
| Normal | `<C-c>` | Copy the whole file |
| Normal | `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Move between windows |
| Normal | `<C-Up>` / `<C-Down>` | Resize the window vertically |
| Normal | `<C-Left>` / `<C-Right>` | Resize the window horizontally |
| Insert | `<C-b>` / `<C-e>` | Move to beginning/end of line |
| Insert | `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Move left/down/up/right |
| Normal | `J` | Join lines while preserving cursor position |
| Visual | `<A-j>` / `<A-k>` | Move the selection down/up |
| Visual | `<` / `>` | Indent left/right and keep the selection |
| Visual | `<leader>l` / `<leader>P` | Paste without replacing the clipboard |
| Normal/Visual | `<leader>d` | Delete without replacing the clipboard |
| Normal | `<leader>W` | Replace the word under the cursor globally |
| Normal | `n` / `N` | Next/previous search result, centered |
| Normal | `<C-d>` / `<C-u>` | Half-page down/up, centered |
| Normal | `<leader>se` | Make split windows equal size |
| Normal | `<leader>+` | Maximize or restore the current window |
| Normal | `<leader>n` | Toggle absolute line numbers |
| Normal | `<leader>.` | Toggle relative line numbers |
| Normal | `<leader>b` | Create a new buffer |
| Normal | `<leader>x` | Close the current buffer |
| Normal | `<Tab>` / `<S-Tab>` | Next/previous buffer |
| Normal | `<leader>to` | Open a new tab |
| Normal | `<leader>tx` | Close the current tab |
| Normal | `<leader>tn` / `<leader>tp` | Next/previous tab |
| Normal | `<leader>tf` | Open the current buffer in a new tab |
| Normal | `<leader>h` / `<leader>v` | Open a horizontal/vertical terminal |
| Terminal | `<A-h>` / `<A-v>` / `<A-i>` | Toggle horizontal/vertical/floating terminal |
| Terminal | `<C-x>` | Leave terminal mode |
| Normal | `<leader>i` | Copy the current file path |
| Normal/Visual | `<leader>/` | Toggle comment |
| Normal | `<leader>c` | Open the NvChad cheatsheet |
| Normal | `<leader>u` | Toggle Undotree |

### LSP, diagnostics, formatting, completion, and syntax

| Context | Mapping | Action |
|---|---|---|
| LSP | `K` | Show hover documentation |
| LSP | `<leader>la` | Add a workspace folder |
| LSP | `<leader>lo` | Remove a workspace folder |
| LSP | `<leader>ll` | List workspace folders |
| LSP | `<leader>lt` | Go to type definition |
| LSP | `<leader>lr` | Rename symbol |
| LSP | `gD` / `gd` | Go to declaration / definition |
| Normal | `gl` | Show diagnostic under the cursor |
| Normal | `<leader>ld` | Toggle diagnostic virtual text and underlines |
| Normal | `<leader>ls` | Send diagnostics to the location list |
| Normal/Visual | `<leader>z` | Format through Conform |
| Insert | `<C-d>` / `<C-u>` | Scroll completion documentation down/up |
| Insert | `<C-k>` / `<C-j>` | Show/hide completion documentation |
| Insert | `<C-s>` / `<C-h>` | Show/hide signature help |
| Treesitter selection | `<Enter>` | Start or increment node selection |
| Treesitter selection | `<Tab>` | Increment scope selection |
| Treesitter selection | `<S-Tab>` | Decrement node selection |
| Treesitter textobject | `af` / `if` | Select outer / inner function |
| Treesitter textobject | `ac` / `ic` | Select outer / inner class |
| Treesitter textobject | `aa` / `ia` | Select outer / inner argument |
| Treesitter textobject | `]f` / `[f` | Go to next / previous function |
| Treesitter textobject | `]a` / `[a` | Go to next / previous argument |
| Treesitter textobject | `<leader>msn` / `<leader>msp` | Swap argument with next / previous argument |
| Normal | `zR` / `zM` | Open/close all folds with UFO |
| Normal | `za` | Toggle the fold under the cursor |
| Insert | `<A-d>` / `<A-a>` | Neotab forward/reverse tabout |

### Rust and debugging

| Context | Mapping | Action |
|---|---|---|
| Rust | `<leader>Ra` | Rust grouped code action |
| Rust | `<leader>Rh` | Rust hover actions |
| Rust | `<leader>Rr` | Select a Cargo runnable |
| Rust | `<leader>Rt` | Select Rust tests |
| Rust | `<leader>Re` | Expand the macro under the cursor |
| Rust | `<leader>Rp` | Open the parent module |
| Rust | `<leader>Rf` | Run rust-analyzer's check now |
| Rust | `<leader>Rc` | Run `cargo clippy --all-targets` in a terminal |
| Rust | `<leader>Rd` | Select a debuggable Cargo target |
| Rust | `<leader>Ri` | Toggle inlay hints |
| Rust | `<leader>RI` | Show inlay hints until the next movement |
| Rust | `<leader>Ro` | Toggle RustOwl ownership and lifetime hints |
| DAP | `<F5>` / `<leader>Dc` | Start or continue |
| DAP | `<F10>` | Step over |
| DAP | `<F11>` | Step into |
| DAP | `<F12>` | Step out |
| DAP | `<leader>Db` | Toggle breakpoint |
| DAP | `<leader>DB` | Set a conditional breakpoint |
| DAP | `<leader>Du` | Toggle the debugger UI |
| DAP | `<leader>Dr` | Open the debugger REPL |
| DAP | `<leader>Dx` | Terminate the session |
| DAP | `<leader>Dv` | Toggle inline debugger values |

### Cargo dependencies and tests

The crates.nvim mappings are buffer-local to TOML files handled by crates.nvim. Neotest uses rustaceanvim's built-in Rust adapter; `neotest-rust` is intentionally not installed.

| Context | Mapping | Action |
|---|---|---|
| crates.nvim | `<leader>Ct` | Toggle crate virtual text |
| crates.nvim | `<leader>Cr` | Reload crate data |
| crates.nvim | `<leader>Cv` | Show available versions |
| crates.nvim | `<leader>Cf` | Show crate features |
| crates.nvim | `<leader>Cd` | Show crate dependencies |
| crates.nvim | `<leader>Cu` | Update crate under cursor; update selected crates in Visual mode |
| crates.nvim | `<leader>Ca` | Update all crates |
| crates.nvim | `<leader>CU` | Upgrade crate under cursor; upgrade selected crates in Visual mode |
| crates.nvim | `<leader>CA` | Upgrade all crates |
| crates.nvim | `<leader>CH` | Open crate homepage |
| crates.nvim | `<leader>CR` | Open crate repository |
| crates.nvim | `<leader>CD` | Open crate documentation |
| crates.nvim | `<leader>CC` | Open crate on crates.io |
| Neotest | `<leader>Nn` | Run the nearest test |
| Neotest | `<leader>Nf` | Run tests in the current file |
| Neotest | `<leader>Na` | Run all project tests |
| Neotest | `<leader>Nd` | Debug the nearest test with DAP |
| Neotest | `<leader>Ns` | Toggle the test summary |
| Neotest | `<leader>No` | Show nearest test output |
| Neotest | `<leader>Np` | Toggle the test output panel |
| Neotest | `<leader>Nw` | Watch the current file |
| Neotest | `<leader>Nx` | Stop the nearest test run |

### Telescope, Snacks, and explorers

| Plugin | Mapping | Action |
|---|---|---|
| Telescope | `<leader>fw` | Live grep |
| Telescope | `<leader>fW` | Grep the word under the cursor |
| Telescope | `<leader>fb` | Find buffers |
| Telescope | `<leader>fh` | Help tags |
| Telescope | `<leader>fo` | Old files |
| Telescope | `<leader>fz` | Find in current buffer |
| Telescope | `<leader>ff` | Find files |
| Telescope | `<leader>fa` | Find all files, including hidden files |
| Telescope | `<leader>fm` | Marks |
| Telescope | `<leader>fc` | Git commits |
| Telescope | `<leader>fg` | Git status |
| Telescope | `<leader>fr` | Hidden terminals |
| Telescope | `<leader>ft` | Themes |
| Telescope window | `<C-k>` / `<C-j>` | Move to the previous/next result |
| Snacks | `<leader>p<Space>` | Smart file picker |
| Snacks | `<leader>pn` | Notification history |
| Snacks files | `<leader>pfb` / `<leader>pfc` | Buffers / config files |
| Snacks files | `<leader>pff` / `<leader>pfg` | Files / Git files |
| Snacks files | `<leader>pfp` / `<leader>pfr` | Projects / recent files |
| Snacks Git | `<leader>pgb` / `<leader>pgl` / `<leader>pgL` | Git branches / log / log line |
| Snacks Git | `<leader>pgs` / `<leader>pgS` | Git status / stash |
| Snacks Git | `<leader>pgd` / `<leader>pgf` | Git diff / log for current file |
| Snacks grep | `<leader>prg` / `<leader>prb` / `<leader>prw` | Grep / grep buffers / grep word |
| Snacks search | `<leader>psr` / `<leader>psi` | Registers / search history |
| Snacks search | `<leader>psa` / `<leader>psb` | Autocommands / buffer lines |
| Snacks search | `<leader>psc` / `<leader>psC` | Command history / commands |
| Snacks search | `<leader>psd` / `<leader>psD` | Diagnostics / buffer diagnostics |
| Snacks search | `<leader>psh` / `<leader>psH` | Help / highlights |
| Snacks search | `<leader>psI` | Icons |
| Snacks search | `<leader>psj` / `<leader>psk` | Jumps / keymaps |
| Snacks search | `<leader>psl` / `<leader>psm` | Location list / marks |
| Snacks search | `<leader>psM` / `<leader>psp` | Man pages / plugin specs |
| Snacks search | `<leader>psq` / `<leader>psR` | Quickfix / resume last picker |
| Snacks search | `<leader>psu` / `<leader>psS` | Undo history / colorschemes |
| Snacks LSP | `<leader>pld` / `<leader>plD` | Definitions / declarations |
| Snacks LSP | `<leader>plr` / `<leader>pli` | References / implementations |
| Snacks LSP | `<leader>plt` / `<leader>pls` | Type definitions / document symbols |
| Snacks LSP | `<leader>plS` | Workspace symbols |
| Snacks TODO | `<leader>pst` / `<leader>psT` | TODOs / TODO and FIXME items |
| Snacks | `<leader>sf` | Toggle Snacks Explorer |
| Snacks | `<leader>sr` | Rename the current file |
| Snacks | `<leader>sd` | Delete the current buffer |
| Neo-tree | `<leader>ef` / `<leader>eg` / `<leader>eb` | Filesystem / Git / buffers |
| Neo-tree | `<leader>Ef` / `<leader>Eg` / `<leader>Eb` | Floating filesystem / Git / buffers |
| Snacks input | `<C-c>` | Cancel a Snacks input prompt |
| Neo-tree | `<leader>es` | Toggle document symbols |
| Neo-tree window | `<Tab>` | Toggle the selected node |
| Oil | `-` | Open the parent directory |
| Oil | `<leader>-` | Open Oil in a floating window |
| Oil window | `<M-h>` | Open the selected entry in a split |
| Oil window | `q` | Close Oil |

### Git and worktrees

| Plugin | Mapping | Action |
|---|---|---|
| Fugitive | `<leader>gfg` | Git status |
| Fugitive | `<leader>gfb` | Git blame |
| Fugitive | `<leader>gfl` | Git log |
| Fugitive | `<leader>gfd` | Git diff |
| Fugitive | `<leader>gfs` | Open a vertical Git diff |
| Fugitive | `<leader>gfa` | Git add current file |
| Fugitive | `<leader>gfc` | Git commit |
| Fugitive | `<leader>gfp` / `<leader>gfP` | Git push / pull |
| Fugitive | `<leader>gfo` / `<leader>gfB` | Git browse/open mappings are configured but disabled |
| Gitsigns | `<leader>gss` / `<leader>gsu` | Stage / undo-stage hunk |
| Gitsigns | `<leader>gsr` / `<leader>gsR` | Reset hunk / reset buffer |
| Gitsigns | `<leader>gsp` | Preview hunk |
| Gitsigns | `<leader>gsb` | Blame line |
| Gitsigns | `<leader>gsd` / `<leader>gsD` | Diff against index / previous revision |
| Gitsigns | `<leader>gsn` / `<leader>gsP` | Next / previous hunk |
| Worktree | `<leader>gwc` | Create a worktree |
| Worktree | `<leader>gws` | Switch worktrees |
| Worktree | `<leader>gwd` | Delete a worktree |
| Snacks Lazygit | `<leader>gll` / `<leader>glg` | Open Lazygit / Lazygit log |

### Code Runner, Harpoon, mini.nvim, TODO, and Trouble

| Plugin | Mapping | Action |
|---|---|---|
| Code Runner | `<leader>rr` | Run code |
| Code Runner | `<leader>rf` | Run the filetype command |
| Code Runner | `<leader>rp` | Run the project command |
| Code Runner | `<leader>rt` / `<leader>rl` | Run in a tab / floating window |
| Code Runner | `<leader>rs` / `<leader>rv` | Run in a horizontal / vertical split |
| Code Runner | `<leader>rc` | Close Code Runner |
| Code Runner | `<leader>rF` / `<leader>rP` | Show filetype / project command |
| Code Runner | `<leader>rR` | Run a custom command |
| Harpoon | `<leader>oa` | Add the current file |
| Harpoon | `<leader>ot` | Toggle the Harpoon menu |
| Harpoon | `<leader>o1` ... `<leader>o4` | Select Harpoon item 1 ... 4 |
| Harpoon | `<leader>op` / `<leader>on` | Previous / next Harpoon item |
| mini.trailspace | `<leader>mh` / `<leader>mu` | Highlight / unhighlight trailing spaces |
| mini.trailspace | `<leader>mt` / `<leader>mr` | Trim trailing spaces / remove final blank lines |
| mini.splitjoin | `<leader>ms` / `<leader>mj` | Split / join arguments |
| mini.surround | `sa` / `sd` | Add / delete surrounding |
| mini.surround | `sf` / `sF` | Find surrounding right / left |
| mini.surround | `sh` / `sr` / `sn` | Highlight / replace / update surrounding count |
| TODO comments | `]t` / `[t` | Next / previous TODO comment |
| Trouble | `<leader>Tq` | Quickfix list |
| Trouble | `<leader>Tt` | TODO list |
| Trouble | `<leader>Tx` / `<leader>TX` | Diagnostics / buffer diagnostics |
| Trouble | `<leader>TS` | Symbols |
| Trouble | `<leader>Tl` / `<leader>TL` | LSP definitions/references / location list |
| Trouble | `<leader>TQ` | Quickfix list |

### Copilot and CopilotChat

| Mode | Mapping | Action |
|---|---|---|
| Normal | `<leader>aa` | Toggle Copilot panel |
| Normal | `<leader>al` | Copilot login |
| Normal | `<leader>as` | Copilot status |
| Normal | `<leader>aS` | Stop Copilot |
| Normal | `<leader>ae` / `<leader>ad` | Enable / disable Copilot |
| Insert | `<C-l>` | Accept suggestion |
| Insert | `<A-]>` / `<A-[>` | Next / previous suggestion |
| Insert | `<C-\>` | Dismiss suggestion |
| Normal | `<leader>ac` | Toggle CopilotChat |
| Normal/Visual | `<leader>aq` | Open CopilotChat prompts |
| Normal/Visual | `<leader>ax` | Explain code |
| Normal/Visual | `<leader>ar` | Review code |
| Normal/Visual | `<leader>af` | Fix issues |
| Normal/Visual | `<leader>ao` | Optimize code |
| Normal/Visual | `<leader>at` | Generate tests |
| Normal | `<leader>ag` | Generate a commit message for staged changes |
| Normal | `<leader>aR` | Reset the chat session |
| Normal | `<leader>az` | Stop the current response |
| Normal | `<leader>am` | Choose a Copilot model |

### Which-key groups

| Mapping | Group |
|---|---|
| `<leader>wK` / `<leader>wk` | Show all keymaps / query a keymap |
| `<leader>a` | Copilot |
| `<leader>C` | Cargo dependencies |
| `<leader>D` | Debugger |
| `<leader>e` / `<leader>E` | Neo-tree |
| `<leader>f` | Telescope |
| `<leader>g` | Git |
| `<leader>gf` / `<leader>gl` | Fugitive / Lazygit |
| `<leader>gs` / `<leader>gw` | Gitsigns / Git worktrees |
| `<leader>l` | LSP |
| `<leader>m` | mini.nvim |
| `<leader>N` | Tests |
| `<leader>o` | Harpoon |
| `<leader>p` | Snacks Picker |
| `<leader>pf` / `<leader>pg` | Snacks find / Git pickers |
| `<leader>pl` / `<leader>pr` / `<leader>ps` | Snacks LSP / grep / search pickers |
| `<leader>r` | Code Runner |
| `<leader>R` | Rust in Rust buffers |
| `<leader>s` | Snacks |
| `<leader>sl` | Snacks Lazygit |
| `<leader>T` | Trouble |
| `<leader>t` | Tabs |

## Formatting and diagnostics

- Rust: rustfmt plus rust-analyzer `cargo check`
- Lua: Stylua
- Python: Black and Ruff
- Global inline diagnostic text and underlines start disabled.
- Use `<leader>ld` to toggle inline diagnostics, `gl` for a diagnostic float, or Trouble/Snacks for lists.

## Health checks

Run these after installation or when troubleshooting:

```vim
:checkhealth
:checkhealth rustaceanvim
:LspInfo
:ConformInfo
:Lazy profile
```

For Rust Analyzer logs:

```vim
:RustLsp logFile
```

The CI workflow also boots Neovim 0.12.4, installs the locked plugins, Treesitter parsers, RustOwl, and codelldb, opens a real Cargo project, waits for rust-analyzer, and verifies the Rust, testing, debugger, Mason, Blink, RustOwl, and Treesitter integrations. This catches installation and compatibility regressions that a Lua syntax check alone would miss.

If `cargo-nextest` is installed, rustaceanvim and its Neotest adapter will use it automatically. It is optional; regular `cargo test` remains supported.

## Neovim 0.12 and Treesitter

This configuration deliberately targets Neovim 0.12.4. `nvim-treesitter` and `nvim-treesitter-textobjects` use their maintained `main` branches, load eagerly as required upstream, and use the new setup/install/highlight/indent APIs. Rustaceanvim uses its Neovim 0.12-compatible v9 line, while blink.cmp is pinned to its compatible v1 line until NvChad adopts Blink's v2 configuration model.

Do not switch Treesitter back to the legacy `master` configuration. After updating its plugins, run `:TSUpdate` and restart Neovim so the parser binaries match the runtime.

## Updating

Inside Neovim:

```vim
:Lazy sync
:TSUpdate
:MasonUpdate
```

Mason's interactive window is `:Mason`. Install a particular package with `:MasonInstall <package>`, for example `:MasonInstall codelldb`. `:MasonInstallAll` is not a Mason command in this configuration; the required codelldb package is managed automatically by mason-nvim-dap.

Keep `lazy-lock.json` committed so plugin versions remain reproducible.

## Troubleshooting

- Missing icons: configure a Nerd Font in the terminal.
- Rust Analyzer unavailable: run `rustup component add rust-analyzer`.
- rustfmt unavailable: run `rustup component add rustfmt`.
- Clippy unavailable: run `rustup component add clippy`.
- Debugging unavailable: run `:MasonInstall codelldb`, then `:checkhealth rustaceanvim`.
- `:Mason` is unknown: run `:Lazy sync`, restart Neovim, and check `:Lazy` for `mason.nvim`; the configured upstream repository is `mason-org/mason.nvim`.
- Blink reports a Treesitter `range` error: run `:Lazy sync`, `:TSUpdate`, restart Neovim, and confirm `:version` reports Neovim 0.12.4 or newer.
- Rust tests are not discovered: open Neotest's summary with `<leader>Ns`, confirm rust-analyzer is attached with `:LspInfo`, and check the Cargo workspace from the project root.
- RustOwl hints are absent: use `<leader>Ro` in a Rust buffer inside a Cargo workspace; the integration is deliberately disabled until toggled.
- RustOwl cannot spawn: verify `~/.rustowl/rustowl --version`, add `~/.rustowl` to the PATH of the shell that launches Neovim, then fully restart Neovim.
- Native Telescope extension failed: install make and a C compiler.
- Search commands failed: install ripgrep and fd.
- Slow Rust save: inspect the rust-analyzer log and use `:Lazy profile`; Clippy is not configured to run on save.

## License

See [LICENSE](LICENSE).
