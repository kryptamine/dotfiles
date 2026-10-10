return {
	{
		"https://github.com/qwlp/gruber-darker.nvim",
		name = "gruber-darker",
		lazy = false,
		-- Must load before snacks.nvim (priority 1000) so the dashboard is painted
		-- with the theme already applied.
		priority = 1001,
		config = function()
			require("gruber-darker").setup({
				bold = false,
				undercurl = true,
				underline = true,
				invert = {
					signs = false,
					tabline = false,
					visual = false,
				},
				italic = {
					strings = false,
					comments = false,
					operators = false,
					folds = true,
				},
			})
			vim.api.nvim_set_hl(0, "@punctuation.delimiter.jsdoc", { fg = "#73D936" })
			vim.cmd.colorscheme("gruber-darker")

			local bgColor = "#000000"
			local labelBg = "#FFDD33"

			vim.api.nvim_set_hl(0, "FzfLuaTitle", { fg = bgColor, bg = labelBg })
			vim.api.nvim_set_hl(0, "FzfLuaPreviewTitle", { fg = bgColor, bg = labelBg })
			vim.api.nvim_set_hl(0, "FzfLuaBorder", { bg = bgColor, fg = "#323232" })
			vim.api.nvim_set_hl(0, "FzfLuaPreviewBorder", { bg = bgColor, fg = "#323232" })
			vim.api.nvim_set_hl(0, "FzfLuaNormal", { bg = bgColor })
			vim.api.nvim_set_hl(0, "FzfLuaPreviewNormal", { bg = bgColor })
			vim.api.nvim_set_hl(0, "FzfLuaDirPart", { link = "NonText" })
		end,
	},
}
