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

    -- Find node_modules/.bin/<bin> nearest to `root` (walks up, supports hoisted monorepos)
    local function find_node_bin(root, bin)
      for dir in vim.fs.parents(root .. "/_") do
        local path = dir .. "/node_modules/.bin/" .. bin
        if vim.uv.fs_stat(path) then
          return path
        end
      end
      return bin
    end

    -- TypeScript/JavaScript (project-local typescript-language-server, fallback to $PATH)
    vim.lsp.config["ts_ls"] = {
      cmd = function(dispatchers, config)
        local bin = find_node_bin(config.root_dir or vim.uv.cwd(), "typescript-language-server")
        return vim.lsp.rpc.start({ bin, "--stdio" }, dispatchers)
      end,
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
      capabilities = capabilities,
      init_options = {
        hostInfo = "neovim",
        maxTsServerMemory = 4096,
        preferences = {
          importModuleSpecifierPreference = "non-relative",
          includePackageJsonAutoImports = "on",
          preferTypeOnlyAutoImports = true,
        },
      },
    }

    -- Oxlint (only starts when the project has an oxlint config and the binary is found)
    vim.lsp.config["oxlint"] = {
      cmd = function(dispatchers, config)
        local bin = find_node_bin(config.root_dir or vim.uv.cwd(), "oxlint")
        return vim.lsp.rpc.start({ bin, "--lsp" }, dispatchers)
      end,
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      root_dir = function(bufnr, on_dir)
        local root = vim.fs.root(bufnr, { ".oxlintrc.json", "oxlint.config.ts", ".configs" })
        if root and vim.fn.executable(find_node_bin(root, "oxlint")) == 1 then
          on_dir(root)
        end
      end,
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
    vim.lsp.enable({ "lua_ls", "ts_ls", "oxlint", "tailwindcss",
      -- "rust_analyzer"
    })
  end,
}
