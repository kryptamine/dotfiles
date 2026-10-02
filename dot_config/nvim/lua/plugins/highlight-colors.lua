local filetypes = {
	"css",
	"scss",
	"sass",
	"less",
	"html",
	"javascriptreact",
	"typescriptreact",
	"lua",
}

return {
	"brenoprata10/nvim-highlight-colors",
	-- the plugin rescans the buffer on every TextChanged, so only load it where
	-- colors actually appear; "bigfile" never matches, which keeps minified files out
	ft = filetypes,
	config = function()
		require("nvim-highlight-colors").setup({
			render = "virtual",
			virtual_symbol = "●",
			-- once loaded, its autocmds are global: skip buffers of other filetypes
			exclude_buffer = function(buf)
				return not vim.tbl_contains(filetypes, vim.bo[buf].filetype)
			end,
		})
	end,
}
