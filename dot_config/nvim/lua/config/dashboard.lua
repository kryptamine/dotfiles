local logo = [[
     ▄█               ▄█
   ▄████▄           ▄███
▄▄███████▄        ▄█████
███████████       ██████
████████████▄     ██████
██████▀██████▄    ██████
██████ ▀███████   ██████
██████   ███████▄ ██████
██████    ▀██████▄██████
██████     ▀████████████
██████       ███████████
▀█████        ▀█████████
   ▀██         ▀████▀███
     ▀           █▀   ▀█]]

-- One letter per cell of `logo`, naming the part of the mark it belongs to:
-- (l)eft bar, (d)iagonal, (r)ight bar.
local logo_mask = [[
.....dd...............rr
...dddddd...........rrrr
lldddddddd........rrrrrr
llldddddddd.......rrrrrr
llllldddddddd.....rrrrrr
lllllldddddddd....rrrrrr
llllll.dddddddd...rrrrrr
llllll...dddddddd.rrrrrr
llllll....ddddddddrrrrrr
llllll.....ddddddddrrrrr
llllll.......ddddddddrrr
llllll........ddddddddrr
...lll.........ddddddrrr
.....l...........dd...rr]]

local wordmark = [[
╭╮╷╭─╴╭─╮╷ ╷╷╭┬╮
│╰┤├╴ │ ││╭╯││││
╵ ╵╰─╴╰─╯╰╯ ╵╵ ╵]]

local wordmark_mask = [[
rrrrrrrrrlllllll
rrrrrrrrrlllllll
rrrrrrrrrlllllll]]

-- The official mark's blue / light green / green, mapped onto the
-- gruber-darker-renaissance palette: niagara, green, green_muted.
local part_hl = {
	l = "DashboardLogoBlue",
	d = "DashboardLogoLightGreen",
	r = "DashboardLogoGreen",
}
local part_fg = {
	DashboardLogoBlue = "#9fb2d6",
	DashboardLogoLightGreen = "#8ac568",
	DashboardLogoGreen = "#476834",
}

local ns = vim.api.nvim_create_namespace("dashboard")

-- The most recent file under cwd, or nil
local function last_file()
	local cwd = vim.fn.getcwd() .. "/"
	for _, file in ipairs(vim.v.oldfiles) do
		if vim.startswith(file, cwd) and vim.fn.filereadable(file) == 1 then
			return file
		end
	end
end

-- What the dashboard offers, as { key, label, action }. "restore" opens the
-- last file; its cursor position comes back from the last-position autocmd.
local function menu_items()
	local items = {}
	local file = last_file()
	if file then
		items[#items + 1] = {
			key = "s",
			label = "restore",
			action = function()
				vim.cmd.edit(vim.fn.fnameescape(file))
			end,
		}
	end
	vim.list_extend(items, {
		{
			key = "f",
			label = "find",
			action = function()
				require("fff").find_files()
			end,
		},
		{
			key = "g",
			label = "grep",
			action = function()
				require("fff").live_grep()
			end,
		},
		{ key = "q", label = "quit", action = "<Cmd>qa<CR>" },
	})
	return items
end

-- Appends the menu to `lines` as one dimmed, centered row of "key label"
-- hints with the keys highlighted.
local function append_menu(lines, items, width, marks)
	local parts = {}
	for _, item in ipairs(items) do
		parts[#parts + 1] = item.key .. " " .. item.label
	end
	local row = table.concat(parts, "   ")
	local pad = string.rep(" ", math.max(0, math.floor((width - vim.fn.strdisplaywidth(row)) / 2)))
	lines[#lines + 1] = pad .. row
	local r, col = #lines - 1, #pad
	for _, part in ipairs(parts) do
		marks[#marks + 1] = { r, col, col + 1, "DashboardKey" }
		marks[#marks + 1] = { r, col + 1, col + #part, "Comment" }
		col = col + #part + 3
	end
end

-- Appends `block` to `lines`, centered on what is actually drawn: blank
-- padding around the art would otherwise count towards its width and push
-- the picture off to one side. With a `mask`, also collects into `marks` the
-- highlight of every drawn cell, as { row, col, end_col, hl_group }.
local function append_centered(lines, block, width, mask, marks)
	local rows, left, right = {}, math.huge, 0
	for _, row in ipairs(vim.split(block, "\n")) do
		local cells = vim.fn.split(row, [[\zs]])
		for i, cell in ipairs(cells) do
			if cell ~= " " then
				left = math.min(left, i)
				right = math.max(right, i)
			end
		end
		rows[#rows + 1] = cells
	end
	local pad = string.rep(" ", math.max(0, math.floor((width - (right - left + 1)) / 2)))
	local mask_rows = mask and vim.split(mask, "\n")
	for r, cells in ipairs(rows) do
		lines[#lines + 1] = pad .. table.concat(cells, "", math.min(left, #cells + 1), math.min(right, #cells))
		local col = #pad
		for i = left, mask_rows and #cells or 0 do
			local hl = part_hl[mask_rows[r]:sub(i, i)]
			if hl then
				marks[#marks + 1] = { #lines - 1, col, col + #cells[i], hl }
			end
			col = col + #cells[i]
		end
	end
end

local function render(buf, win, items)
	local width = vim.api.nvim_win_get_width(win)
	local height = vim.api.nvim_win_get_height(win)

	local content, marks = {}, {}
	append_centered(content, logo, width, logo_mask, marks)
	content[#content + 1] = ""
	append_centered(content, wordmark, width, wordmark_mask, marks)
	content[#content + 1] = ""
	append_menu(content, items, width, marks)
	content[#content + 1] = ""
	local caption_row = #content
	local v = vim.version()
	local caption = { ("v%d.%d.%d"):format(v.major, v.minor, v.patch) }
	-- lazy.nvim measures startup on UIEnter, after the dashboard is first drawn
	local ms = require("lazy").stats().startuptime
	if ms > 0 then
		caption[#caption + 1] = ("%.0f ms"):format(ms)
	end
	append_centered(content, table.concat(caption, "  ·  "), width)

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
	for _, mark in ipairs(marks) do
		local row, col, end_col, hl = unpack(mark)
		vim.api.nvim_buf_set_extmark(buf, ns, first_row + row, col, { end_col = end_col, hl_group = hl })
	end
	vim.api.nvim_buf_set_extmark(buf, ns, first_row + caption_row, 0, { end_row = #lines, hl_group = "Comment" })
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

	for name, fg in pairs(part_fg) do
		vim.api.nvim_set_hl(0, name, { fg = fg })
	end
	vim.api.nvim_set_hl(0, "DashboardKey", { fg = part_fg.DashboardLogoLightGreen })
	local items = menu_items()
	render(buf, win, items)
	vim.api.nvim_create_autocmd("User", {
		pattern = "LazyVimStarted",
		once = true,
		callback = function()
			local shown = vim.api.nvim_buf_is_valid(buf) and vim.fn.bufwinid(buf) or -1
			if shown ~= -1 then
				render(buf, shown, items)
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "VimResized", "WinResized" }, {
		group = vim.api.nvim_create_augroup("dashboard_resize", { clear = true }),
		callback = function()
			if not vim.api.nvim_buf_is_valid(buf) then
				return true
			end
			local shown = vim.fn.bufwinid(buf)
			if shown ~= -1 then
				render(buf, shown, items)
			end
		end,
	})

	for _, item in ipairs(items) do
		vim.keymap.set("n", item.key, item.action, { buffer = buf, nowait = true, desc = item.label })
	end
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
