local function float_config()
	local width = math.floor(vim.o.columns * 0.9)
	local height = math.floor(vim.o.lines * 0.9)
	return {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2) - 1,
		col = math.floor((vim.o.columns - width) / 2) - 1,
		style = "minimal",
		border = "single",
	}
end

-- Runs `cmd` in a floating terminal that goes away when the command exits.
local function run(cmd, opts)
	local origin = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, float_config())
	local group = vim.api.nvim_create_augroup("float_term_" .. buf, { clear = true })

	vim.api.nvim_create_autocmd("VimResized", {
		group = group,
		callback = function()
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_set_config(win, float_config())
			end
		end,
	})

	-- lazygit's nvim-remote edit preset opens the file in whatever window has
	-- focus, which is this float. Hand the file over to the window we came from.
	vim.api.nvim_create_autocmd("BufWinEnter", {
		group = group,
		callback = function(args)
			if args.buf == buf or vim.api.nvim_get_current_win() ~= win then
				return
			end
			vim.schedule(function()
				if vim.api.nvim_win_is_valid(win) then
					vim.api.nvim_win_close(win, true)
				end
				if vim.api.nvim_win_is_valid(origin) then
					vim.api.nvim_set_current_win(origin)
				end
				vim.api.nvim_set_current_buf(args.buf)
			end)
		end,
	})

	vim.fn.jobstart(cmd, {
		term = true,
		cwd = opts and opts.cwd,
		on_exit = function()
			vim.api.nvim_del_augroup_by_id(group)
			if vim.api.nvim_buf_is_valid(buf) then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
			vim.cmd.checktime()
		end,
	})
	vim.cmd.startinsert()
end

vim.keymap.set("n", "<leader>lg", function()
	run({ "lazygit" })
end, { desc = "Lazygit" })

vim.keymap.set("n", "<leader>gf", function()
	local file = vim.api.nvim_buf_get_name(0)
	run({ "lazygit", "-f", file }, { cwd = vim.fs.dirname(file) })
end, { desc = "Lazygit Current File History" })

vim.keymap.set("n", "<leader>gl", function()
	run({ "lazygit", "log" })
end, { desc = "Lazygit Log (cwd)" })
