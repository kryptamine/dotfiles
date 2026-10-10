local header = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠴⠤⠤⠴⠄⡄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣠⠄⠒⠉⠀⠀⠀⠀⠀⠀⠀⠀⠁⠃⠆⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⡜⠁⠀⠀⠀⢠⡄⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠑⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢈⠁⠀⠀⠠⣿⠿⡟⣀⡹⠆⡿⣃⣰⣆⣤⣀⠀⠀⠹⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣼⠀⠀⢀⣀⣀⣀⣀⡈⠁⠙⠁⠘⠃⠡⠽⡵⢚⠱⠂⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⡆⠀⠀⠀⠀⢐⣢⣤⣵⡄⢀⠀⢀⢈⣉⠉⠉⠒⠤⠀⠿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠘⡇⠀⠀⠀⠀⠀⠉⠉⠁⠁⠈⠀⠸⢖⣿⣿⣷⠀⠀⢰⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⢀⠃⠀⡄⠀⠈⠉⠀⠀⠀⢴⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢈⣇⠀⠀⠀⠀⠀⠀⠀⢰⠉⠀⠀⠱⠀⠀⠀⠀⠀⢠⡄⠀⠀⠀⠀⠀⣀⠔⠒⢒⡩⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣴⣿⣤⢀⠀⠀⠀⠀⠀⠈⠓⠒⠢⠔⠀⠀⠀⠀⠀⣶⠤⠄⠒⠒⠉⠁⠀⠀⠀⢸⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⡄⠤⠒⠈⠈⣿⣿⣽⣦⠀⢀⢀⠰⢰⣀⣲⣿⡐⣤⠀⠀⢠⡾⠃⠀⠀⠀⠀⠀⠀⠀⣀⡄⣠⣵⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠘⠏⢿⣿⡁⢐⠶⠈⣰⣿⣿⣿⣿⣷⢈⣣⢰⡞⠀⠀⠀⠀⠀⠀⢀⡴⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠈⢿⣿⣍⠀⠀⠸⣿⣿⣿⣿⠃⢈⣿⡎⠁⠀⠀⠀⠀⣠⠞⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠈⢙⣿⣆⠀⠀⠈⠛⠛⢋⢰⡼⠁⠁⠀⠀⠀⢀⠔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠚⣷⣧⣷⣤⡶⠎⠛⠁⠀⠀⠀⢀⡤⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠈⠁⠀⠀⠀⠀⠀⠠⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]]

local title = [[
██╗   ██╗███████╗     ██████╗ ██████╗ ██████╗ ███████╗
██║   ██║██╔════╝    ██╔════╝██╔═══██╗██╔══██╗██╔════╝
██║   ██║███████╗    ██║     ██║   ██║██║  ██║█████╗
╚██╗ ██╔╝╚════██║    ██║     ██║   ██║██║  ██║██╔══╝
 ╚████╔╝ ███████║    ╚██████╗╚██████╔╝██████╔╝███████╗
  ╚═══╝  ╚══════╝     ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝]]

local ns = vim.api.nvim_create_namespace("dashboard")

-- Appends `block` to `lines`, centered on what is actually drawn: the art is
-- padded with blank braille cells, which would otherwise count towards its
-- width and push the picture off to one side.
local function append_centered(lines, block, width)
	local rows, left, right = {}, math.huge, 0
	for _, row in ipairs(vim.split(block, "\n")) do
		local cells = vim.fn.split(row, [[\zs]])
		for i, cell in ipairs(cells) do
			if cell ~= " " and cell ~= "\u{2800}" then
				left = math.min(left, i)
				right = math.max(right, i)
			end
		end
		rows[#rows + 1] = cells
	end
	local pad = string.rep(" ", math.max(0, math.floor((width - (right - left + 1)) / 2)))
	for _, cells in ipairs(rows) do
		lines[#lines + 1] = pad .. table.concat(cells, "", math.min(left, #cells + 1), math.min(right, #cells))
	end
end

local function render(buf, win)
	local width = vim.api.nvim_win_get_width(win)
	local height = vim.api.nvim_win_get_height(win)

	local content = {}
	append_centered(content, header, width)
	content[#content + 1] = ""
	append_centered(content, title, width)

	local lines = {}
	for _ = 1, math.max(0, math.floor((height - #content) / 2)) do
		lines[#lines + 1] = ""
	end
	local first_row = #lines
	vim.list_extend(lines, content)

	vim.bo[buf].modifiable = true
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false

	vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
	vim.api.nvim_buf_set_extmark(buf, ns, first_row, 0, { end_row = #lines, hl_group = "Title" })
end

local function open()
	local buf = vim.api.nvim_get_current_buf()
	local win = vim.api.nvim_get_current_win()
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].buflisted = false
	vim.bo[buf].swapfile = false
	vim.bo[buf].filetype = "dashboard"
	-- Scoped to this buffer in this window, so the next buffer shown here gets
	-- the regular options back.
	for name, value in pairs({
		number = false,
		relativenumber = false,
		signcolumn = "no",
		cursorline = false,
		list = false,
		statuscolumn = "",
	}) do
		vim.wo[win][0][name] = value
	end

	-- No statusline while the dashboard is up; the buffer wipes itself as soon
	-- as anything else is shown in its window.
	local laststatus = vim.o.laststatus
	vim.o.laststatus = 0
	vim.api.nvim_create_autocmd("BufWipeout", {
		buffer = buf,
		once = true,
		callback = function()
			vim.o.laststatus = laststatus
		end,
	})

	render(buf, win)

	vim.api.nvim_create_autocmd({ "VimResized", "WinResized" }, {
		group = vim.api.nvim_create_augroup("dashboard_resize", { clear = true }),
		callback = function()
			if not vim.api.nvim_buf_is_valid(buf) then
				return true
			end
			local shown = vim.fn.bufwinid(buf)
			if shown ~= -1 then
				render(buf, shown)
			end
		end,
	})

	vim.keymap.set("n", "s", function()
		require("persistence").load()
	end, { buffer = buf, nowait = true, desc = "Restore Session" })
end

vim.api.nvim_create_autocmd("StdinReadPre", {
	group = vim.api.nvim_create_augroup("dashboard_stdin", { clear = true }),
	callback = function()
		vim.g.dashboard_stdin = true
	end,
})

-- Only for a bare `nvim`: no file arguments, nothing piped in, and nothing
-- already loaded into the first buffer.
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("dashboard", { clear = true }),
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		if
			vim.fn.argc(-1) == 0
			and not vim.g.dashboard_stdin
			and vim.api.nvim_buf_get_name(buf) == ""
			and vim.bo[buf].filetype == ""
			and not vim.bo[buf].modified
			and vim.api.nvim_buf_line_count(buf) == 1
			and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ""
		then
			open()
		end
	end,
})
