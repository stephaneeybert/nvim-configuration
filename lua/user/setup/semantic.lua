local status_ok, semantic = pcall(require, "semantic")

if not status_ok then
  return
end

semantic.setup {
}

-- Toggle semantic highlighting at buffer load time
local semanticHighlightGroup = vim.api.nvim_create_augroup("SemanticHighlight", { clear = true })
vim.api.nvim_create_autocmd(
  "BufReadPost",
  { pattern = "*", command = "SemanticHighlightToggle", group = semanticHighlightGroup }
)

local M = {}

local function semantic_highlight()
  vim.fn.SemanticHighlightToggle()
end

M.on_attach = function(client, bufnr)
  print("Client name: " + client.name)
  print("Buffer number: " + bufnr)
  semantic_highlight()
end

return M
