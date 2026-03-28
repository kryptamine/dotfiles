return {
  {
    'supermaven-inc/supermaven-nvim',
    event = { 'InsertEnter' },
    config = function()
      require('supermaven-nvim').setup {
        ignore_filetypes = { 'oil', 'fff_input' },
        keymaps = {
          accept_suggestion = '<c-a>',
        },
        log_level = 'off',
      }
    end,
  },
}
