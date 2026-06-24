# NvChad Agent Guide

This guide helps OpenCode agents quickly understand and work with the NvChad codebase.

## Structure

NvChad uses a **modular plugin architecture** distributed across three repositories:

### Repository Architecture

```
/workspace/
├── nvchad/          # Main configuration (this repo)
│   └── lua/nvchad/  # Core config, options, mappings, plugins, LSP/DAP configs
├── ui/              # UI components and utilities (separate repo)
│   └── lua/nvchad/  # UI modules: statusline, tabufline, renamer, LSP utilities
├── base46/          # Theme system (separate repo)
│   └── lua/nvchad/  # Theme caching and color integrations
└── template/        # Starter template (separate repo)
```

Users apply NvChad via `require("nvchad")` in their Neovim config, then layer project-specific configs in `~/.config/nvim/`.

### Main Repository Directory Layout (nvchad/)

```
lua/nvchad/
├── options.lua      # Neovim core options (tabstop=4, clipboard=unnamedplus, etc.)
├── mappings.lua     # Leader key mappings (LSP, DAP, buffers, comments)
├── autocmds.lua     # FilePost event for editorconfig + FileType auto-start treesitter
├── plugins/         # Lazy plugin specs (loaded via import feature)
│   ├── base.lua     # base46 UI, mini.icons, which-key, treesitter
│   ├── editor.lua   # render-markdown.nvim
│   ├── code.lua     # blink.cmp (LSP client), indent-blankline, nvim-dap-ui & dap-python
│   ├── lsp.lua      # lsp_signature.nvim, rustaceanvim
│   ├── git.lua      # neogit
│   ├── copilot.lua  # sidekick.nvim, copilot.lua integration
│   └── snacks.lua   # picker, explorer, notifier, dashboard, terminal, etc.
├── configs/
│   ├── lsp/         # per-server configs (clangd, rusta, gopls, ruff, etc.)
│   ├── dap.lua      # gdb/lldb DAP adapters, config for C/C++/Rust
│   ├── treesitter.lua # ensure_installed list (c, python, rust, lua, tsx, etc.)
│   ├── luasnip.lua  # load VSCode/snipmate/lua snippet formats, InsertLeave fix
│   └── lsp.lua      # shared LSP capabilities and on_attach handlers
└── init.lua         # Main entry point

### UI Repository Directory Layout (ui/)

```
lua/nvchad/
├── lsp/
│   ├── init.lua     # LSP utilities and helpers
│   └── renamer.lua  # LSP rename implementation (used by nvchad.lsp.renamer)
├── tabufline/
│   └── init.lua     # Buffer tabline UI component
├── blink/
│   └── lazyspec.lua # Blink.cmp lazy loading spec
├── statusline/      # Statusline UI component
└── ui/              # Additional UI utilities
```

### Key Points

- **Modular Design**: Separation of concerns - config (nvchad), UI (ui), themes (base46)
- **Lazy Loading**: Plugins loaded only when needed via Lazy.nvim
- **Proper Imports**: Modules like `nvchad.lsp.renamer` resolve to ui repository
- **No Circular Dependencies**: Each repository has clear responsibilities
```

## Module Resolution

When working with NvChad modules, understand how imports resolve:

- `require("nvchad.lsp.renamer")` → resolves to **ui** repository (`ui/lua/nvchad/lsp/renamer.lua`)
- `require("nvchad.lsp")` → resolves to **ui** repository (`ui/lua/nvchad/lsp/init.lua`)
- `require("nvchad.tabufline")` → resolves to **ui** repository (`ui/lua/nvchad/tabufline/init.lua`)
- `require("nvchad.blink.lazyspec")` → resolves to **ui** repository (`ui/lua/nvchad/blink/lazyspec.lua`)
- `require("nvchad.configs.lsp")` → resolves to **nvchad** repository (this repo)

The Lua module path includes all three repositories, allowing seamless cross-repository imports.

