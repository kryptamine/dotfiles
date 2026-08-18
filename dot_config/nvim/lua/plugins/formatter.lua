local prettier_langs = {
	"css",
	"html",
	"json",
	"yaml",
	"markdown",
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
}

local options = {
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 1000,
	},

	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		c = { "clang-format" },
		go = { "gofmt" },
		rust = { "rustfmt", lsp_format = "fallback" },
		http = { "kulala-fmt" },
	},

	default_format_opts = {
		lsp_format = "fallback",
	},

	formatters = {},
}

for _, lang in ipairs(prettier_langs) do
	options.formatters_by_ft[lang] = { "prettierd" }
end

return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	opts = options,
}
