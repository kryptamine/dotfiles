return {
	"brenoprata10/nvim-highlight-colors",
	-- not BufReadPost: lazy's handler runs before filetype detection, so setup()
	-- would scan the buffer before it can be recognised as "bigfile"
	event = "VeryLazy",
	config = function()
		require("nvim-highlight-colors").setup({
			render = "virtual",
			virtual_symbol = "●",
			-- scanning minified files (one huge line) freezes nvim for seconds
			exclude_filetypes = { "bigfile" },
		})
	end,
}
