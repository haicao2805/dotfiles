return {
	"mhartington/formatter.nvim",
	config = function()
		local formatter = require("formatter")

		local util = require("formatter.util")

		local function prettier()
			local bufname = vim.api.nvim_buf_get_name(0)
			local cwd = vim.fn.fnamemodify(bufname, ":p:h")

			-- Walk up to find nearest .prettierrc* or package.json
			local root = vim.fs.find(
				{ ".prettierrc", ".prettierrc.mjs", ".prettierrc.js", ".prettierrc.json", "package.json" },
				{ path = cwd, upward = true, limit = 1 }
			)
			if root and root[1] then
				cwd = vim.fn.fnamemodify(root[1], ":p:h")
			end

			return {
				exe = "prettier",
				args = {
					"--stdin-filepath",
					util.escape_path(bufname),
				},
				stdin = true,
				try_node_modules = true,
				cwd = cwd,
			}
		end

		formatter.setup({
			-- Enable or disable logging
			logging = true,
			-- Set the log level
			log_level = vim.log.levels.WARN,
			-- All formatter configurations are opt-in
			filetype = {
				lua = { require("formatter.filetypes.lua").stylua },
				["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
				html = { prettier },
				javascript = { prettier },
				javascriptreact = { prettier },
				json = { prettier },
				markdown = { prettier },
				sh = { require("formatter.filetypes.sh").shfmt },
				sql = { require("formatter.filetypes.sql").pgformat },
				typescript = { prettier },
				typescriptreact = { prettier },
				yaml = { prettier },
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
				go = {
					function()
						return {
							exe = "gofumpt", -- or use "gofmt" if preferred
							args = {},
							stdin = true,
						}
					end,
				},
				java = {
					-- Use JDTLS LSP formatting
					function()
						vim.lsp.buf.format({ async = false })
						return {}
					end,
				},
			},
		})

		-- Keybinding for manual formatting
		vim.keymap.set("n", "<leader>fm", ":Format<CR>", { desc = "Format file" })
	end,
}
