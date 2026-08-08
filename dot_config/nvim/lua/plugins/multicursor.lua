return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	event = "VeryLazy",
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		local set = vim.keymap.set

		-- Add or skip cursor above/below the main cursor.
		set({ "n", "x" }, "<up>", function()
			mc.lineAddCursor(-1)
		end)
		set({ "n", "x" }, "<down>", function()
			mc.lineAddCursor(1)
		end)

		-- Add or skip adding a new cursor by matching word/selection.
		-- Skip is on <leader>k/K rather than <leader>s/S: the latter is the
		-- prefix for every picker mapping (<leader>ss, <leader>sw, ...) and
		-- would make each of those wait out 'timeoutlen'.
		set({ "n", "x" }, "<leader>n", function()
			mc.matchAddCursor(1)
		end, { desc = "Add cursor at next match" })
		set({ "n", "x" }, "<leader>k", function()
			mc.matchSkipCursor(1)
		end, { desc = "Skip next match" })
		set({ "n", "x" }, "<leader>N", function()
			mc.matchAddCursor(-1)
		end, { desc = "Add cursor at previous match" })
		set({ "n", "x" }, "<leader>K", function()
			mc.matchSkipCursor(-1)
		end, { desc = "Skip previous match" })

		-- Disable and enable cursors.
		set({ "n", "x" }, "<c-q>", mc.toggleCursor)

		-- Mappings defined in a keymap layer only apply when there are
		-- multiple cursors. This lets you have overlapping mappings.
		mc.addKeymapLayer(function(layerSet)
			-- Select a different cursor as the main one.
			layerSet({ "n", "x" }, "<left>", mc.prevCursor)
			layerSet({ "n", "x" }, "<right>", mc.nextCursor)

			-- Enable and clear cursors using escape.
			layerSet("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				else
					mc.clearCursors()
				end
			end)
		end)
	end,
}
