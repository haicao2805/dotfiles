return {
	"github/copilot.vim",
	event = "VimEnter",

	config = function()
		vim.g.copilot_no_tab_map = true
		vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
		vim.api.nvim_set_keymap("i", "<C-K>", "copilot#Previous()", { silent = true, expr = true })
		vim.api.nvim_set_keymap("i", "<C-L>", "copilot#Next()", { silent = true, expr = true })
		vim.api.nvim_set_keymap("i", "<C-H>", "copilot#Dismiss()", { silent = true, expr = true })
		-- vim.g.copilot_filetypes = {
		-- 	["*"] = true,
		-- 	["markdown"] = false,
		-- 	["help"] = false,
		-- 	["NvimTree"] = false,
		-- 	["TelescopePrompt"] = false,
		-- }
	end,
}
