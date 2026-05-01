return {
	{
		"dmtrKovalenko/fff.nvim",
		build = function()
			require("fff.download").download_or_build_binary()
		end,
		lazy = false,
		opts = {
			title = "Find Files",
			prompt = "🔎 ",
			layout = {
				width = 0.5,
				height = 0.6,
			},
			preview = {
				enabled = false,
			},
		},
		keys = {
			{
				"<leader><space>",
				function()
					require("fff").find_files()
				end,
				desc = "Open file picker",
			},
			{
				"<leader>sg",
				function()
					require("fff").live_grep()
				end,
				desc = "LiFFFe grep",
			},
		},
	},
}
