local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("user.setup.lsp.handlers").on_attach,
    capabilities = require("user.setup.lsp.handlers").capabilities,
  }

  if server.name == "jsonls" then
    local jsonls_opts = require("user.setup.lsp.settings.jsonls")
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server.name == "lua_ls" then
    local lua_ls_opts = require("user.setup.lsp.settings.lua_ls")
    opts = vim.tbl_deep_extend("force", lua_ls_opts, opts)
  end

  if server.name == "jdtls" then
    local jdtls_opts = require("user.setup.lsp.settings.jdtls")
    opts = vim.tbl_deep_extend("force", jdtls_opts, opts)
  end

  if server.name == "tsserver" then
    local tsserver_opts = require("user.setup.lsp.settings.tsserver")
    opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)
