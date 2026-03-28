return {
  {
    'https://github.com/qwlp/gruber-darker.nvim',
    name = 'gruber-darker',
    config = function()
      require('gruber-darker').setup {
        bold = false,
        undercurl = true,
        underline = true,
        invert = {
          signs = false,
          tabline = false,
          visual = false,
        },
        italic = {
          strings = false,
          comments = false,
          operators = false,
          folds = true,
        },
      }
      vim.api.nvim_set_hl(0, '@punctuation.delimiter.jsdoc', { fg = '#73D936' })
      vim.cmd.colorscheme 'gruber-darker'

      local bgColor = '#000000'
      local labelBg = '#FFDD33'

      vim.api.nvim_set_hl(0, 'SnacksPickerTitle', { fg = bgColor, bg = labelBg })
      vim.api.nvim_set_hl(0, 'SnacksPickerInputTitle', { fg = bgColor, bg = labelBg })
      vim.api.nvim_set_hl(0, 'SnacksPickerPreviewTitle', { fg = bgColor, bg = labelBg })
      vim.api.nvim_set_hl(0, 'SnacksPickerListTitle', { fg = bgColor, bg = labelBg })
      vim.api.nvim_set_hl(0, 'SnacksPickerBorder', { bg = bgColor, fg = '#323232' })
      vim.api.nvim_set_hl(0, 'SnacksPicker', { bg = bgColor })
    end,
  },
  -- {
  --   'sainnhe/gruvbox-material',
  --   priority = 1000,
  --   config = function()
  --     vim.g.gruvbox_material_foreground = 'mix'
  --     vim.g.gruvbox_material_background = 'hard'
  --     vim.g.gruvbox_material_ui_contrast = 'high'
  --     vim.g.gruvbox_material_float_style = 'blend'
  --     vim.g.gruvbox_material_statusline_style = 'mix'
  --     vim.g.gruvbox_material_cursor = 'auto'
  --     vim.g.gruvbox_material_visual = 'blue background'
  --     vim.g.gruvbox_material_transparent_background = 1
  --
  --     vim.cmd.colorscheme 'gruvbox-material'
  --
  --     -- Color palette
  --     local bg = '#101114'
  --     local surface = '#252529'
  --     local border = '#303034'
  --
  --     -- Editor backgrounds
  --     local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })
  --     vim.api.nvim_set_hl(0, 'Normal', { fg = normal_hl.fg, bg = bg })
  --     vim.api.nvim_set_hl(0, 'NormalFloat', { bg = bg })
  --     vim.api.nvim_set_hl(0, 'NormalNC', { bg = bg })
  --     vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = bg })
  --     vim.api.nvim_set_hl(0, 'SignColumn', { bg = bg })
  --
  --     -- Window separators
  --     vim.api.nvim_set_hl(0, 'VertSplit', { fg = border, bg = bg })
  --     vim.api.nvim_set_hl(0, 'WinSeparator', { fg = border, bg = bg })
  --
  --     -- Popup menu
  --     vim.api.nvim_set_hl(0, 'Pmenu', { bg = bg })
  --     vim.api.nvim_set_hl(0, 'PmenuSel', { bg = surface })
  --     vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = border })
  --
  --     -- Floating window borders
  --     vim.api.nvim_set_hl(0, 'FloatBorder', { fg = border, bg = bg })
  --     vim.api.nvim_set_hl(0, 'SnacksPickerBorder', { fg = border, bg = bg })
  --
  --     -- Blink.cmp completion borders
  --     vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { fg = border, bg = bg })
  --     vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { fg = border, bg = bg })
  --     vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelpBorder', { fg = border, bg = bg })
  --
  --     -- Markdown in completion docs
  --     vim.api.nvim_set_hl(0, 'markdownRule', { fg = border })
  --     vim.api.nvim_set_hl(0, 'markdownH1Delimiter', { fg = border })
  --     vim.api.nvim_set_hl(0, 'markdownH2Delimiter', { fg = border })
  --     vim.api.nvim_set_hl(0, 'BlinkCmpDocSeparator', { fg = border })
  --
  --     -- Misc highlights
  --     vim.api.nvim_set_hl(0, '@attribute.typescript', { fg = '#b0b846' })
  --   end,
  -- },
}
