local opts = { silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c",


-- Normal mode --

-- Move to position 0 instead of to the first character of the line
keymap("n", "^", "0", opts)

-- Redo after an undo
keymap("n", "<S-u>", ":redo<CR>", opts)

-- Keep search matches in the middle of the window
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Clear search matches
keymap("n", "<A-n>", ":noh<CR>", opts)

-- Toggle (relative) numbers
keymap("n", "<leader>ln", "<Esc>:set number<CR>", opts)
keymap("n", "<leader>rln", "<Esc>:set relativenumber<CR>", opts)
keymap("n", "<leader>nrln", "<Esc>:set norelativenumber<CR>", opts)
keymap("n", "<leader>nln", "<Esc>:set norelativenumber<CR>:set nonumber<CR>", opts)

-- Easier split window navigation, avoiding the w character
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize window with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)

-- Move text up and down
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)

-- Navigate buffers
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-b>", ":JABSOpen<CR>", opts)

-- Hopping to locations
keymap("n", "<leader>hl", "<cmd>HopLine<CR>", opts)
keymap("n", "<leader>hw", "<cmd>HopWord<CR>", opts)
keymap("n", "<leader>hp", "<cmd>HopPattern<CR>", opts)

-- Toggling the file tree explorer
keymap("n", "<leader>e", ":NeoTreeFocusToggle<CR>", opts)

-- Semantic highlighting
keymap("n", "<leader>sh", "<cmd>SemanticHighlightToggle<CR>", opts)

-- Search with Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
-- keymap("n", "<leader>ff", "<cmd>lua require 'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>", opts)
keymap("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fp", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<Cr>", opts)
keymap("n", "<leader>dl", "<cmd>Telescope diagnostics<CR>", opts) -- diagnostics list to show the list of issues

-- Gitsigns
keymap("n", "<leader>gv", "<cmd>Gitsigns preview_hunk<CR>", opts) -- show the git change
keymap("n", "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>", opts) -- show the git change
keymap("n", "<leader>gn", "<cmd>Gitsigns next_hunk<CR>", opts) -- show the git change
keymap("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", opts) -- show the git change
keymap("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", opts) -- show the git change
keymap("n", "<leader>ga", "<cmd>Gitsigns blame_line<CR>", opts) -- show the git change

-- Formatting the source code
keymap("n", "<leader>ft", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
-- Removing extra blank lines
keymap("n", "<leader>fl", "<cmd>lua require('lua.user.commands').consolidate_blank_lines()<CR>", opts)

-- Closing and quitting
keymap("n", "<A-w>", "<Esc>:Bwipeout<CR>", opts)
keymap("n", "<A-q>", "<Esc>:qa<CR>", opts)

-- Toggling the troubles list
keymap("n", "<leader>tr", "<cmd>TroubleToggle document_diagnostics<CR>", opts)

-- Debugger
keymap("n", "<F9>", "<cmd>lua require'dap'.continue()<CR>")
keymap("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>")
keymap("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>")
keymap("n", "<F12>", "<cmd>lua require'dap'.step_out()<CR>")
keymap("n", "<leader>dbu", "<cmd>lua require'dapui'.toggle()<CR>")
keymap("n", "<leader>dbe", "<cmd>lua require'dapui'.eval()<CR>")
keymap("n", "<leader>dbb", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
keymap("n", "<leader>dbc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
keymap("n", "<leader>dbe", "<cmd>lua require'dap'.set_exception_breakpoints({'all'})<CR>")
keymap("n", "<leader>dbm", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ''))<CR>")
keymap("n", "<leader>dbd", "<cmd>lua require'dap'.clear_breakpoints()<CR>")
keymap("n", "<leader>dbx", "<cmd>lua require'dap'.run_to_cursor()<CR>")
keymap("n", "<leader>dbk", "<cmd>lua require'dap'.up()<CR>")
keymap("n", "<leader>dbj", "<cmd>lua require'dap'.down()<CR>")
keymap("n", "<leader>dbq", "<cmd>lua require'dap'.terminate()<CR>")
keymap("n", "<leader>dbr", "<cmd>lua require'dap'.repl.toggle({}, 'vsplit')<CR><C-w>l")
keymap("n", "<leader>dbl", "<cmd>lua require'dap'.repl.run_last()<CR>")
-- UI
-- keymap("n", "<leader>dsc", "<cmd>lua require'dap.ui.variables'.scopes()<CR>")
-- keymap("n", "<leader>dhh", "<cmd>lua require'dap.ui.variables'.hover()<CR>")
-- keymap("v", "<leader>dhv", "<cmd>lua require'dap.ui.variables'.visual_hover()<CR>")
-- keymap("n", "<leader>duh", "<cmd>lua require'dap.ui.widgets'.hover()<CR>")
-- From within Telescope
keymap("n", "<leader>Dcc", "<cmd>lua require'telescope'.extensions.dap.commands{}<CR>")
keymap("n", "<leader>Dco", "<cmd>lua require'telescope'.extensions.dap.configurations{}<CR>")
keymap("n", "<leader>Dlb", "<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>")
keymap("n", "<leader>Dv", "<cmd>lua require'telescope'.extensions.dap.variables{}<CR>")
keymap("n", "<leader>Df", "<cmd>lua require'telescope'.extensions.dap.frames{}<CR>")

-- Debugging tests
keymap("n", "<leader>tdt", "<cmd>lua require('neotest').run.run({strategy = 'dap'})") -- debugging the nearest test
keymap("n", "<leader>tdt", "<cmd>lua require('neotest').run.run_last({strategy = 'dap'})") -- debugging again the last run test

-- Running tests
keymap("n", "<leader>trt", "<cmd>lua require('neotest').run.run()<CR>") -- running the nearest test
keymap("n", "<leader>trl", "<cmd>lua require('neotest').run.run_last()<CR>") -- running again the last run test
keymap("n", "<leader>trf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>") -- running all the tests of the file
keymap("n", "<leader>tst", "<cmd>lua require('neotest').run.stop('0')<CR>") -- stopping the nearest test
keymap("n", "<leader>tra", "<cmd>lua require('neotest').run.attach()<CR>") -- attaching to the nearest test
keymap("n", "<leader>tsu", "<cmd>lua require('neotest').summary.toggle()<CR>") -- viewing the test summary


-- Insert mode --

-- Press jk fast to escape the mode
keymap("i", "jk", "<ESC>", opts)


-- Visual mode --

-- Stay in indent mode after visual block indentation
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Press jk fast to escape the mode
keymap("v", "jk", "<ESC>", opts)

-- Move text up and down
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)

-- Keep the first yanked content after pasting
keymap("v", "p", '"_dP', opts)


-- Visual Block mode --

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)


-- Terminal mode --

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


-- Command mode --

-- keymap("c", "", "", opts)
