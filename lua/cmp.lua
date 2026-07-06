require("blink.cmp").setup({
	keymap = {
		preset = "enter",
		["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
	},

	appearance = {
		nerd_font_variant = "mono",
	},

	completion = {
		list = {
			selection = {
				preselect = false,
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		menu = {
			draw = {
				treesitter = { "lsp" },
			},
		},
		ghost_text = {
			enabled = true,
		},
	},

	signature = {
		enabled = true,
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	fuzzy = {
		implementation = "prefer_rust_with_warning",
	},
})
