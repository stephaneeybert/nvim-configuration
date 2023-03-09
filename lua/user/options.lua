local o = vim.opt

-- Display
o.number = true                           -- show line numbers
o.numberwidth = 4                         -- line number column width
o.relativenumber = true                   -- relative numbers
o.showtabline = 2                         -- always show tabs
o.smartindent = true                      -- make indenting smarter again
o.scrolloff = 8                           -- min number of lines in context
o.sidescrolloff = 8                       -- min number of lines in context
o.signcolumn = "yes"                      -- show the sign column
o.showmode = false                        -- seing the mode name like -- INSERT --
o.guifont = "monospace:h17"               -- the font used in graphical neovim applications
o.cursorline = false                      -- highlight the current line
o.syntax = "on"                           -- allow syntax highlighting
o.termguicolors = true                    -- terminal GUI colors
o.pumheight = 10                          -- pop up menu height
o.wrap = false                            -- display lines as one long line
o.whichwrap:remove('b')                   -- backspace key does not go to previous line

-- File
o.backup = false                          -- creates a backup file
o.writebackup = false                     -- if a file is being edited by another program then it is not allowed to be edited
o.swapfile = false                        -- creates a swapfile
o.undofile = false                        -- no undo after file quit
o.encoding = "utf-8"                      -- string encoding
o.fileencoding = "utf-8"                  -- file encoding

-- Search
o.ignorecase = false                      -- ignore case in search patterns
o.smartcase = true                        -- smart case
o.hlsearch = true

-- Whitespace
o.expandtab = true                        -- convert tabs to spaces
o.shiftwidth = 2                          -- the number of spaces inserted for each indentation
o.tabstop = 2

-- Window split
o.splitbelow = true                       -- force all horizontal splits to go below current window
o.splitright = true                       -- force all vertical splits to go to the right of current window

-- Other
o.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
o.cmdheight = 2                           -- more space in the neovim command line for displaying messages
o.completeopt = { "menuone", "noselect" } -- mostly just for cmp
o.conceallevel = 0                        -- have `` is visible in markdown files
o.mouse = "r"                             -- copy paste with the mouse middle button
o.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
o.updatetime = 300                        -- faster completion
o.shortmess:append("c")
o.iskeyword:append("-")                   -- consider the dash character as part of the word
-- o.instant_username = "stephane"        -- my username for the instant collaborative editing plugin TODO fails here - where to set it ?

vim.cmd "highlight MatchParen gui=underline guibg=NONE guifg=NONE"

-- Add the nvim path to the package path so as to be able to use nvim from any directory location
local HOME = os.getenv("HOME")
package.path = HOME .. "/.config/nvim/?.lua;" .. package.path
