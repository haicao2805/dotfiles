source ~/.config/nvim/colors/color_helpers.vim

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

" Colorscheme name
let g:colors_name = "dark"

" --------------------------
" Palette
let s:bg = "#1e1f22"
let s:fg = "#BCBEC4"

let s:blue = "#56A8F5"
let s:cyan = "#2AACB8"
let s:orange = "#CF8E6D"
let s:green = "#6AAB73"
let s:purple = "#9876AA"
let s:pink = "#C77DBB"
let s:yellow_bright = "#FFC66D"
let s:yellow = "#BBB529"
let s:red = "#F75464"

let s:menu = "#2B2D30"
let s:comment = "#808080"
let s:selection = "#214283"
let s:success = "#7EC482"
let s:error = "#F75464"
let s:warn = "#BA9752"
let s:info = "#3592C4"

" --------------------------

if (has("gui_running") || &t_Co == 88 || &t_Co == 256)

  call Color("Normal", s:fg, s:bg, "")
  call Color("NormalFloat", s:fg, s:bg, "")
  call Color("Comment", s:comment, "", "italic")
  call Color("Constant", s:yellow, "" ,"")
  call Color("String", s:green, "", "")
  call Color("Character", s:purple, "", "")
  call Color("Number", s:orange, "", "")
  call Color("Boolean", s:orange, "", "")
  call Color("Float", s:orange, "", "")
  call Color("FloatBorder", s:fg, "", "")
  call Color("Operator", s:fg, "", "")
  call Color("Keyword", s:orange, "", "")
  call Color("Keywords", s:orange, "", "")
  call Color("Identifier", s:fg, "", "")
  call Color("Function", s:blue, "", "bold")
  call Color("Statement", s:yellow, "", "")
  call Color("Conditional", s:orange, "", "")
  call Color("Repeat", s:orange, "", "")
  call Color("Label", s:blue, "", "")
  call Color("Exception", s:orange, "", "")
  call Color("PreProc", s:yellow, "", "")
  call Color("Include", s:orange, "", "")
  call Color("Define", s:orange, "", "")
  call Color("Title", s:fg, "", "")
  call Color("Macro", s:orange, "", "")
  call Color("PreCondit", s:fg, "", "")
  call Color("Type", s:fg, "", "")
  call Color("StorageClass", s:fg, "", "")
  call Color("Structure", s:blue, "", "")
  call Color("TypeDef", s:yellow, "", "")
  call Color("Special", s:orange, "", "italic")
  call Color("SpecialComment", s:comment, "", "italic")
  call Color("Error", s:error, "", "")
  call Color("Todo", s:orange, "", "bold")
  call Color("Underlined", s:blue, "", "underline")

  call Color("Cursor", "", "", "reverse")
  call Color("CursorLineNr", s:fg, "", "bold")
  call Color("SignColumn", "", s:bg, "")

  call Color("Conceal", s:fg, "", "")
  call Color("CursorColumn", "", s:bg, "")
  call Color("CursorLine", "", s:selection, "")
  call Color("ColorColumn", "", s:selection, "")

  call Color("StatusLine", s:fg, s:bg, "")
  call Color("StatusLineNC", s:comment, "", "")
  call Color("StatusLineTerm", s:fg, s:bg, "")
  call Color("StatusLineTermNC", s:comment, "", "")

  call Color("Directory", s:yellow_bright, "", "")
  call Color("DiffAdd", s:bg, s:green, "")
  call Color("DiffChange", "", s:orange, "")
  call Color("DiffDelete", "", s:red, "")
  call Color("DiffText", s:comment, "", "")

  call Color("ErrorMsg", s:error, "", "")
  call Color("VertSplit", s:bg, "", "")
  call Color("WinSeparator", s:bg, "", "")
  call Color("Folded", s:comment, "", "")
  call Color("FoldColumn", "","", "")
  call Color("Search", s:bg, s:blue, "")
  call Color("IncSearch", s:bg, s:blue, "")
  call Color("LineNr", s:comment, "", "")
  call Color("MatchParen", s:fg, "", "underline")
  call Color("NonText", "", "", "")
  call Color("Pmenu", s:fg, s:menu, "")
  call Color("PmenuSel", "", s:selection, "")
  call Color("PmenuSbar", "", s:bg, "")
  call Color("PmenuThumb", "", s:selection, "")

  call Color("Question", s:orange, "", "")
  call Color("QuickFixLine", s:bg, s:yellow, "")
  call Color("SpecialKey", "", "", "")

  call Color("TabLine", s:comment, "", "")
  call Color("TabLineSel", s:comment, "", "")
  call Color("TabLineFill", "", s:bg, "")
  call Color("Terminal", s:fg, s:bg, "")
  call Color("WarningMsg", s:yellow, "", "")
  call Color("WildMenu", s:fg, s:bg, "")

" -- TreeSitter
" ['@error'] = { fg = colors.bright_red, },
" ['@punctuation.delimiter'] = { fg = colors.fg, },
" ['@punctuation.bracket'] = { fg = colors.fg, },
" ['@markup.list'] = { fg = colors.cyan, },
"
  call Color("@constant", s:purple, "", "")
