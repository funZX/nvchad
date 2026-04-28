# NvChad Agent Guide

## Project Context
- **NvChad** is a Neovim configuration (Lua) designed as a **lazy.nvim plugin**, meant to be imported into a starter config rather than used standalone.
- **Branch**: `v3.0`
- **Minimal setup**: No build, test, or CI workflows. Stylua (stylua.toml) is the only formatter configured.

## Structure
- `lua/nvchad/autocmds.lua` – autocommands (FilePost user event, TreeSitter auto-start)
- `lua/nvchad/options.lua` – vim settings (tab width 4, expand tabs, numbering, etc.)
- `lua/nvchad/mappings.lua` – keybindings (mostly leader-key driven)
- `lua/nvchad/plugins/` – plugin specs by category:
  - `base.lua` – themes, UI plugins (base46, ui, nvim-tree, mini.icons)
  - `editor.lua` – (empty; user plugins would go here)
  - `code.lua` – development utilities (DAP, gitsigns, indent-blankline)
  - `lsp.lua` – LSP setup (lsp_signature, rustaceanvim)
  - `snacks.lua` – comprehensive UI/picker framework with many leader-key bindings
  - `copilot.lua` – Copilot + Sidekick (OpenCode integration with `<leader>a*` keys)
  - `init.lua` – imports all plugin groups
- `lua/nvchad/configs/` – plugin configuration modules:
  - `lsp.lua` – LSP on_attach, on_init, capabilities (used by LSP plugins)
  - `nvimtree.lua`, `gitsigns.lua`, `treesitter.lua`, `luasnip.lua`, `dap.lua`
  - `lsp/` – per-language LSP server configs (gopls, clangd, lua_ls, etc.)

## Key Patterns & Details

### Plugin Specs
- All plugins are lazy.nvim specs (return tables with `dir`, `event`, `config`, `opts`, etc.)
- Most plugins import configs: `require "nvchad.configs.pluginname"`
- Configs use `dofile(vim.g.base46_cache .. "name")` to load theme styling

### DAP (Debugger)
- Python DAP expects venv at `~/.local/venv/debugpy/bin/python` (hardcoded in `code.lua:36`)
- Debug keybindings: F5 (continue), F10 (step-over), F11 (step-into), S-F11 (step-out), F9 (breakpoint)

### OpenCode Integration
- Sidekick plugin provides OpenCode CLI access via keybindings:
  - `<leader>aa` – toggle OpenCode
  - `<leader>ad` – detach session
  - `<leader>at` – send current selection/line
  - `<leader>af` – send file
  - `<leader>ap` – prompt select

### Styling & Format
- Stylua config: column_width=120, indent=2 spaces, double quotes, no call parentheses
- Base46 theme system: many plugins call `dofile(vim.g.base46_cache .. "name")` to apply theme colors

### LSP & Autocmds
- `autocmds.lua` creates `User FilePost` event for late-loading logic
- LSP on_attach maps workspace and renaming shortcuts
- on_init disables semantic tokens for Neovim < 0.11 compatibility

## Missing/Generated Files
- **`nvchad.blink.lazyspec`** is imported in `code.lua` but doesn't exist in this repo—likely generated or provided by starter config

## Development Quirks
- Very short commit messages (one or two words) in git history
- No existing AGENTS.md, CLAUDE.md, or CI workflows
- Light codebase (~27 Lua files); most changes are plugin adds/removals or config tweaks
