return {
	-- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext ["]quote
		--  - ci"  - [C]hange [I]nside ["]quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd"   - [S]urround [D]elete ["]quotes
		-- - sr)"  - [S]urround [R]eplace [)] ["]
		require("mini.surround").setup()

		-- Simple and easy statusline.
		--  You could remove this setup call if you don"t like it,
		--  and try some other statusline plugin
		local statusline = require("mini.statusline")
		-- set use_icons to true if you have a Nerd Font
		statusline.setup({ use_icons = vim.g.have_nerd_font })

		--[[ local minimap = require("mini.map")
		minimap.setup({
			symbols = {
				encode = require("mini.map").gen_encode_symbols.dot("3x2"),
			},
			window = {
				winblend = 70,
			},
		})
		vim.keymap.set("n", "<leader>mt", MiniMap.toggle, { desc = "[M]ini map toggle" })
		vim.api.nvim_create_autocmd({ "BufEnter" }, {
			desc = "Turn On MiniMap",
			group = vim.api.nvim_create_augroup("br3p-minimap-toggle", { clear = true }),
			callback = function()
				minimap.open()
			end,
		}) ]]

		-- You can configure sections in the statusline by overriding their
		-- default behavior. For example, here we set the section for
		-- cursor location to LINE:COLUMN
		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return "%2l:%-2v"
		end

		-- ... and there is more!
		--  Check out: https://github.com/echasnovski/mini.nvim
	end,
}
