return {
	{
		"saghen/blink.cmp",
		-- CmdlineEnter: otherwise / and : use the native wildmenu until the first InsertEnter
		event = { "InsertEnter", "CmdlineEnter" },
		version = "1.*",
		opts = {
			keymap = {
				["<CR>"] = { "select_and_accept", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
			},
			cmdline = {
				keymap = {
					preset = "cmdline",
					-- fallback keeps <C-j> as Enter and <C-k> as digraph when the menu is closed
					["<C-j>"] = { "select_next", "fallback" },
					["<C-k>"] = { "select_prev", "fallback" },
					-- the cmdline menu only opens on <Tab>, so j/k navigate after <Tab>
					-- and are typed as usual otherwise
					["j"] = {
						function(cmp)
							return cmp.is_menu_visible() and cmp.select_next()
						end,
						"fallback",
					},
					["k"] = {
						function(cmp)
							return cmp.is_menu_visible() and cmp.select_prev()
						end,
						"fallback",
					},
				},
			},
			completion = {
				accept = {
					auto_brackets = {
						enabled = false,
					},
				},
				menu = {
					border = nil,
					scrolloff = 1,
					scrollbar = false,
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", "label_description" },
							{ "kind" },
						},
					},
				},
			},
		},
	},
}
