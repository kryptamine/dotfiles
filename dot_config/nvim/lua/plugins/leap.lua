return {
  {
    'https://codeberg.org/andyg/leap.nvim',
    config = function()
      local leap = require 'leap'

      leap.opts.safe_labels = ''

      leap.opts.preview = function(ch0, ch1, ch2)
        return not (ch1:match '%s' or (ch0:match '%a' and ch1:match '%a' and ch2:match '%a'))
      end

      vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')

      vim.api.nvim_set_hl(0, 'LeapLabel', { fg = 'yellow', bold = true })
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
    end,
    lazy = false,
  },
}
