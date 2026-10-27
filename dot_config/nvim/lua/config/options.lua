local options = {
	title = true,
	cmdheight = 0,
	laststatus = 3,
	expandtab = true,
	shiftwidth = 2,
	tabstop = 2,
	wrap = false,
	splitkeep = "cursor",
	-- Autodetect can miss truecolor inside herdr
	termguicolors = true,
	ruler = false,
	number = true,
	relativenumber = true,
	mouse = "a",
	-- The mode is already in the statusline
	showmode = false,
	clipboard = "unnamedplus",
	breakindent = true,
	-- Case-insensitive search unless the pattern has a capital or \C
	ignorecase = true,
	smartcase = true,
	signcolumn = "yes",
	updatetime = 100,
	splitright = true,
	splitbelow = true,
	inccommand = "split",
	cursorline = true,
	cursorlineopt = "both",
	scrolloff = 10,

	foldenable = false,

	-- What to save in session. No "buffers": only the files visible in windows
	-- come back, not every buffer the last session had open. No "resize": it
	-- saves the terminal's lines/columns, so a session from a big monitor
	-- forces that size on the laptop screen. Split sizes ("winsize") scale.
	sessionoptions = {
		"curdir",
		"winsize",
	},

	writebackup = false,
	swapfile = false,
	smoothscroll = true,
	undofile = true,
	-- $SHELL can be another shell when nvim is started from a script or agent
	shell = vim.fn.exepath("fish") ~= "" and vim.fn.exepath("fish") or vim.o.shell,

	-- Default border for every float that doesn't set its own
	winborder = "single",

	fillchars = {
		eob = " ",
	},
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.wildignore:append({ "*/node_modules/*" })

-- What mason's setup() would do, without loading mason on startup. Skipped
-- when fish already put it on PATH.
local mason_bin = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin")
if not vim.tbl_contains(vim.split(vim.env.PATH, ":"), mason_bin) then
	vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.diagnostic.config({
	signs = false,
	underline = {
		severity = vim.diagnostic.severity.ERROR,
	},
	float = {
		source = "if_many",
	},
})

-- Built-in (experimental) message/cmdline UI, replaces noice.nvim.
-- With cmdheight=0 messages go to the ephemeral "msg" window instead of
-- expanding the cmdline. Private API: guarded so a rename doesn't break startup.
local ok, ui2 = pcall(require, "vim._core.ui2")
if ok then
	ui2.enable({
		msg = {
			targets = "msg",
		},
	})
end
