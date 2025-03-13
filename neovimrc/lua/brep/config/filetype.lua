-- [[ Filetype Autocommands ]]
-- See `:help lua-guide-autocommands`

vim.filetype.add({
	extension = {
		tmpl = "tmpl",
	},
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.js" },
	group = vim.api.nvim_create_augroup("filetypedetect", { clear = false }),
	callback = function()
		vim.opt.tabstop = 2
		vim.opt.softtabstop = 2
		vim.opt.shiftwidth = 2
		vim.opt.smartindent = true
		vim.opt.expandtab = true
	end,
})
