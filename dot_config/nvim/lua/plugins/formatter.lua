local prettier_langs = {
  'javascript',
  'typescript',
  'javascriptreact',
  'typescriptreact',
  'css',
  'html',
  'json',
  'yaml',
  'markdown',
}

local options = {
  format_on_save = {
    lsp_format = 'fallback',
    timeout_ms = 5000,
  },

  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'black', 'ruff' },
    c = { 'clang-format' },
    go = { 'gofmt' },
    rust = { 'rustfmt', lsp_format = 'fallback' },
  },

  default_format_opts = {
    lsp_format = 'fallback',
  },

  formatters = {},
}

for _, lang in ipairs(prettier_langs) do
  options.formatters_by_ft[lang] = { 'prettierd' }
end

options.formatters_by_ft.javascript = { 'prettierd', 'eslint_d' }

return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  lazy = false,
  opts = options,
}
