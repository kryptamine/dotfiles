return {
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("<leader>b", vim.lsp.buf.hover, "Display variable type")
				end,
			})

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
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
				"html",
				"cssls",
				"gopls",
				"black",
				"isort",
				"prettierd",
				"intelephense",
				"terraformls",
				"tflint",
				"cssmodules-language-server",
				"rust_analyzer",
			})

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for server_name, config in pairs(servers) do
				vim.lsp.config(server_name, config)
			end

			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
				automatic_enable = true,
			})
		end,
	},
}
