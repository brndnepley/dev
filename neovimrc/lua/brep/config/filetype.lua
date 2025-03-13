-- [[ Filetype Autocommands ]]
-- See `:help lua-guide-autocommands`

-- detect go html templates
--[[ vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	desc = "Detects go template files",
	group = vim.api.nvim_create_augroup("filetypedetect", { clear = false }),
	pattern = { "*.html.tmpl" },
	callback = function()
		vim.cmd("setfiletype tmpl")
	end,
}) ]]

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
