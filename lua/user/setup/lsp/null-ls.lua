local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics -- TODO

null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier.with { extra_args = { "--trailing-comma", "none" } }
  }
}
