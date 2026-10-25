return {
	{
		"kryptamine/gruber-darker-renaissance",
		lazy = false,
		priority = 1000,
		config = function()
			local opts = {
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
				on_highlights = function(hl, c)
					hl["@punctuation.delimiter.jsdoc"] = { fg = c.green }
				end,
			}

			require("gruber-darker-renaissance").setup(opts)
			vim.cmd.colorscheme("gruber-darker-renaissance")

			-- Reload the theme from disk while developing it
			vim.api.nvim_create_user_command("ThemeReload", function()
				for name in pairs(package.loaded) do
					if name:match("^gruber%-darker%-renaissance") then
						package.loaded[name] = nil
					end
				end
				require("gruber-darker-renaissance").setup(opts)
				vim.cmd.colorscheme("gruber-darker-renaissance")
			end, { desc = "Reload gruber-darker-renaissance colorscheme" })
		end,
	},
}
