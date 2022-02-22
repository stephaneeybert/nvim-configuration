local M = {}

M.setup = function()
  local icons = require "user.setup.icons"
  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_format_document(client)
  -- Check the language server capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
      ]],
      false
    )
  end
end

local function lsp_highlight_document(client)
  -- Check the language server capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]],
      false
    )
  end
end

local function buf_map(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
    -- No recursive mapping
    noremap = true,
    -- No echoing of the command in the command line
    silent = true,
  })
end

local function lsp_keymaps(bufnr)
  buf_map(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  buf_map(bufnr, "n", "<leader>df", "<cmd>lua vim.lsp.buf.definition()<CR>")
  buf_map(bufnr, "n", "<leader>dt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  buf_map(bufnr, "n", "<leader>dc", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  buf_map(bufnr, "n", "<leader>ip", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  buf_map(bufnr, "n", "<leader>rf", "<cmd>lua vim.lsp.buf.references()<CR>")
  buf_map(bufnr, "n", ">leader>K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  buf_map(bufnr, "n", "<leader>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  buf_map(bufnr, "n", "<leader>ft", "<cmd>lua vim.lsp.buf.formatting()<CR>")
  buf_map(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
  buf_map(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
  buf_map(bufnr, "n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
  buf_map(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>") -- key: organize import statements
  buf_map(bufnr, "n", "<leader>dg", "<cmd>lua vim.diagnostic.open_float()<CR>")
  buf_map(bufnr, "n", "<leader>dj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
  buf_map(bufnr, "n", "<leader>dk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
  buf_map(bufnr, "n", "<leader>dl", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    -- Disable the built-in formatter of tsserver
    -- so as to make room for the prettier formatter
    -- offered by the null-ls plugin
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    buf_map(bufnr, "n", "<leader>ia", ":TSLspImportAll<CR>")
    buf_map(bufnr, "n", "<leader>io", ":TSLspOrganize<CR>")
    buf_map(bufnr, "n", "<leader>ic", ":TSLspImportCurrent<CR>")
  end

  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
  lsp_format_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
