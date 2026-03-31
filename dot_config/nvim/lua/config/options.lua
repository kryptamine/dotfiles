local options = {
  -- mostly just for cmp
  encoding = 'utf-8',
  fileencoding = 'utf-8',
  title = true,
  autoindent = true,
  smartindent = true,
  showcmd = true,
  cmdheight = 0,
  laststatus = 3,
  expandtab = true,
  ignorecase = true,
  smarttab = true,
  shiftwidth = 2,
  tabstop = 2,
  wrap = false,
  backspace = { 'start', 'eol', 'indent' },
  splitkeep = 'cursor',
  termguicolors = true,
  -- Don't show the ruler,
  ruler = false,
  -- Make line numbers default,
  number = true,
  -- You can also add relative line numbers, to help with jumping.,
  --  Experiment for yourself to see if you like it!,
  relativenumber = true,
  -- Enable mouse mode, can be useful for resizing splits for example!,
  mouse = 'a',
  -- Don't show the mode, since it's already in the status line,
  showmode = false,
  -- Sync clipboard between OS and Neovim.,
  --  Remove this option if you want your OS clipboard to remain independent.,
  --  See `:help 'clipboard'`,
  clipboard = 'unnamedplus',
  -- Enable break indent,
  breakindent = true,
  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term,
  smartcase = true,
  -- Keep signcolumn on by default,
  signcolumn = 'yes',
  -- Decrease update time,
  updatetime = 100,
  -- Configure how new splits should be opened,
  splitright = true,
  splitbelow = true,
  -- Preview substitutions live, as you type!,
  inccommand = 'split',
  -- Show which line your cursor is on,
  cursorline = true,
  cursorlineopt = 'line',
  -- Minimal number of screen lines to keep above and below the cursor.,
  scrolloff = 10,
  -- [[ Basic Keymaps ]],
  --  See `:help vim.keymap.set()`,
  -- Set highlight on search, but clear on pressing <Esc> in normal mode,
  hlsearch = true,

  foldenable = false,

  -- What to save in session.
  sessionoptions = {
    'buffers',
    'curdir',
    'resize',
    'winpos',
    'winsize',
  },

  -- Backup and Swap
  writebackup = false,
  backup = false,
  autoread = true,
  swapfile = false,
  smoothscroll = true,
  -- Save undo history,
  undofile = true,
  shell = '/opt/homebrew/bin/fish',

  fillchars = {
    eob = ' ',
  },
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.wildignore:append { '*/node_modules/*' }
vim.opt.sessionoptions:remove { 'blank', 'buffers', 'folds', 'help', 'terminal' }

vim.scriptencoding = 'utf-8'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.diagnostic.config {
  signs = false,
  underline = {
    severity = vim.diagnostic.severity.ERROR,
  },
  float = {
    border = 'single',
    source = 'if_many',
  },
}
