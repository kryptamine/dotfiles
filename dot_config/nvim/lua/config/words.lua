-- Highlights the LSP references of the symbol under the cursor.
local method = "textDocument/documentHighlight"
-- The namespace vim.lsp.buf.document_highlight() puts its extmarks in.
local ns = vim.api.nvim_create_namespace("nvim.lsp.references")
local group = vim.api.nvim_create_augroup("lsp_words", { clear = true })
local timer = assert(vim.uv.new_timer())

local function supported(buf)
	return #vim.lsp.get_clients({ bufnr = buf, method = method }) > 0
end

-- Whether the cursor is on one of the highlighted references.
local function on_reference()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row, col = cursor[1] - 1, cursor[2]
	for _, mark in ipairs(vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, { details = true })) do
		local end_row, end_col = mark[4].end_row, mark[4].end_col
		local after_start = row > mark[2] or (row == mark[2] and col >= mark[3])
		local before_end = row < end_row or (row == end_row and col < end_col)
		if after_start and before_end then
			return true
		end
	end
	return false
end

-- The buffer and changedtick the current highlights were requested for.
local shown = {}

local function update()
	local buf = vim.api.nvim_get_current_buf()
	timer:start(
		200,
		0,
		vim.schedule_wrap(function()
			if vim.api.nvim_get_current_buf() ~= buf or not supported(buf) then
				return
			end
			-- Still on one of the highlighted references of an unchanged buffer:
			-- the highlights are already right, and redoing them would flicker.
			local tick = vim.api.nvim_buf_get_changedtick(buf)
			if shown.buf == buf and shown.tick == tick and on_reference() then
				return
			end
			shown = { buf = buf, tick = tick }
			vim.lsp.buf.clear_references()
			vim.lsp.buf.document_highlight()
		end)
	)
end

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "ModeChanged" }, {
	group = group,
	callback = update,
})
