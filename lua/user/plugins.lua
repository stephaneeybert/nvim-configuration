local fn = vim.fn

-- Automatically install the packer plugin manager
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer, closing and reopening Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Load packer
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Synchronize the plugins when saving the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Show packer messages in a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- The list of plugins
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Commons plugins used by other plugins
  use "nvim-lua/popup.nvim"          -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"        -- Useful lua functions used by lots of plugins
  use "kyazdani42/nvim-web-devicons" -- Icons for the file types
  use "antoinemadec/FixCursorHold.nvim"

  -- Startup screen
  --   use "startup-nvim/startup.nvim"
  use "goolord/alpha-nvim"

  -- Escaping the Insert mode
  use "max397574/better-escape.nvim"

  -- Nice notifications
  use "rcarriga/nvim-notify"

  -- A nicer status line -- vim-airline/vim-airline -- feline-nvim/feline.nvim TODO try it some day
  use "nvim-lualine/lualine.nvim"

  -- Color scheme
  use "andreasvc/vim-256noir"
  use "rafi/awesome-vim-colorschemes"
  use "catppuccin/nvim"

  -- Snippet engine and collections
  use "L3MON4D3/LuaSnip"             -- A snippet engine
  use "rafamadriz/friendly-snippets" -- A ton of snippets for different languages

  -- Various
  use "phaazon/hop.nvim"                -- Hop to lines or words
  use "jbyuki/instant.nvim"
  use "folke/which-key.nvim"            -- Help popup with all the keymaps
  use "windwp/nvim-autopairs"           -- Automatic add closing characters to opening ones () {} "" ''
  use "xiyaowong/nvim-cursorword"       -- Highlight the current word
  use "bronson/vim-trailing-whitespace" -- Highlight trailing whitespaces
  use "norcalli/nvim-colorizer.lua"     -- Colorize color codes

  -- Handling buffers and tabs in a line above windows
  use {
    "akinsho/bufferline.nvim",
    tag = "v3.*",
    requires = "nvim-tree/nvim-web-devicons"
  }
  use "moll/vim-bbye"    -- keep windows when closing buffers
  use "matbme/JABS.nvim" -- a buffer switcher in a popup window

  -- File tree explorer
  use {
    "nvim-neo-tree/neo-tree.nvim",
    requires = {
      "MunifTanjim/nui.nvim"
    }
  }

  -- Show diagnostics, references, search results, etc.. in a list
  use "folke/trouble.nvim"

  -- Auto completion
  use "hrsh7th/nvim-cmp"         -- The completion plugin
  use "hrsh7th/cmp-buffer"       -- with buffer completions
  use "hrsh7th/cmp-path"         -- with path completions
  use "hrsh7th/cmp-cmdline"      -- with cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- with snippet completions
  use "hrsh7th/cmp-nvim-lsp"     -- LSP integration

  -- Telescope - searching for files and patterns
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "BurntSushi/ripgrep",
      "sharkdp/fd",
      "nvim-telescope/telescope-github.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    }
  }
  use {
    "nvim-telescope/telescope-frecency.nvim",
    requires = {
      "tami5/sqlite.lua"
    }
  }

  -- Git integration
  use "lewis6991/gitsigns.nvim"
  use "kdheepak/lazygit.nvim"

  -- Treesitter -- DOM parsing languages
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "nvim-treesitter/playground"

  -- LSP - adding language capabilities:
  -- Go-to-definition Find-references Hover Completion Rename Format RefactorExtract
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use "hrsh7th/cmp-nvim-lua"
  use "mfussenegger/nvim-jdtls"

  -- Source code formatting and linting
  use "jose-elias-alvarez/null-ls.nvim"

  -- Semantic highlighting on names
  use "jaxbot/semantic-highlight.vim"

  -- Adding comments
  use "numToStr/Comment.nvim"
  -- Switching the comment prefix based on the language
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Viewing log files
  use "andreshazard/vim-logreview"

  -- Running tests
  --  use "David-Kunz/jester"
  use "nvim-neotest/neotest"
  use "nvim-neotest/neotest-vim-test"
  use "vim-test/vim-test"

  -- Debugger
  use "mfussenegger/nvim-dap"
  use "theHamsta/nvim-dap-virtual-text"
  use "rcarriga/nvim-dap-ui"
  use "nvim-telescope/telescope-dap.nvim"

  -- Automatically sync all the configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
