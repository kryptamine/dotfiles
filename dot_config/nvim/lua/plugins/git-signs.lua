local icons = {
  BoldLineLeft = '▌',
  Triangle = '󰐊',
}

return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    lazy = true,
    opts = {
      signs = {
        add = {
          text = icons.BoldLineLeft,
        },
        change = {
          text = icons.BoldLineLeft,
        },
        delete = {
          text = icons.Triangle,
        },
        topdelete = {
          text = icons.Triangle,
        },
        changedelete = {
          text = icons.BoldLineLeft,
        },
        untracked = {
          text = icons.BoldLineLeft,
        },
      },
      signs_staged = {
        add = {
          text = icons.BoldLineLeft,
        },
        change = {
          text = icons.BoldLineLeft,
        },
        delete = {
          text = icons.Triangle,
        },
        topdelete = {
          text = icons.Triangle,
        },
        changedelete = {
          text = icons.BoldLineLeft,
        },
        untracked = {
          text = icons.BoldLineLeft,
        },
      },
      preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk Inline")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
      end,
    },
  },
}
