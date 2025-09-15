return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- -- import lspconfig plugin
		-- local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})

		-- configure lua server (with special settings)
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		-- configure html server
		vim.lsp.config("html", {
			capabilities = capabilities,
		})

		-- configure typescript server with plugin
		vim.lsp.config("tsserver", {
			capabilities = capabilities,
		})

		-- configure css server
		vim.lsp.config("cssls", {
			capabilities = capabilities,
		})

		-- configure tailwindcss server
		vim.lsp.config("tailwindcss", {
			capabilities = capabilities,
		})

		-- configure ruff language server (python)
		vim.lsp.config("ruff", {
			capabilities = capabilities,
		})

		-- configure golang language server
		vim.lsp.config("gopls", {
			capabilities = capabilities,
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					gofumpt = true,
				},
			},
			cmd = { vim.fn.stdpath("data") .. "/mason/bin/gopls" },
		})
	end,
}