## Key Conventions

- **Neovim version**: 0.10+ (minimum 0.10, some features use 0.11 APIs)
- **Language**: Lua 5.1/5.3 (Neovim runtime)
- **Styling**: `.stylua.toml` enforces 2-space indent, 120-char width, double quotes
- **Lazy loading**: Plugins loaded only when needed, with specific events/commands/keys
- **base46**: Caching theme system (`vim.g.base46_cache`)
- **Modular architecture**: Config (nvchad), UI (ui), themes (base46) are separate repositories

## Common commands and shortcuts

### Core keymaps (`<leader>` defaults to space)

| Key | Action |
|-----|--------|
| `<C-s>` | Save (`:w`) |
| `<C-c>` | Copy whole file (`+%y+`) |
| `<leader>cf` | LSP format file |
| `<leader>cr` | LSP rename |
| `<leader>/` (n/v) | Toggle comment |
| `<tab>` / `<S-tab>` | Next/prev buffer (Tabufline) |
| `<leader>x` | Close buffer (Tabufline) |
| `<F5>` | Debug continue |
| `<F9>` | Toggle breakpoint |
| `<leader>tc` | Test Python class |
| `<leader>tm` | Test Python method |

### Snacks picker (most frequent operations)

| Key | Action |
|-----|--------|
| `<leader><space>` | Smart find files |
| `<leader>ff` | Find files |
| `<leader>/` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fg` | Git files |
| `<leader>gs` | Git status |
| `<leader>ge` | Explorer |
| `<leader>z` | Zen mode toggle |
| `<leader>cn` | Neovim news |

### LSP servers configured

- bashls, clangd, rusta, gopls, ruff, robot, vtsls, vue_ls, cssls, html, lua_ls

### File types / treesitter parsers

ensure_installed includes: c, cpp, python, go, rust, robot, lua, luadoc, squirrel, html, css, javascript, latex, tsx, typescript, vue, vim, vimdoc, markdown, markdown_inline

## Setup requirements

- `~/.local/venv/debugpy/bin/python` for dap-python (run `:TSInstallAll` after first install)
- DAP requires `gdb` or `lldb-dap` at `/usr/bin/` (custom paths configurable in `configs/dap.lua`)
- Plugin installation via Lazy, no extra build steps beyond `:PackerInstall` equivalent

## Operational notes

- UI plugins (base46/ui) are loaded immediately (`lazy = false`)
- Snacks.nvim configured as high-priority, non-lazy plugin (priority 1000)
- treesitter lazy-loaded on VeryLazy event, builds via `:TSUpdate | TSInstallAll`
- `lsp_signature.nvim` attaches to LSP and provides hover signatures
- NvChad supports Neovim 0.10 (no semanticTokens) and 0.11+ with feature detection
- Use NvChad’s renamer instead of LSP-provided rename via `<leader>gR`

## Testing and validation

- No dedicated test suite; validate via Neovim runtime (run in test Neovim instance)

## Gotchas

- **Don't edit this repo's user files**: This repo is meant to be imported as a plugin; users' custom configs live in `~/.config/nvim/` (gitignored from upstream changes)
- **Modular architecture**: NvChad is split across three repos (nvchad, ui, base46). Check dependencies before flagging missing modules
- **Module resolution**: Modules like `nvchad.lsp.renamer` resolve to the ui repository, not this one
- **Neovim 0.11+ semanticTokens**: Disabled by default to avoid regressions
- **LSP root detection**: rusta uses Cargo workspace detection via `cargo metadata`; other LSPs rely on standard root markers
- **Snippet loading**: Uses multiple sources (VSCode, Snipmate, Lua); conflict resolution follows loader order
- **Debugging**: Define `_G.dd = function(...) Snacks.debug.inspect(...) end` for quick inspection (loaded on VeryLazy)
- **Optional dependencies**: nvconfig and editorconfig are optional; code should handle their absence gracefully
