-- Highlights the LSP references of the symbol under the cursor and jumps
-- between them with [[ and ]].
local method = "textDocument/documentHighlight"
-- The namespace vim.lsp.buf.document_highlight() puts its extmarks in.
local ns = vim.api.nvim_create_namespace("nvim.lsp.references")
local group = vim.api.nvim_create_augroup("lsp_words", { clear = true })
local timer = assert(vim.uv.new_timer())

local function supported(buf)
	return #vim.lsp.get_clients({ bufnr = buf, method = method }) > 0
end

local function update()
	local buf = vim.api.nvim_get_current_buf()
	timer:start(
		200,
		0,
		vim.schedule_wrap(function()
			if vim.api.nvim_get_current_buf() ~= buf or not supported(buf) then
				return
			end
			vim.lsp.buf.clear_references()
			vim.lsp.buf.document_highlight()
		end)
	)
end

-- Moves `count` references forward (backward when negative), wrapping around.
local function jump(count)
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row, col = cursor[1] - 1, cursor[2]
	local refs, current = {}, nil
	for _, mark in ipairs(vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, { details = true })) do
		local end_row, end_col = mark[4].end_row, mark[4].end_col
		refs[#refs + 1] = { mark[2] + 1, mark[3] }
		local after_start = row > mark[2] or (row == mark[2] and col >= mark[3])
		local before_end = row < end_row or (row == end_row and col < end_col)
		if after_start and before_end then
			current = #refs
		end
	end
	if not current then
		return
	end

	vim.cmd.normal({ "m`", bang = true })
	vim.api.nvim_win_set_cursor(0, refs[(current - 1 + count) % #refs + 1])
	vim.cmd.normal({ "zv", bang = true })
end

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "ModeChanged" }, {
	group = group,
	callback = update,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client or not client:supports_method(method, args.buf) then
			return
		end
		vim.keymap.set("n", "]]", function()
			jump(vim.v.count1)
		end, { buffer = args.buf, desc = "Next Reference" })
		vim.keymap.set("n", "[[", function()
			jump(-vim.v.count1)
		end, { buffer = args.buf, desc = "Prev Reference" })
	end,
})
