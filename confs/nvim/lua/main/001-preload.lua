local set = vim.opt
local g = vim.g

-- Encoding
set.encoding = "utf-8"
set.fileencoding = "utf-8"

-- Tabs
set.expandtab = true
set.smarttab = true
set.tabstop = 2
set.softtabstop = 2
set.laststatus = 2
set.shiftwidth = 2

-- Indentation
set.smartindent = true
set.autoindent = true
set.showmatch = true

-- Search
set.hlsearch = true
set.incsearch = true
set.ignorecase = true
set.smartcase = true

-- Split
set.splitbelow = true
set.splitright = true
set.wrap = false

-- Cursor
set.cursorline = true
set.cursorlineopt = "both"
set.backup = false
set.writebackup = false
set.lazyredraw = true
set.relativenumber = true
set.number = true

-- Clipboard
set.clipboard = "unnamedplus"

-- Colors
set.termguicolors = true
set.background = "dark"

-- Other
set.hidden = true
set.secure = true
set.cmdheight = 1
set.scrolloff = 8
set.signcolumn = "yes"
