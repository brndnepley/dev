-- This is the setup for running slow formatters async
local slow_format_filetypes = {}
return {
	-- Auto Formattter
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = true,
		formatters_by_ft = {
			lua = { "stylua" },
			-- htmldjango = { "djlint" },
			json = { "prettierd" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		},
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true, htmldjango = true }
			local buftyp = vim.bo[bufnr].filetype
			if slow_format_filetypes[buftyp] then
				return
			end
			local function on_format(err)
				if err and err:match("timeout$") then
					slow_format_filetypes[buftyp] = true
				end
			end
			return { timeout_ms = 500, lsp_fallback = not disable_filetypes[buftyp] }, on_format
		end,
		format_after_save = function(bufnr)
			if not slow_format_filetypes[vim.bo[bufnr].filetype] then
				return
			end
			return { lsp_fallback = true }
		end,
	},
}
