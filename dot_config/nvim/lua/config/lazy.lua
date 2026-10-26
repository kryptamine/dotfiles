-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- The full-screen backdrop float sets no border, so it picks up 'winborder'
-- and draws a frame around the whole editor.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lazy_backdrop",
	group = vim.api.nvim_create_augroup("lazy_backdrop_border", { clear = true }),
	callback = function(args)
		local win = vim.fn.bufwinid(args.buf)
		if win ~= -1 then
			vim.api.nvim_win_set_config(win, { border = "none" })
		end
	end,
})

require("lazy").setup({
	{ import = "plugins" },
}, {
	change_detection = { enabled = false },
	performance = {
		rtp = {
			-- netrw is replaced by oil.
			disabled_plugins = {
				"gzip",
				"matchit",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
