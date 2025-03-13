return {
	-- Color schemes
	-- "folke/tokyonight.nvim",
	-- "rebelot/kanagawa.nvim",
	"sainnhe/gruvbox-material",
	-- "catppuccin/nvim",
	priority = 1000, -- load before other start plugins
	init = function()
		-- vim.cmd.colorscheme = "tokyonight"
		vim.cmd("colorscheme gruvbox-material")
		-- vim.cmd("colorscheme kanagawa")
		-- vim.cmd("colorscheme catppuccin")
		-- Can config highlights by doing something like:
		-- vim.cmd.hi= "Comment gui=none"
	end,
}
