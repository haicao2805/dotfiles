vim.g.mapleader = "\\"

local keymap = vim.keymap

-- Coding & formatting
keymap.set("v", "<C-c>", '"+y')
keymap.set("n", "<S-u>", ":redo<CR>")
keymap.set("n", "<C-z>", ":undo<CR>")
keymap.set("n", "<C-s>", ":wa<CR>")
keymap.set("n", "ff", ":FormatWrite<CR>")
keymap.set("i", "jk", "<Esc>")
keymap.set("i", "kj", "<Esc>")
keymap.set(
	"n",
	"<leader>io",
	':lua vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })<CR>'
)

-- Moving
keymap.set("n", "<A-j>", ":m .+1<CR>==")
keymap.set("n", "<A-k>", ":m .-2<CR>==")
keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- NvimTree
keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>")
keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>")

-- Telescope
keymap.set("n", "<C-p>", ":Telescope find_files<CR>")
keymap.set("n", "<leader>fg", ":Telescope grep_string<CR>")
keymap.set("n", "<leader>fe", function()
	local builtin = require("telescope.builtin")
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
keymap.set("n", "<leader>fw", ":Telescope live_grep<CR>")
keymap.set("n", "<C-f>", ":Telescope current_buffer_fuzzy_find<CR>")
keymap.set("n", "<leader>gf", ":Telescope git_files<CR>")
keymap.set("n", "<leader>gc", ":Telescope git_commits<CR>")
keymap.set("n", "<leader>gst", ":Telescope git_status<CR>")
keymap.set("n", "<leader>gbr", ":Telescope git_branches<CR>")

-- LSP
keymap.set("n", "gD", vim.lsp.buf.declaration) -- go to declaration
keymap.set("n", "gR", ":Telescope lsp_references<CR>") -- show definition, references
keymap.set("n", "gd", ":Telescope lsp_definitions<CR>") -- show lsp definitions
keymap.set("n", "gi", ":Telescope lsp_implementations<CR>") -- show lsp implementations
keymap.set("n", "gt", ":Telescope lsp_type_definitions<CR>") -- show lsp type definitions
keymap.set("n", "gh", vim.lsp.buf.hover) -- show documentation for what is under cursor
keymap.set("n", "<leader>D", ":Telescope diagnostics bufnr=0<CR>") -- show  diagnostics for file
keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action) -- see available code actions, in visual mode will apply to selection
keymap.set("n", "<leader>rn", vim.lsp.buf.rename) -- smart rename
keymap.set("n", "<leader>er", vim.diagnostic.open_float) -- show diagnostics for line
