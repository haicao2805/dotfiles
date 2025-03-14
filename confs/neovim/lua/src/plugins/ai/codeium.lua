return {
	"Exafunction/codeium.vim",
	event = "BufEnter",
	config = function()
		local keymap = vim.keymap
		vim.g.codeium_disable_bindings = 1

		keymap.set("i", "<C-j>", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true, silent = true })

		keymap.set("i", "<C-k>", function()
			return vim.fn["codeium#AcceptWord"]()
		end, { expr = true, silent = true })

		keymap.set("i", "<C-l>", function()
			return vim.fn["codeium#AcceptNextLine"]()
		end, { expr = true, silent = true })

		keymap.set("i", "<M-]>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, { expr = true, silent = true })

		keymap.set("i", "<M-[>", function()
			return vim.fn["codeium#CycleCompletions"](-1)
		end, { expr = true, silent = true })

		keymap.set("i", "<C-]>", function()
			return vim.fn["codeium#Clear"]()
		end, { expr = true, silent = true })
	end,
}
