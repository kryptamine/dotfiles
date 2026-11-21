return {
	{
		"sschleemilch/slimline.nvim",
		opts = {
			components = {
				left = { "mode", "path", "git" },
				center = {},
				-- searchcount: with cmdheight=0 ui2 has nowhere to show [x/y]
				right = { "searchcount", "diagnostics", "filetype_lsp", "progress" },
			},
			spaces = {
				components = "",
				left = "",
				right = "",
			},
			sep = {
				hide = {
					first = true,
					last = true,
				},
				left = "",
				right = "",
			},
			configs = {
				path = {
					trunc_width = 40,
					-- Full dir relative to cwd (project root), untruncated
					directory = true,
					truncate = false,
				},
			},
		},
	},
}
