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
vim.cmd("colorscheme gruvbox-material")

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
})

vim.lsp.enable("csharp-ls")

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
		vim.api.nvim_win_set_cursor(0, cursor)
	end,
})
