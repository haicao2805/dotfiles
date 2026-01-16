return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})

		-- configure lua server (with special settings)
		vim.lsp.config["lua_ls"] = {
			cmd = { vim.fn.stdpath("data") .. "/mason/bin/lua-language-server" },
			filetypes = { "lua" },
			root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		}

		-- configure html server
		vim.lsp.config["html"] = {
			cmd = { vim.fn.stdpath("data") .. "/mason/bin/vscode-html-language-server", "--stdio" },
			filetypes = { "html" },
			root_markers = { ".git" },
			capabilities = capabilities,
		}

		-- configure typescript server
		vim.lsp.config["ts_ls"] = {
			cmd = { vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server", "--stdio" },
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
			capabilities = capabilities,
		}

		-- configure css server
		vim.lsp.config["cssls"] = {
			cmd = { vim.fn.stdpath("data") .. "/mason/bin/vscode-css-language-server", "--stdio" },
			filetypes = { "css", "scss", "less" },
			root_markers = { ".git" },
			capabilities = capabilities,
		}

		-- configure tailwindcss server
		vim.lsp.config["tailwindcss"] = {
			cmd = { vim.fn.stdpath("data") .. "/mason/bin/tailwindcss-language-server", "--stdio" },
			filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
			root_markers = { "tailwind.config.js", "tailwind.config.ts", ".git" },
			capabilities = capabilities,
		}

		-- configure python language server
		vim.lsp.config["pyright"] = {
			cmd = { vim.fn.stdpath("data") .. "/mason/bin/pyright-langserver", "--stdio" },
			filetypes = { "python" },
			root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
			capabilities = capabilities,
		}

		-- configure golang language server
		vim.lsp.config["gopls"] = {
			cmd = { vim.fn.stdpath("data") .. "/mason/bin/gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_markers = { "go.mod", "go.work", ".git" },
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
		}

		-- configure c sharp language server
		vim.lsp.config["csharp_ls"] = {
			cmd = { vim.fn.stdpath("data") .. "/mason/bin/csharp-ls" },
			filetypes = { "cs" },
			root_markers = { "*.csproj", "*.sln", ".git" },
			capabilities = capabilities,
		}

		-- configure java language server
		vim.lsp.config["jdtls"] = {
			cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls" },
			filetypes = { "java" },
			root_markers = {
				{ "mvnw", "gradlew", "settings.gradle", "settings.gradle.kts" },
				{ "build.xml", "pom.xml", "build.gradle", "build.gradle.kts" },
				".git",
			},
			capabilities = capabilities,
		}

		-- Enable all configured LSP servers
		vim.lsp.enable({ "lua_ls", "html", "ts_ls", "cssls", "tailwindcss", "pyright", "gopls", "csharp_ls", "jdtls" })
	end,
}
