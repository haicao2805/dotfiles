return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}

		local hooks = require("ibl.hooks")
		-- create the highlight groups in the highlight setup hook, so they are reset
		-- every time the colorscheme changes
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#333333" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#333333" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#333333" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#333333" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#333333" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#333333" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#333333" })
		end)

		require("ibl").setup({ indent = { highlight = highlight } })
	end,
}