" ['@constant.builtin'] = { fg = colors.purple, },
" ['@markup.link.label.symbol'] = { fg = colors.purple, },
"
" ['@constant.macro'] = { fg = colors.cyan, },
" ['@string.regexp'] = { fg = colors.red, },
" ['@string'] = { fg = colors.yellow, },
" ['@string.escape'] = { fg = colors.cyan, },
" ['@string.special.symbol'] = { fg = colors.purple, },
" ['@character'] = { fg = colors.green, },
" ['@number'] = { fg = colors.purple, },
" ['@boolean'] = { fg = colors.purple, },
" ['@number.float'] = { fg = colors.green, },
  call Color("@annotation", s:yellow, "", "")
  call Color("@attribute", s:yellow, "", "")
  call Color("@module", s:purple, "", "")
"
" ['@function.builtin'] = { fg = colors.cyan, },
" ['@function'] = { fg = colors.green, },
" ['@function.macro'] = { fg = colors.green, },
" ['@variable.parameter'] = { fg = colors.orange, },
" ['@variable.parameter.reference'] = { fg = colors.orange, },
  call Color("@function.method", s:fg, "", "")
" ['@variable.member'] = { fg = colors.orange, },
" ['@property'] = { fg = colors.purple, },
" ['@constructor'] = { fg = colors.cyan, },
"
" ['@keyword.conditional'] = { fg = colors.pink, },
" ['@keyword.repeat'] = { fg = colors.pink, },
" ['@label'] = { fg = colors.cyan, },
"
" ['@keyword'] = { fg = colors.pink, },
" ['@keyword.function'] = { fg = colors.cyan, },
" ['@keyword.operator'] = { fg = colors.pink, },
" ['@operator'] = { fg = colors.pink, },
" ['@keyword.exception'] = { fg = colors.purple, },
  call Color("@type", s:fg, "", "")
" ['@type.builtin'] = { fg = colors.cyan, italic = true, },
" ['@type.qualifier'] = { fg = colors.pink, },
" ['@structure'] = { fg = colors.purple, },
" ['@keyword.include'] = { fg = colors.pink, },
"
  call Color("@variable", s:fg, "", "")
  call Color("@variable.builtin", s:orange, "", "")
"
" ['@markup'] = { fg = colors.orange, },
" ['@markup.strong'] = { fg = colors.orange, bold = true, },     -- bold
" ['@markup.emphasis'] = { fg = colors.yellow, italic = true, }, -- italic
" ['@markup.underline'] = { fg = colors.orange, },
" ['@markup.heading'] = { fg = colors.pink, bold = true, },        -- title
" ['@markup.raw'] = { fg = colors.yellow, },                 -- inline code
" ['@markup.link.url'] = { fg = colors.yellow, italic = true, },      -- urls
" ['@markup.link'] = { fg = colors.orange, bold = true, },
"
" ['@tag'] = { fg = colors.cyan, },
" ['@tag.attribute'] = { fg = colors.green, },
" ['@tag.delimiter'] = { fg = colors.cyan, },
"
" -- Semantic
" ['@class'] = { fg = colors.cyan },
" ['@struct'] = { fg = colors.cyan },
" ['@enum'] = { fg = colors.cyan },
" ['@enumMember'] = { fg = colors.purple },
" ['@event'] = { fg = colors.cyan },
" ['@interface'] = { fg = colors.cyan },
" ['@modifier'] = { fg = colors.cyan },
" ['@regexp'] = { fg = colors.yellow },
" ['@typeParameter'] = { fg = colors.cyan },
  call Color("@decorator", s:purple, "", "")
"
" -- LSP Semantic (0.9+)
  call Color("@lsp.type.class", s:fg, "", "")
  call Color("@lsp.type.enum", s:fg, "", "")
  call Color("@lsp.type.decorator", s:yellow, "", "")
  call Color("@lsp.type.enumMember", s:fg, "", "")
  call Color("@lsp.type.function", s:pink, "", "")
" ['@lsp.type.interface'] = { fg = colors.cyan },
  call Color("@lsp.type.macro", "", s:red, "")
  call Color("@lsp.type.method", s:fg, "", "")
  call Color("@lsp.type.namespace", s:fg, "", "")
  call Color("@lsp.type.parameter", s:fg, "", "")
  call Color("@lsp.type.property", s:pink, "", "")
" ['@lsp.type.struct'] = { fg = colors.cyan },
  call Color("@lsp.type.type", s:fg, "", "")
  call Color("@lsp.type.variable", s:fg, "", "")

" --  Diff
call Color("diffAdded", s:green, "", "")
call Color("diffRemoved", s:red, "", "")
call Color("diffFileId", s:yellow, "", "bold")
call Color("diffFile", s:fg, "", "")
call Color("diffNewFile", s:green, "", "")
call Color("diffOldFile", s:red, "", "")

