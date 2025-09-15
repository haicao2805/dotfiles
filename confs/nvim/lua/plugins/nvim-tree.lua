return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- configure nvim-tree
		nvimtree.setup({
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 45,
				cursorline = true,
			},
			git = {
				enable = true,
				ignore = true,
			},
			diagnostics = {
				enable = true,
				icons = {
					error = " ",
					warning = " ",
					hint = "󰠠 ",
					info = " ",
				},
			},
			update_focused_file = {
				enable = false,
				update_cwd = false,
				ignore_list = {},
			},
			renderer = {
				indent_markers = {
					enable = true,
				},
				highlight_git = true,
				root_folder_modifier = ":t",
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
					glyphs = {
						default = "",
						symlink = "",
						folder = {
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
						},
					},
				},
			},
		})
	end,
}
