return {
	"Mofiqul/dracula.nvim",
	config = function()
		vim.cmd([[colorscheme dracula]])
		vim.cmd([[
		     hi normal guibg=#000000
		  ]])
		vim.cmd([[
		     hi nvimtreenormal guibg=#222222
		  ]])
		vim.cmd([[
		     hi telescopenormal guibg=#000000
		  ]])
	end,
}
