local lint = require("lint")

lint.linters_by_ft = {
	python = { "ruff", "bandit" },
	c = { "cppcheck" },
	cpp = { "cppcheck" },
	markdown = { "markdownlint-cli2" },
	sh = { "shellcheck" },
	bash = { "shellcheck" },
	nix = { "deadnix", "statix" },
	terraform = { "tfsec", "tflint" },
	hcl = { "tfsec", "tflint" },
	dockerfile = { "hadolint" },
	html = { "tidy" },
	yaml = { "yamllint" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	callback = function()
		if vim.fn.expand("%:t") == ".notes.md" then
			return
		end -- don't enable on no neck pain notes

		local filepath = vim.fn.expand("%:p")

		-- Add actionlint for GitHub Actions workflows
		if filepath:match("%.github/workflows/.+%.ya?ml$") then
			lint.try_lint({ "actionlint" })
		end

		-- Add ansible-lint for Ansible files
		if
			filepath:match("/playbooks/")
			or filepath:match("/tasks/")
			or filepath:match("/roles/")
			or filepath:match("/handlers/")
		then
			lint.try_lint({ "ansible_lint" })
		end

		lint.try_lint()
	end,
})
