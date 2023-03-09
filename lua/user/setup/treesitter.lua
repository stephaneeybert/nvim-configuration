local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  print("The treesitter extension could not be loaded")
  return
end

treesitter.setup {
  sync_install = false, -- installing languages asynchronously
  ignore_install = { "haskell", "go" }, -- the languages not to install
  ensure_installed = { "vim", "c", "cpp", "lua", "python", "rust", "typescript", "help", "cmake", "javascript", "typescript", "java" }, -- the languages to install
  autopairs = {
    enable = true
  },
  highlight = {
    enable = true, -- enable the syntax highlighting
    disable = { "css", "markdown" }, -- list of languages to disable
    additional_vim_regex_highlighting = { "php" },
  },
  indent = {
    enable = true,
    disable = {
      "yaml"
    }
  }
}
