return {
  {
    'stevearc/oil.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local oil = require 'oil'
      oil.setup {
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
        columns = { 'icon' },
        keymaps = {
          ['<Esc><Esc>'] = 'actions.close',
          ['q'] = 'actions.close',
          ['<C-v>'] = 'actions.select_vsplit',
          ['<C-s>'] = false,
        },
        view_options = {
          show_hidden = true,
          natural_order = true,
          is_always_hidden = function(name, _)
            return name == '..' or name == '.git' or name == '.DS_Store'
          end,
        },
        float = {
          -- Padding around the floating window
          padding = 10,
          max_width = 80,
          max_height = 0,
          border = 'single',
          win_options = {
            wrap = true,
            winblend = 0,
          },
        },
        confirmation = {
          border = 'single',
        },
        lsp_file_methods = {
          -- Time to wait for LSP file operations to complete before skipping
          timeout_ms = 5000,
          -- Set to true to autosave buffers that are updated with LSP willRenameFiles
          -- Set to "unmodified" to only save unmodified buffers
          autosave_changes = true,
        },
      }

      -- Open parent directory in current window
      vim.keymap.set('n', '-', require('oil').toggle_float, { desc = 'Open oil' })
    end,
  },
}
