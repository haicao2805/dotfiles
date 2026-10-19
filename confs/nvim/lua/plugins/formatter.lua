return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
			sql = { "pg_format" },
			rust = { "rustfmt" },
			dart = { "dart_format" },
			python = { "black" },
			go = { "gofumpt" },
			html = { "prettier" },
			-- oxfmt only runs when the project has an oxfmt config, otherwise prettier
			javascript = { "oxfmt", "prettier", stop_after_first = true },
			javascriptreact = { "oxfmt", "prettier", stop_after_first = true },
			typescript = { "oxfmt", "prettier", stop_after_first = true },
			typescriptreact = { "oxfmt", "prettier", stop_after_first = true },
			json = { "prettier" },
			markdown = { "prettier" },
			yaml = { "prettier" },
			-- Any filetype without a formatter above
			["_"] = { "trim_whitespace" },
		},
		formatters = {
			oxfmt = {
				command = require("conform.util").from_node_modules("oxfmt"),
				args = { "--stdin-filepath", "$FILENAME" },
				stdin = true,
				condition = function(_, ctx)
					return vim.fs.find({ ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" }, {
						path = ctx.dirname,
						upward = true,
					})[1] ~= nil
				end,
			},
		},
		-- Filetypes without a formatter (e.g. java) fall back to LSP formatting
		format_on_save = {
			timeout_ms = 3000,
			lsp_format = "fallback",
		},
	},
}
