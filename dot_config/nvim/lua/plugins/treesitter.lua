return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",
		config = function()
			local parsers = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"json",
				"javascript",
				"typescript",
				"tsx",
				"python",
				"rust",
				"go",
				"toml",
				"yaml",
				"css",
				"scss",
				"html",
				"groovy",
				"terraform",
				"fish",
			}

			local ts = require("nvim-treesitter")
			local installed = ts.get_installed("parsers")
			local to_install = vim.tbl_filter(function(p)
				return not vim.tbl_contains(installed, p)
			end, parsers)
			if #to_install > 0 then
				ts.install(to_install)
			end

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf, filetype = args.buf, args.match

					local language = vim.treesitter.language.get_lang(filetype)
					if not language then
						return
					end

					-- check if parser exists and load it
					if not vim.treesitter.language.add(language) then
						return
					end
					-- enables syntax highlighting and other treesitter features
					vim.treesitter.start(buf, language)

					-- enables treesitter based indentation
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
