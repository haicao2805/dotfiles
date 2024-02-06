return {
	"Mofiqul/dracula.nvim",
	config = function()
		vim.cmd([[colorscheme dracula]])

		vim.cmd([[
		     hi normal guibg=#282A36
		  ]])

		vim.cmd([[
		     hi nvimtreenormal guibg=#282A36
		  ]])
	end,
}
