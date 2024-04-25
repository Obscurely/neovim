local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  -- go
  b.formatting.gofmt,

  -- python
  b.diagnostics.ruff,
  b.formatting.ruff.with {
    args = { "format", "-q", "-n", "-" },
  },

  -- cpp & c_sharp & java
  b.formatting.uncrustify,

  -- cpp
  b.diagnostics.cppcheck,

  -- rust
  b.formatting.rustfmt.with {
    extra_args = { "--edition=2021" },
  },

  -- webdev stuff
  b.formatting.deno_fmt,
  b.formatting.prettierd,
  b.diagnostics.tidy.with {
    condition = function(utils)
      return not utils.root_has_file("pyproject.toml")
    end,
  },

  -- markdown
  b.diagnostics.alex,
  b.diagnostics.mdl,
  b.diagnostics.proselint,

  -- toml
  b.formatting.taplo,

  -- go
  b.formatting.gofumpt,

  -- Lua
  b.formatting.stylua,

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  -- nix
  b.formatting.alejandra,
  b.code_actions.statix,
  b.diagnostics.deadnix,

  -- yaml
  b.diagnostics.yamllint,
  b.diagnostics.actionlint, -- github actions linter
  b.formatting.yamlfmt.with {
    extra_args = { "--formatter", "include_document_start=true" },
  },
}

null_ls.setup {
  -- debug = true,
  sources = sources,
}
