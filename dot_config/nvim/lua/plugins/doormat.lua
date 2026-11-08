return {
	-- Opens on VimEnter, so it has to load at startup
	{
		"kryptamine/doormat.nvim",
		lazy = false,
		opts = {
			items = {
				"restore",
				{
					key = "f",
					label = "find",
					action = function()
						require("fff").find_files()
					end,
				},
				{
					key = "g",
					label = "grep",
					action = function()
						require("fff").live_grep()
					end,
				},
				"quit",
			},
		},
	},
}
