return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  cmd = "Copilot",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-J>",
          next = "<C-L>",
          prev = "<C-K>",
          dismiss = "<C-H>",
        },
      },
      panel = {
        enabled = true,
      },
      -- filetypes = {
      --   ["*"] = true,
      --   markdown = false,
      --   help = false,
      --   NvimTree = false,
      --   TelescopePrompt = false,
      -- },
    })
  end,
}
