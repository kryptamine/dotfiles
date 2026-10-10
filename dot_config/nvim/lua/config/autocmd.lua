-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- go to last loc when opening a buffer
-- this mean that when you open a file, you will be at the last position
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd('User', {
  desc = 'Close buffers when files are deleted in Oil',
  pattern = 'OilActionsPost',
  callback = function(args)
    if args.data.err then
      return
    end
    for _, action in ipairs(args.data.actions) do
      if action.type == 'delete' then
        local _, path = require('oil.util').parse_url(action.url)
        local bufnr = vim.fn.bufnr(path)

        if bufnr ~= -1 then
          -- Move windows off the buffer first so wiping it keeps the layout.
          for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
            vim.api.nvim_win_call(win, function()
              vim.cmd.bprevious()
              if vim.api.nvim_get_current_buf() == bufnr then
                vim.cmd.enew()
              end
            end)
          end
          vim.cmd.bwipeout { bufnr, bang = true }
        end
      end
    end
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' })

    vim.cmd 'highlight Winbar guibg=none'
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave', 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('checktime', { clear = true }),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd 'checktime'
    end
  end,
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('no_auto_comment', { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

-- `q` is <nop> globally (see keymaps.lua), so restore it buffer-locally in the
-- throwaway windows where it is the natural way out.
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Close quickfix and loclist windows with q',
  group = vim.api.nvim_create_augroup('quickfix_close', { clear = true }),
  pattern = 'qf',
  callback = function(args)
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = args.buf, desc = 'Close quickfix list' })
  end,
})

-- Files over 1.5MB, or with very long lines (minified), get the "bigfile"
-- filetype instead of their own, so treesitter and LSP never attach to them.
vim.filetype.add {
  pattern = {
    ['.*'] = {
      function(path, buf)
        if not path or not buf or vim.bo[buf].filetype == 'bigfile' then
          return
        end
        if path ~= vim.fs.normalize(vim.api.nvim_buf_get_name(buf)) then
          return
        end
        local size = vim.fn.getfsize(path)
        if size <= 0 then
          return
        end
        if size > 1.5 * 1024 * 1024 then
          return 'bigfile'
        end
        local lines = vim.api.nvim_buf_line_count(buf)
        return (size - lines) / lines > 1000 and 'bigfile' or nil
      end,
    },
  },
}

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Keep big files cheap to edit',
  group = vim.api.nvim_create_augroup('bigfile', { clear = true }),
  pattern = 'bigfile',
  callback = function(args)
    local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(args.buf), ':p:~:.')
    vim.notify(('Big file detected: %s. Treesitter and LSP are off.'):format(name), vim.log.levels.WARN)
    vim.api.nvim_buf_call(args.buf, function()
      vim.wo[0][0].foldmethod = 'manual'
      vim.wo[0][0].statuscolumn = ''
      vim.wo[0][0].conceallevel = 0
    end)
    vim.b[args.buf].completion = false
    -- Fall back to the regex syntax of the real filetype.
    local ft = vim.filetype.match { buf = args.buf } or ''
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.bo[args.buf].syntax = ft
      end
    end)
  end,
})
