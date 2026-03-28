local keymap = vim.keymap

keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

--  Use CTRL+<hjkl> to switch between windows
keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Better H,J,K,L
keymap.set('n', 'H', '^')
keymap.set('n', 'J', '}')
keymap.set('n', 'K', '{')
keymap.set('n', 'L', '$')

local opts = { noremap = true, silent = true }

-- save buffer
keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Save current buffer' })

-- quit
keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })

-- Better delete.
keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without yanking' })

-- Move lines up and down.
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- Ex mode gross, get it out of here
keymap.set('n', 'Q', '<nop>')
-- Same for record, I never use it and just always get trapped in it
keymap.set('n', 'q', '<nop>')

-- Paste options
keymap.set('v', 'p', '"_dP', { desc = 'Paste Without Overwriting' })

-- Change text without putting it into the vim register,
keymap.set('n', 'c', '"_c')
keymap.set('x', 'c', '"_c')

-- Open quickfixlist
keymap.set('n', '<leader>x', ':copen<CR>', opts)

-- Deleting without yanking empty line
keymap.set('n', 'dd', function()
  local is_empty_line = vim.api.nvim_get_current_line():match '^%s*$'
  if is_empty_line then
    return '"_dd'
  else
    return 'dd'
  end
end, { noremap = true, expr = true, desc = "Don't Yank Empty Line to Clipboard" })

-- Snacks
keymap.set('t', '<c-t>', function()
  Snacks.terminal.toggle()
end, { desc = 'Toggle Terminal' })

-- Open Code diff
keymap.set('n', '<leader>ff', '<cmd>CodeDiff<CR>', opts)
