local servers = {
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				completion = {
					callSnippet = "Replace",
				},
			},
		},
	},
	clangd = {
		cmd = { "clangd", "--background-index" },
		single_file_support = true,
	},
	tsc = {
		cmd = function(dispatchers, config)
			local cmd = "tsc"
			local root_dir = (config or {}).root_dir
			if root_dir then
				local local_tsgo = vim.fs.joinpath(root_dir, "node_modules/.bin/tsgo")
				if vim.fn.executable(local_tsgo) == 1 then
					cmd = local_tsgo
				end
			end
			return vim.lsp.rpc.start({ cmd, "--lsp", "--stdio" }, dispatchers)
		end,
	},
	html = {},
	cssls = {},
	cssmodules_ls = {},
	eslint = {},
	gopls = {},
	ruff = {},
	intelephense = {},
	terraformls = {},
	tflint = {},
	rust_analyzer = {},
	stylua = {},
}

-- Non-LSP tools mason installs alongside the servers.
local tools = { "prettierd" }

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("<leader>b", function()
						vim.lsp.buf.hover({ silent = true })
					end, "Display variable type")
				end,
			})

			for server_name, config in pairs(servers) do
				vim.lsp.config(server_name, config)
			end
			vim.lsp.enable(vim.tbl_keys(servers))
		end,
	},
	-- Servers run from mason's bin dir, which options.lua puts on PATH, so mason
	-- itself only loads to install or update them.
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		cmd = { "MasonToolsInstall", "MasonToolsInstallSync", "MasonToolsUpdate", "MasonToolsClean" },
		dependencies = {
			{ "mason-org/mason.nvim", cmd = "Mason", opts = {} },
			-- Translates the lspconfig names in ensure_installed to mason packages.
			{ "mason-org/mason-lspconfig.nvim", opts = { automatic_enable = false } },
		},
		opts = {
			ensure_installed = vim.list_extend(vim.tbl_keys(servers), tools),
			run_on_start = false,
		},
	},
}
