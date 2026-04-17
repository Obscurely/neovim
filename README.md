# Neovim Configuration

## Overview

NvChad v2.5-based (starter for lsp, cmp, themes) Neovim configuration optimized for speed, unified debugging, and strict static analysis. Configured specifically for NixOS environments with declarative dependency management (Mason disabled).

## Language Toolchain

| Language / Stack         | Language Server (LSP)              | Formatter                    | Linter / Analysis                        |
| :----------------------- | :--------------------------------- | :--------------------------- | :--------------------------------------- |
| **Rust**                 | `rust_analyzer` (rustaceanvim)     | `rustfmt`                    | Built-in                                 |
| **Python**               | `pyright`                          | `ruff`                       | `ruff`, `bandit`                         |
| **C / C++ / C#**         | `clangd`, `csharp_ls`              | `clang-format`, `uncrustify` | `cppcheck`                               |
| **Go**                   | `gopls`                            | `gofumpt`                    | Built-in                                 |
| **Web (JS/TS/HTML/CSS)** | `ts_ls`, `eslint`, `html`, `cssls` | `prettier` / `prettierd`     | `eslint`, `tidy`                         |
| **Infrastructure / IaC** | `terraformls`, `dockerls`          | `terraform_fmt`              | `tfsec`, `tflint`, `hadolint`            |
| **Nix**                  | `nil_ls`                           | `alejandra`                  | `deadnix`, `statix`                      |
| **Shell**                | `bashls`                           | `shfmt`                      | `shellcheck`                             |
| **Data / Config**        | `jsonls`, `yamlls`, `taplo`        | `yamlfmt`, `prettier`        | `yamllint`, `actionlint`, `ansible-lint` |

## Core Subsystems

| Subsystem             | Implementation                    | Purpose                                                                        |
| :-------------------- | :-------------------------------- | :----------------------------------------------------------------------------- |
| **Syntax & Parsing**  | `nvim-treesitter`                 | Abstract Syntax Tree-based highlighting and indentation.                       |
| **Debugging**         | `nvim-dap` + `nvim-dap-ui`        | Unified Debug Adapter Protocol for Rust, C++, Python, C#, JS/TS.               |
| **Buffer Navigation** | `harpoon` (v2), `leap.nvim`       | Context-switching, spatial movement, and marked file jumping.                  |
| **Diagnostics**       | `trouble.nvim`                    | Centralized workspace diagnostics, symbol viewing, and reference tracking.     |
| **Rust Integration**  | `rustaceanvim`, `crates.nvim`     | Full Rust IDE support, Cargo.toml management, and inline diagnostics.          |
| **Testing**           | `neotest`                         | Asynchronous test execution for Rust and Python.                               |
| **Version Control**   | `gitsigns.nvim`                   | Inline blame, hunk staging, and diff rendering.                                |
| **AI Integration**    | `codecompanion.nvim`, `minuet-ai` | Multi-provider (Claude, DeepSeek, Gemini, Ollama) inline completions and chat. |

## System Integrations

1. **Deterministic State:** NixOS native. Plugin management relies on strict declarative inputs rather than runtime package managers (Mason).
2. **Terminal Sync:** Dynamic Alacritty integration synchronizes terminal opacity, padding, and colorschemes with Neovim state.
3. **Contextual Schema Awareness:** Dynamic YAML linting transitions between `actionlint` (GitHub Actions) and `ansible-lint` based on file context.
4. **Automated State Persistence:** Aggressive auto-save triggers on `InsertLeave`, `TextChanged`, and `FocusLost`. Rust files automatically execute `flyCheck` on save.
5. **Persistent History:** Global undo tree visualization via `telescope-undo`.

## Keymaps

**Buffer & Navigation**

- `hh` / `ha` : Harpoon Quick Menu / Add to Harpoon
- `hp` / `hn` : Harpoon Navigate Previous / Next
- `s` / `S` : Leap Forward / Backward
- `<leader>u` : Undo History Tree

**LSP & Diagnostics**

- `<leader>ca` : Execute Code Action
- `<leader>lr` : Rename Symbol
- `<leader>fr` : Format Buffer (`conform.nvim`)
- `<leader>a` : Toggle Diagnostics Panel (`trouble.nvim`)
- `<leader>ss` : View Document Symbols

**Debugging (DAP)**

- `<leader>db` : Toggle Breakpoint
- `<leader>dr` : Run / Continue
- `<leader>di` : Step Into
- `<leader>do` : Step Over
- `<leader>dt` : Terminate Process

**Rust Specific**

- `<leader>rr` : Execute Runnables
- `<leader>re` : Explain Compiler Error
- `<leader>rc` : Open `Cargo.toml`
