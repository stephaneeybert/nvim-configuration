local api = vim.api

-- Briefly highlight on yank
local yankGroup = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGroup,
})

-- Go to the location the cursor was when reopening the file
api.nvim_create_autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- Close buffers of some types with a custom key
api.nvim_create_autocmd(
  "FileType",
  { pattern = { "help", "startuptime", "qf", "lspinfo" }, command = [[nnoremap <buffer><silent> <A-w> :close<CR>]] }
)
api.nvim_create_autocmd(
  "FileType",
  { pattern = "man", command = [[nnoremap <buffer><silent> <A-w> :quit<CR>]] }
)

-- Highlight the cursor line number
local highlight_cursor = function()
  vim.opt.cursorline = true
  vim.opt.cursorlineopt = "number"
end
local unhighlight_cursor = function()
  vim.opt.cursorline = false
end
local highlightCursorGroup = api.nvim_create_augroup("HighlightCursorGroup", { clear = true })
api.nvim_create_autocmd(
  { "InsertLeave", "WinEnter" },
  { pattern = "*", callback = highlight_cursor, group = highlightCursorGroup }
)
api.nvim_create_autocmd(
  { "InsertEnter", "WinLeave" },
  { pattern = "*", callback = unhighlight_cursor, group = highlightCursorGroup }
)
