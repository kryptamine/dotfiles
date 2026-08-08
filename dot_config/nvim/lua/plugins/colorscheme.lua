return {
	{
		"https://github.com/qwlp/gruber-darker.nvim",
		name = "gruber-darker",
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

			vim.api.nvim_set_hl(0, "SnacksPickerTitle", { fg = bgColor, bg = labelBg })
			vim.api.nvim_set_hl(0, "SnacksPickerInputTitle", { fg = bgColor, bg = labelBg })
			vim.api.nvim_set_hl(0, "SnacksPickerPreviewTitle", { fg = bgColor, bg = labelBg })
			vim.api.nvim_set_hl(0, "SnacksPickerListTitle", { fg = bgColor, bg = labelBg })
			vim.api.nvim_set_hl(0, "SnacksPickerBorder", { bg = bgColor, fg = "#323232" })
			vim.api.nvim_set_hl(0, "SnacksPicker", { bg = bgColor })
		end,
	},
}