" -- Git Signs
  call Color("GitSignsAdd", s:green, "", "")
  call Color("GitSignsChange", s:orange, "", "")
  call Color("GitSignsDelete", s:red, "", "")
  call Color("GitSignsAddLn", s:bg, s:green, "")
  call Color("GitSignsChangeLn", s:bg, s:orange, "")
  call Color("GitSignsDeleteLn", s:bg, s:red, "")
  call Color("GitSignsCurrentLineBlame", s:fg, "", "")
"
" -- Telescope
  call Color("TelescopePromptBorder", s:comment, "", "")
  call Color("TelescopeResultsBorder", s:comment, "", "")
  call Color("TelescopePreviewBorder", s:comment, "", "")
  call Color("TelescopeSelection", "", s:selection, "")
  call Color("TelescopeMultiSelection", "", s:selection, "")
  call Color("TelescopeNormal", s:fg, s:bg, "")
  call Color("TelescopeMatching", s:green, "", "")
  call Color("TelescopePromptPrefix", s:orange, "", "")
  call Color("TelescopeResultsDiffDelete", s:red, "", "")
  call Color("TelescopeResultsDiffChange", s:orange, "", "")
  call Color("TelescopeResultsDiffAdd", s:green, "", "")

" -- NvimTree
  call Color("NvimTreeNormal", s:fg, s:menu, "")
  call Color("NvimTreeVertSplit", s:bg, s:bg, "")
  call Color("NvimTreeRootFolder", s:fg, "", "bold")
  call Color("NvimTreeGitDirty", s:yellow, "", "")
  call Color("NvimTreeGitNew", s:green, "", "")
  call Color("NvimTreeImageFile", s:purple, "", "")
  call Color("NvimTreeFolderIcon", s:orange, "", "")
  call Color("NvimTreeIndentMarker", s:fg, "", "")
  call Color("NvimTreeEmptyFolderName", s:comment, "", "")
  call Color("NvimTreeFolderName", s:fg, "", "")
  call Color("NvimTreeSpecialFile", s:purple, "", "underline")
  call Color("NvimTreeOpenedFolderName", s:fg, "", "")
  call Color("NvimTreeCursorLine", "", s:selection, "")
  call Color("NvimTreeIn", "", s:selection, "")

" -- Bufferline
  call Color("BufferLineIndicatorSelected", s:orange, "", "")
  call Color("BufferLineFill", "", s:bg, "")
  call Color("BufferLineBufferSelected", "", s:bg, "")
  call Color("BufferLineSeparator", s:bg, "", "")
"
" -- LSP
  call Color("DiagnosticError", s:error, "", "")
  call Color("DiagnosticWarn", s:warn, "", "")
  call Color("DiagnosticInfo", s:info, "", "")
  call Color("DiagnosticHint", s:success, "", "")
  call Color("DiagnosticSignError", s:error, "", "")
  call Color("DiagnosticSignWarn", s:warn, "", "")
  call Color("DiagnosticSignInfo", s:info, "", "")
  call Color("DiagnosticSignHint", s:success, "", "")
  call Color("DiagnosticFloatingError", s:error, "", "")
  call Color("DiagnosticFloatingWarn", s:warn, "", "")
  call Color("DiagnosticFloatingInfo", s:info, "", "")
  call Color("DiagnosticFloatingHint", s:success, "", "")
  call Color("DiagnosticVirtualTextError", s:error, "", "")
  call Color("DiagnosticVirtualTextWarn", s:warn, "", "")
  call Color("DiagnosticVirtualTextInfo", s:info, "", "")
  call Color("DiagnosticVirtualTextHint", s:success, "", "")
  call Color("LspDiagnosticsDefaultError", s:error, "", "")
  call Color("LspDiagnosticsDefaultWarning", s:warn, "", "")
  call Color("LspDiagnosticsDefaultInformation", s:info, "", "")
  call Color("LspDiagnosticsDefaultHint", s:success, "", "")
  call Color("LspReferenceText", s:purple, "", "")
  call Color("LspReferenceRead", s:purple, "", "")
  call Color("LspReferenceWrite", s:purple, "", "")
  call Color("LspCodeLens", s:info, "", "")
  call Color("LspInlayHint", s:fg, s:bg, "")

" --LSP Saga
  call Color("LspFloatWinNormal", s:fg, "", "")
  call Color("LspFloatWinBorder", s:comment, "", "")
  call Color("LspSagaHoverBorder", s:comment, "", "")
  call Color("LspSagaSignatureHelpBorder", s:comment, "", "")
  call Color("LspSagaCodeActionBorder", s:comment, "", "")
  call Color("LspSagaDefPreviewBorder", s:comment, "", "")
  call Color("LspLinesDiagBorder", s:comment, "", "")
  call Color("LspSagaRenameBorder", s:comment, "", "")
  call Color("LspSagaBorderTitle", s:menu, "", "")
  call Color("LSPSagaDiagnosticTruncateLine", s:comment, "", "")
  call Color("LspSagaDiagnosticBorder", s:comment, "", "")
  call Color("LspSagaShTruncateLine", s:comment, "", "")
  call Color("LspSagaDocTruncateLine", s:comment, "", "")
  call Color("LspSagaLspFinderBorder", s:comment, "", "")
  call Color("CodeActionNumber", s:fg, s:menu, "")

endif
