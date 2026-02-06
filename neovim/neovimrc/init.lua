vim.opt.fileformat = "unix"
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.softtabstop = 4
vim.opt.expandtab = false
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"
vim.opt.guicursor = ""
vim.opt.undofile = true
vim.opt.hidden = false
vim.opt.scrolloff = 8
vim.opt.splitright = false
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.list = true
vim.opt.listchars = "tab:| ,trail:·,nbsp:·"
vim.g.mapleader = " "
vim.g.have_nerd_font = true

local map = vim.keymap.set
map('n', '<leader>so', ':update<CR> :source<CR>')
map('n', '<leader>pv', ':Explore<CR>')
map('n', '<leader>lf', vim.lsp.buf.format)

vim.pack.add({
	{ src = "https://github.com/sainnhe/gruvbox-material" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})
vim.pack.add( {
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
})

-- telscope
local ts = require("telescope")
ts.setup({
	defaults = {
		layout_strategy = "flex",
		sorting_strategy = "ascending",
	},
})
local builtin = require("telescope.builtin")
map('n', '<leader>ff', builtin.find_files)
map('n', '<leader>fg', builtin.live_grep)
map('n', '<leader>fb', builtin.buffers)
map('n', '<leader>fh', builtin.help_tags)

-- fzf needs to be built:
-- cd ~/.local/share/nvim/site/pack/core/opt/telescope-fzf-native.nvim && make
ts.load_extension("fzf")

-- end telescope

vim.cmd("colorscheme gruvbox-material")
vim.cmd("set completeopt+=noselect")

vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.opt_local.equalprg = "clang-format"
    vim.opt_local.formatprg = "clang-format"
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = {"*.c", "*.h"},
	callback = function()
		local file = vim.fn.expand("%:p")
		local cursor = vim.api.nvim_win_get_cursor(0)
		vim.cmd("silent %!clang-format")

		-- clamp cursor row/col to valid positions
		local line_count = vim.api.nvim_buf_line_count(0)
		local row = math.min(cursor[1], line_count)
		local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
		local col = math.min(cursor[2], #line)
		vim.api.nvim_win_set_cursor(0, {row, col})
	end,
})
