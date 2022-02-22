local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("user.setup.lsp.lsp-installer")
require("user.setup.lsp.handlers").setup()
require("user.setup.lsp.null-ls")
