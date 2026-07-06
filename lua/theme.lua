require("onedark").setup({
	style = "darker",
	colors = {
		bg0 = "#1c2028",
		bg1 = "#353b45",
		bg2 = "#3e4451",
		bg3 = "#545862",
		bg_d = "#191d25",
		fg = "#abb2bf",
		grey = "#565c64",
		red = "#e06c75",
		orange = "#d19a66",
		yellow = "#e5c07b",
		green = "#98c379",
		cyan = "#56b6c2",
		blue = "#61afef",
		purple = "#c678dd",
		light_grey = "#6f737b",
	},
	highlights = {
		-- neovim
		["Pmenu"] = { bg = "#233A33" },
		["PmenuSel"] = { bg = "#468dc7" },
		["PmenuThumb"] = { bg = "#363f4f" },
		["PmenuSbar"] = { bg = "#212630" },
		["NormalFloat"] = { bg = "#232A33" },
		["FloatBorder"] = { bg = "#232A33" },
		["FloatTitle"] = { bg = "#232A33" },
		["StatusLine"] = { bg = "#232A33", fg = "#6f737b" },
		["StatusLineNC"] = { bg = "#1e2430", fg = "#4a4e56" },
		["MsgArea"] = { fg = "#6f737b" },
		-- blink
		["BlinkCmpMenu"] = { bg = "#232A33" },
		["BlinkCmpScrollBarGutter"] = { bg = "#212630" },
		["BlinkCmpScrollBarThumb"] = { bg = "#363f4f" },
		-- fzf
		["FzfLuaNormal"] = { bg = "#232A33" },
		["FzfLuaBorder"] = { bg = "#232A33" },
		["FzfLuaPreviewNormal"] = { bg = "#232A33" },
		["FzfLuaPreviewBorder"] = { bg = "#232A33" },
		["FzfLuaTitle"] = { bg = "#232A33" },
		["FzfLuaPreviewTitle"] = { bg = "#232A33" },
		["FzfLuaScrollFloatFull"] = { bg = "#363f4f" },
	},
	code_style = {
		comments = "italic",
	},
})
require("onedark").load()
