# NvChad 2.5 – Rust-focused Neovim configuration

This repository is a complete Neovim user configuration built on NvChad 2.5. It includes Rust Analyzer integration, Cargo-aware run/test/debug commands, rustfmt, Cargo checks, crates.nvim, Treesitter, DAP/codelldb, Git tooling, multiple pickers, and multiple file explorers.

## Requirements

- Neovim 0.11.7 or newer within the 0.11 release line
- Git
- A Nerd Font configured in the terminal
- Rust installed through rustup
- ripgrep and fd
- make and a C compiler (required by native plugins)
- tree-sitter-cli
- lazygit, if the Snacks Lazygit integration is used
- Node.js 18 or newer, only for GitHub Copilot

Install the required Rust components:

```bash
rustup component add rust-analyzer rustfmt clippy
```

Rustaceanvim recommends using the rust-analyzer that belongs to the active Rust toolchain instead of installing a separate copy through Mason.

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

On the first launch, wait for Lazy to install the plugins. Mason will install codelldb for DAP. Other external development tools should be installed through the language's normal toolchain.

## Rust workflow

Rust Analyzer is managed exclusively by rustaceanvim. Do not also enable `rust_analyzer` through nvim-lspconfig.

- `cargo check` runs through rust-analyzer when a Rust file is saved.
- rustfmt formats Rust files on save through Conform.
- Clippy is intentionally manual so saving remains responsive.
- Cargo runnables, tests, macro expansion, code actions, and debuggables are provided by rustaceanvim.
- codelldb is installed through Mason and used through nvim-dap.

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

Use `<leader>Rd` in a Rust buffer to select a Cargo debug target.

## General mappings

The configuration contains many plugin mappings. Press `<leader>` and use which-key to discover them. The primary groups are:

| Prefix | Group |
|---|---|
| `<leader>a` | Copilot |
| `<leader>D` | Debugger |
| `<leader>e` / `<leader>E` | Neo-tree |
| `<leader>f` | Telescope |
| `<leader>g` | Git tools |
| `<leader>l` | LSP |
| `<leader>m` | mini.nvim |
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

## Neovim 0.12 and Treesitter

This configuration deliberately targets Neovim 0.11.7 and pins the legacy `nvim-treesitter` branch used by the current NvChad setup. The maintained Treesitter branch for Neovim 0.12 has a different configuration model and does not support lazy loading.

Upgrade Neovim, NvChad, rustaceanvim, and Treesitter together in a separate migration rather than changing only one component.

## Updating

Inside Neovim:

```vim
:Lazy sync
:MasonUpdate
```

Keep `lazy-lock.json` committed so plugin versions remain reproducible.

## Troubleshooting

- Missing icons: configure a Nerd Font in the terminal.
- Rust Analyzer unavailable: run `rustup component add rust-analyzer`.
- rustfmt unavailable: run `rustup component add rustfmt`.
- Clippy unavailable: run `rustup component add clippy`.
- Debugging unavailable: run `:MasonInstall codelldb`, then `:checkhealth rustaceanvim`.
- Native Telescope extension failed: install make and a C compiler.
- Search commands failed: install ripgrep and fd.
- Slow Rust save: inspect the rust-analyzer log and use `:Lazy profile`; Clippy is not configured to run on save.

## License

See [LICENSE](LICENSE).
