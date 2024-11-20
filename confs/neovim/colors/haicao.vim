source ~/.config/nvim/colors/color_helpers.vim

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

" Colorscheme name
let g:colors_name = "haicao"

let s:fg = "#ffffff"
let s:dim_fg = "#bbbbbb"

let s:bg = "#000000"
let s:mbg0 = "#111111"
let s:mbg1 = "#222222"

let s:comment = "#797979"
let s:red = "#af5f5f"
let s:orange = "#d59572"
let s:yellow = "#e5b567"
let s:dim_yellow = "#af875f"
let s:green = "#87afaf"
let s:blue = "#7eaac7"
let s:wine = "#924653"
let s:purple = "#9e86c8"
let s:pantone = "#424242"

let s:black0 = "#181818"
let s:black1 = "#282828"
let s:black2 = "#383838"
let s:error = "#ea5455"
let s:warn = "#ffa500"
let s:info = "#7db9b6"

if (has("gui_running") || &t_Co == 88 || &t_Co == 256)

  " General syntax
  call Color("Function", s:blue, "", "bold")
  call Color("Normal", s:fg, s:bg, "")
  call Color("Comment", s:comment, "", "")
  call Color("String", s:yellow, "", "")
  call Color("Keyword", s:red, "", "")
  call Color("Identifier", s:fg, "", "")
  call Color("Constant", s:orange, "", "")
  call Color("Error", s:red, "", "")
  call Color("Statement", s:red, "", "")
  call Color("Special", s:orange, "", "")
  call Color("Type", s:orange, "", "")
  call Color("Define", s:green, "", "")
  call Color("Operator", s:purple, "", "")
  call Color("Delimiter", s:orange, "", "")
  call Color("PreProc", s:blue, "", "")
  call Color("Include", s:red, "", "")
  call Color("Tag", s:orange, "", "bold")
  call Color("Underlined", s:orange, "", "underline")
  call Color("Title", s:comment, "", "bold")

  " Editor UI
  call Color("StatusLine", s:black0, s:yellow, "reverse")
  call Color("StatusLineNC", s:black0, s:fg, "reverse")
  call Color("TabLine", s:black0, s:fg, "reverse")
  call Color("TabLineFill", s:black0, s:fg, "reverse")
  call Color("CursorLine", "", s:black1, "")
  call Color("CursorLineNR", s:orange, "", "")
  call Color("CursorColumn", "", s:black0, "")
  call Color("VertSplit", s:black0, s:black1, "bold")
  call Color("ColorColumn", "", s:black0, "")
  call Color("Directory", s:yellow, "", "")
  call Color("Visual", "", s:pantone, "")
  call Color("Search", s:bg, s:fg, "")
  call Color("MoreMsg", s:green, "", "")
  call Color("ModeMsg", s:green, "", "")
  call Color("Question", s:green, "", "")
  call Color("WarningMsg", s:orange, "", "bold")
  call Color("MatchParen", "", s:wine, "")
  call Color("Folded", s:comment, s:bg, "")
  call Color("FoldColumn", "", s:bg, "")
  call Color("Pmenu", "", s:black0, "")

  " Nvim Tree
  call Color("NvimParenthesis", s:orange, "", "")
  call Color("NvimTreeNormal", s:fg, s:mbg0, "")
  call Color("NvimTreeRootFolder", s:red, "", "")
  call Color("NvimTreeFolderName", s:yellow, "", "bold")
  call Color("NvimTreeExecFile", s:red, "", "")
  call Color("NvimTreeOpenedFile", s:fg, "", "")
  call Color("NvimTreeWindowPicker", s:fg, "", "")

  hi! link NvimTreeFolderIcon Directory
  hi! link NvimTreeEmptyFolderName  NvimTreeFolderName
  hi! link NvimTreeOpenedFolderName NvimTreeFolderName

  " Telescope
  call Color("TelescopeBorder", s:pantone, "", "")
  call Color("TelescopeTitle", s:red, "", "bold")
  call Color("TelescopePromptTitle", s:fg, "", "bold")
  call Color("TelescopePreviewTitle", s:green, "", "bold")

  " Diagnostic
  call Color("DiagnosticError", s:error, "", "bold")
  call Color("DiagnosticWarn", s:warn, "", "bold")
  call Color("DiagnosticInfo", s:info, "", "bold")
  call Color("DiagnosticHint", s:blue, "", "bold")

  " Telescope
  call Color("TelescopeBorder", s:pantone, "", "")
  call Color("TelescopeTitle", s:red, "", "bold")
  call Color("TelescopePromptTitle", s:fg, "", "bold")
  call Color("TelescopePreviewTitle", s:green, "", "bold")

endif
