local M = {}

local api = vim.api

M.consolidate_blank_lines = function()
  -- Check the file type is text and the diff function exists
  if vim.bo.binary == true then
    return
  end

  if api.nvim_get_current_line() ~= "" then
    return
  end

  local search_flags = {
    ["start"] = "nWb", -- previous line
    ["end"] = "nW", -- next line
  }

  local range = {}
  for dir, flags in pairs(search_flags) do
    range[dir] = vim.fn.search("\\(^\\s*$\\)\\@!", flags)
  end

  -- remove the lines
  if range["end"] - range["start"] > 0 then
    api.nvim_buf_set_lines(0, range["start"] + 1, range["end"] - 1, true, {})
    api.nvim_win_set_cursor(0, { range["start"] + 1, 1 })
  end
end

M.upgrade_php_all = function()
--  filenames = vim.fn.vimgrep()
--  for filename in filenames do
--  end
end

M.upgrade_php_constructor = function()
  vim.fn.setreg('a', vim.fn.expand('%:t:r'))
  vim.cmd "execute '%s/function ' . getreg('a') . '/function __construct/'"
  vim.cmd "execute 'w'"
end

return M
