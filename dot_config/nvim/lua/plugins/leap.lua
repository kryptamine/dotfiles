return {
	{
		"https://codeberg.org/andyg/leap.nvim",
		config = function()
			local leap = require("leap")

			leap.opts.safe_labels = ""

			leap.opts.preview = function(ch0, ch1, ch2)
				return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
			end

			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
		end,
		lazy = false,
	},
}
