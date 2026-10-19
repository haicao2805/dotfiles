return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- Import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Used to enable autocompletion (assign to every lsp server config)
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

    -- Lua
    vim.lsp.config["lua_ls"] = {
      cmd = {"lua-language-server"},
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

    -- TypeScript/JavaScript (using bun-installed typescript-language-server)
    vim.lsp.config["ts_ls"] = {
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
      capabilities = capabilities,
    }

    -- Tailwind CSS
    vim.lsp.config["tailwindcss"] = {
      cmd = { "tailwindcss-language-server", "--stdio" },
      filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
      root_markers = { "tailwind.config.js", "tailwind.config.cjs", "tailwind.config.mjs", "postcss.config.js", "postcss.config.cjs", "postcss.config.mjs", ".git" },
      capabilities = capabilities,
    }

    -- -- Rust
    -- vim.lsp.config["rust_analyzer"] = {
    --   cmd = { "rust-analyzer" },
    --   filetypes = { "rust" },
    --   root_markers = { "Cargo.toml", "Cargo.lock", "rust-project.json", ".git" },
    --   capabilities = capabilities,
    --   settings = {
    --     ["rust-analyzer"] = {
    --       cargo = { allFeatures = true },
    --       checkOnSave = true,
    --       check = { command = "clippy" },
    --     },
    --   },
    -- }

    -- Enable LSP servers
    vim.lsp.enable({ "lua_ls", "ts_ls", "tailwindcss",
      -- "rust_analyzer"
    })
  end,
}
