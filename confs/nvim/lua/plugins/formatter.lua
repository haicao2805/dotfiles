-- Web and data files (js/ts, json, css, html, markdown, yaml, ...) all go to `bun fmt`. It reads the
-- project's own config ([fmt] in bunfig.toml, or an existing prettier/oxfmt config), so it runs from
-- the project root.
local PROJECT_ROOT_MARKERS = { { "bunfig.toml" }, { "package.json", ".git" } }

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
      html = { "bun_fmt" },
      css = { "bun_fmt" },
      scss = { "bun_fmt" },
      less = { "bun_fmt" },
      vue = { "bun_fmt" },
      svelte = { "bun_fmt" },
      javascript = { "bun_fmt" },
      javascriptreact = { "bun_fmt" },
      typescript = { "bun_fmt" },
      typescriptreact = { "bun_fmt" },
      json = { "bun_fmt" },
      jsonc = { "bun_fmt" },
      json5 = { "bun_fmt" },
      markdown = { "bun_fmt" },
      mdx = { "bun_fmt" },
      yaml = { "bun_fmt" },
      -- Any filetype without a formatter above
      ["_"] = { "trim_whitespace" },
    },
    formatters = {
      bun_fmt = {
        command = "bun",
        args = { "fmt", "--no-script", "--stdin-filepath", "$FILENAME" },
        stdin = true,
        cwd = function(_, ctx)
          return vim.fs.root(ctx.filename, PROJECT_ROOT_MARKERS) or vim.fs.dirname(ctx.filename)
        end,
      },
    },
    -- Filetypes without a formatter (e.g. java) fall back to LSP formatting
    format_on_save = {
      timeout_ms = 30000,
      lsp_format = "fallback",
    },
  },
}
