return {
	{
		"ibhagwan/fzf-lua",
		cmd = "FzfLua",
		opts = {
			-- Mirrors the Snacks picker "default" layout these mappings used to
			-- open: 80% float, prompt on top, preview on the right half, and a
			-- stacked layout once the editor is narrower than 120 columns.
			winopts = {
				width = 0.8,
				height = 0.8,
				row = 0.5,
				col = 0.5,
				border = "rounded",
				title_pos = "center",
				preview = {
					border = "rounded",
					layout = "flex",
					-- Compared against the picker width, not the editor's: 95 is
					-- 80% of 120 columns.
					flip_columns = 95,
					horizontal = "right:50%",
					vertical = "down:40%",
					title_pos = "center",
					scrollbar = false,
				},
			},
			fzf_opts = {
				["--layout"] = "reverse",
				-- Match count at the end of the prompt line with a rule under it,
				-- like the Snacks input window.
				["--info"] = "inline-right",
				["--input-border"] = "bottom",
			},
			fzf_colors = {
				true,
				["input-border"] = { "fg", "FzfLuaBorder" },
				["separator"] = { "fg", "FzfLuaBorder" },
			},
			defaults = {
				file_icons = "mini",
			},
			keymap = {
				builtin = {
					true,
					["<C-f>"] = "preview-page-down",
					["<C-b>"] = "preview-page-up",
				},
				fzf = {
					true,
					["ctrl-d"] = "half-page-down",
					["ctrl-u"] = "half-page-up",
					["ctrl-q"] = "select-all+accept",
				},
			},
			grep = {
				hidden = true,
				-- The stock flags plus a .git exclude, which `hidden` otherwise
				-- drags into the results.
				rg_opts = "--column --line-number --no-heading --color=always --smart-case "
					.. "--max-columns=4096 -g '!.git' -e",
			},
			lsp = {
				jump1 = true,
				ignore_current_line = true,
			},
		},
		keys = {
			{
				"<leader>sb",
				function()
					require("fzf-lua").buffers()
				end,
				desc = "Open Buffers",
			},
			-- LSP
			{
				"gd",
				function()
					require("fzf-lua").lsp_definitions()
				end,
				desc = "Goto Definition",
			},
			{
				"gD",
				function()
					require("fzf-lua").lsp_declarations()
				end,
				desc = "Goto Declaration",
			},
			{
				"gr",
				function()
					require("fzf-lua").lsp_references()
				end,
				nowait = true,
				desc = "References",
			},
			{
				"gI",
				function()
					require("fzf-lua").lsp_implementations()
				end,
				desc = "Goto Implementation",
			},
			{
				"gy",
				function()
					require("fzf-lua").lsp_typedefs()
				end,
				desc = "Goto T[y]pe Definition",
			},
			{
				"<leader>ss",
				function()
					require("fzf-lua").lsp_document_symbols()
				end,
				desc = "LSP Symbols",
			},
			{
				"<leader>sS",
				function()
					require("fzf-lua").lsp_live_workspace_symbols()
				end,
				desc = "LSP Workspace Symbols",
			},
			{
				"<leader>sw",
				function()
					require("fzf-lua").grep_cword()
				end,
				desc = "Visual selection or word",
			},
			{
				"<leader>sw",
				function()
					require("fzf-lua").grep_visual()
				end,
				desc = "Visual selection or word",
				mode = "x",
			},
			{
				"<leader>sr",
				function()
					require("fzf-lua").resume()
				end,
				desc = "Resume",
			},
			-- git
			{
				"<leader>gs",
				function()
					require("fzf-lua").git_status()
				end,
				desc = "Git Status",
			},
		},
	},
}
