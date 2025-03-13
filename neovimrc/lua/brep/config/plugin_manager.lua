local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		lazyrepo,
		"--branch=stable",
		lazypath,
	})
end

-- rtp == runtimepath
vim.opt.rtp:prepend(lazypath)

-- Ensure leader is set correctly
local l = vim.g.mapleader
if l ~= " " then
	vim.g.mapleader = " "
end

-- Set Lazy plugin manager keymap
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<CR>", { noremap = true, silent = true })

require("lazy").setup("brep.plugins", {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
