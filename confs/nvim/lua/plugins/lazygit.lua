return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>gg", ":LazyGit<CR>", desc = "LazyGit" },
		{ "<leader>gl", ":LazyGitCurrentFile<CR>", desc = "LazyGit (current file repo)" },
	},
}
