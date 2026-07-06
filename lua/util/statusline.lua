-- lua/util/statusline.lua
local M = {}

function M.mode()
	local modes = {
		n = "NORMAL",
		i = "INSERT",
		v = "VISUAL",
		V = "V-LINE",
		["\22"] = "V-BLOCK",
		c = "COMMAND",
		R = "REPLACE",
		t = "TERMINAL",
		s = "SELECT",
		S = "S-LINE",
	}
	return modes[vim.fn.mode()] or vim.fn.mode():upper()
end

function M.git_branch()
	local head = vim.b.gitsigns_head
	if not head or head == "" then
		return ""
	end
	return " │  " .. head
end

function M.git_diff()
	local status = vim.b.gitsigns_status_dict
	if not status then
		return ""
	end
	local parts = {}
	if (status.added or 0) > 0 then
		table.insert(parts, "+" .. status.added)
	end
	if (status.changed or 0) > 0 then
		table.insert(parts, "~" .. status.changed)
	end
	if (status.removed or 0) > 0 then
		table.insert(parts, "-" .. status.removed)
	end
	if #parts == 0 then
		return ""
	end
	return " " .. table.concat(parts, " ")
end

function M.diagnostics()
	local d = vim.diagnostic.count(0)
	local parts = {}
	if (d[vim.diagnostic.severity.ERROR] or 0) > 0 then
		table.insert(parts, ":" .. d[vim.diagnostic.severity.ERROR])
	end
	if (d[vim.diagnostic.severity.WARN] or 0) > 0 then
		table.insert(parts, ":" .. d[vim.diagnostic.severity.WARN])
	end
	if (d[vim.diagnostic.severity.INFO] or 0) > 0 then
		table.insert(parts, ":" .. d[vim.diagnostic.severity.INFO])
	end
	if (d[vim.diagnostic.severity.HINT] or 0) > 0 then
		table.insert(parts, ":" .. d[vim.diagnostic.severity.HINT])
	end
	if #parts == 0 then
		return ""
	end
	return table.concat(parts, " ") .. " │"
end

function M.lsp()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return ""
	end
	return clients[1].name .. " │"
end

function M.project()
	local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	return cwd
end

function M.progress()
	local status = vim.lsp.status()
	if not status or status == "" then
		return ""
	end
	return status
end

return M
