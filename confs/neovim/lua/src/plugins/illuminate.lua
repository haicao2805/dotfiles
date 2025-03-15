return {
	"RRethy/vim-illuminate",
	config = function()
		require("illuminate").configure({
			delay = 200, -- Delay before highlighting
			filetypes_denylist = { "NvimTree", "TelescopePrompt" }, -- Ignore certain filetypes
		})
	end,
}
