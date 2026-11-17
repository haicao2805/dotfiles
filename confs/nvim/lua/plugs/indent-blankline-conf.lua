-- Indent guides: one colored line per block so nested code is easy to tell apart.
local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

local mod = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    local hooks = require("ibl.hooks")
    -- Create the highlight groups in the highlight setup hook, so they are reset on every colorscheme change
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      for _, name in ipairs(highlight) do
        vim.api.nvim_set_hl(0, name, { fg = "#333333" })
      end
    end)

    require("ibl").setup({ indent = { highlight = highlight } })
  end,
}

return mod
