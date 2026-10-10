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

-- Shows `buf` in a centered float and returns the window.
local function open_float(buf)
	local origin = vim.api.nvim_get_current_win()
	local win = vim.api.nvim_open_win(buf, true, float_config())
	local group = vim.api.nvim_create_augroup("float_term_" .. win, { clear = true })

	vim.api.nvim_create_autocmd("VimResized", {
		group = group,
		callback = function()
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_set_config(win, float_config())
			end
		end,
	})

	-- A file opened from inside the terminal (lazygit's nvim-remote edit preset,
	-- `nvim --remote`) lands in whatever window has focus, which is this float.
	-- Hand it over to the window we came from.
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

	vim.api.nvim_create_autocmd("WinClosed", {
		group = group,
		pattern = tostring(win),
		callback = function()
			vim.schedule(function()
				pcall(vim.api.nvim_del_augroup_by_id, group)
			end)
		end,
	})

	return win
end

-- Starts `cmd` in a new terminal buffer shown in the float. The buffer, and
-- with it the float, goes away when the command exits.
local function spawn(cmd, opts)
	opts = opts or {}
	local buf = vim.api.nvim_create_buf(false, true)
	local win = open_float(buf)
	vim.fn.jobstart(cmd, {
		term = true,
		cwd = opts.cwd,
		on_exit = function()
			if vim.api.nvim_buf_is_valid(buf) then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
			vim.cmd.checktime()
			if opts.on_exit then
				opts.on_exit()
			end
		end,
	})
	vim.cmd.startinsert()
	return buf, win
end

-- The shell terminal behind <c-t>: one long-lived buffer whose float is shown
-- and hidden, so the shell and its scrollback survive between toggles.
local shell = {}

local function toggle_shell()
	if shell.win and vim.api.nvim_win_is_valid(shell.win) then
		vim.api.nvim_win_close(shell.win, true)
		shell.win = nil
		return
	end

	if shell.buf and vim.api.nvim_buf_is_valid(shell.buf) then
		shell.win = open_float(shell.buf)
		vim.cmd.startinsert()
		return
	end

	shell.buf, shell.win = spawn(vim.o.shell, {
		on_exit = function()
			shell = {}
		end,
	})

	-- A single <esc> still reaches the shell; two in a row leave terminal mode.
	local esc_timer = assert(vim.uv.new_timer())
	vim.keymap.set("t", "<esc>", function()
		if esc_timer:is_active() then
			esc_timer:stop()
			return "<c-\\><c-n>"
		end
		esc_timer:start(200, 0, function() end)
		return "<esc>"
	end, { buffer = shell.buf, expr = true, desc = "Double escape to normal mode" })
	vim.keymap.set("n", "q", toggle_shell, { buffer = shell.buf, desc = "Hide Terminal" })
end

vim.keymap.set({ "n", "t" }, "<c-t>", toggle_shell, { desc = "Toggle Terminal" })

vim.keymap.set("n", "<leader>lg", function()
	spawn({ "lazygit" })
end, { desc = "Lazygit" })

vim.keymap.set("n", "<leader>gf", function()
	local file = vim.api.nvim_buf_get_name(0)
	spawn({ "lazygit", "-f", file }, { cwd = vim.fs.dirname(file) })
end, { desc = "Lazygit Current File History" })

vim.keymap.set("n", "<leader>gl", function()
	spawn({ "lazygit", "log" })
end, { desc = "Lazygit Log (cwd)" })
