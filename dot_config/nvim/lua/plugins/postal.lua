-- Postal's plugin as `make install` put it, else the local checkout.
-- Loaded at start: its autocmd must exist before a Draft opens.
local installed = vim.fn.expand("~/.local/share/postal/nvim")
local dir = vim.fn.isdirectory(installed) == 1 and installed or vim.fn.expand("~/Work/postal/nvim")

return {
	{
		dir = dir,
		name = "postal",
		cond = vim.fn.isdirectory(dir) == 1,
		lazy = false,
		config = function()
			require("postal").setup()
		end,
	},
}
