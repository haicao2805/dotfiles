return {
	-- "folke/tokyonight.nvim",
	-- config = function()
	-- 	vim.cmd([[colorscheme tokyonight]])
	-- end,
	"Mofiqul/dracula.nvim",
	config = function()
		vim.cmd([[colorscheme dracula]])

		-- Override Background
		vim.cmd([[hi normal                                    guibg=#000000]])
		vim.cmd([[hi signcolumn                                guibg=#000000]])
		vim.cmd([[hi telescopenormal                           guibg=#000000]])
		vim.cmd([[hi nvimtreenormal                            guibg=#222222]])
		-- Override Foreground
		vim.cmd([[hi endofbuffer                               guifg=#000000]])
	end,
}
