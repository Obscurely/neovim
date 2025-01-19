local present, lint = pcall(require, "lint")

if not present then
  return
end

-- Helper function to check for pyproject.toml
local function has_pyproject()
  return vim.fn.findfile("pyproject.toml", ".;") ~= ""
end

-- Helper: Check whether the current file is a GitHub Actions workflow
local function is_github_action()
  local filepath = vim.fn.expand "%:p" -- Get full path of current file
  return filepath:match "%.github/workflows/.+%.yaml$" ~= nil
end

lint.linters_by_ft = {
  python = { "ruff", "bandit" },
  c = { "cppcheck" },
  cpp = { "cppcheck" },
  markdown = { "alex", "markdownlint-cli2", "proselint" },
  sh = { "shellcheck" },
  bash = { "shellcheck" },
  nix = { "deadnix", "statix" },
  terraform = { "tfsec", "tflint" },
  hcl = { "tfsec", "tflint" },
  dockerfile = { "hadolint" },
}

-- Add conditional logic for HTML
if not has_pyproject() then
  lint.linters_by_ft.html = { "tidy" }
else
  lint.linters_by_ft.html = {}
end

-- Add conditional logic for actionlint (github actions)
if is_github_action() then
  lint.linters_by_ft.yaml = { "yamllint", "actionlint" }
else
  lint.linters_by_ft.yaml = { "yamllint" }
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
