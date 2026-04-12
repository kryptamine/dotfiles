return {
	{
		"mason-org/mason-lspconfig.nvim",
		event = "BufReadPre",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({})

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
				vtsls = {
					-- explicitly add default filetypes, so that we can extend
					-- them in related extras
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					settings = {
						complete_function_calls = false,
						vtsls = {
							enableMoveToFileCodeAction = true,
							autoUseWorkspaceTsdk = true,
							experimental = {
								maxInlayHintLength = 30,
								completion = {
									enableServerSideFuzzyMatch = true,
								},
							},
						},
						typescript = {
							tsserver = {
								maxTsServerMemory = 15000,
							},
							updateImportsOnFileMove = { enabled = "always" },
							suggest = {
								completeFunctionCalls = false,
							},
							inlayHints = {
								enumMemberValues = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								variableTypes = { enabled = false },
							},
							preferences = {
								importModuleSpecifier = "non-relative", -- Enable named imports
								importModuleSpecifierEnding = "auto", -- Optional, auto appends `.js` for JS/TS files
							},
						},
					},
				},
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
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"lua_ls",
				"stylua",
				"html",
				"cssls",
				"eslint_d",
				"gopls",
				"black",
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
		end,
	},
}
