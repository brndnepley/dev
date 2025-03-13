return {
	-- Plugin for showing pending keybinds
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- callback AFTER loading
		require("which-key").add({
			{ "<leader>c", desc = "[C]ode" },
			{ "<leader>d", desc = "[D]ocument" },
			{ "<leader>r", desc = "[R]ename" },
			{ "<leader>s", desc = "[S]earch" },
			{ "<leader>w", desc = "[W]orkspace" },
		})
	end,
}
