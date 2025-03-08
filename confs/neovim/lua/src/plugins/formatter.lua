return {
	"mhartington/formatter.nvim",
	config = function()
		local formatter = require("formatter")

		formatter.setup({
			-- Enable or disable logging
			logging = true,
			-- Set the log level
			log_level = vim.log.levels.WARN,
			-- All formatter configurations are opt-in
			filetype = {
				lua = { require("formatter.filetypes.lua").stylua },
				["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
				html = { require("formatter.filetypes.javascript").prettier },
				javascript = { require("formatter.filetypes.javascript").prettier },
				javascriptreact = { require("formatter.filetypes.javascriptreact").prettier },
				json = { require("formatter.filetypes.json").prettier },
				markdown = { require("formatter.filetypes.markdown").prettier },
				sh = { require("formatter.filetypes.sh").shfmt },
				sql = { require("formatter.filetypes.sql").pgformat },
				typescript = { require("formatter.filetypes.typescript").prettier },
				typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },
				yaml = { require("formatter.filetypes.yaml").prettier },
				dart = { require("formatter.filetypes.dart").dartformat },
				python = {
					function()
						return {
							exe = "black",
							args = { "-" },
							stdin = true,
						}
					end,
				},
			},
		})
	end,
}
