-- [[ Vim options ]]
-- :help vim.opt or :help option-list

-- NOTE: Must map leader before plugins are loaded for correct <leader> to map
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.guicursor = ""

vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus" --sync clipboard between OS and Nvim

vim.opt.breakindent = true

-- Disabled to avoid cluttering directory
-- vim.opt.swapfile = false
-- vim.opt.backup = false

-- used when swap-files are active
vim.opt.updatetime = 250

vim.opt.undofile = true
vim.opt.hidden = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8

-- Decrease mapped sequence wait time (debounce)
-- Displays which-key popup sooner
--vim.opt.timeoutlen = 300

-- Screen splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how nvim will display certain whitespace characters in the editor
vim.opt.list = true
vim.opt.listchars = { tab = "| ", trail = "·", nbsp = "␣" }

-- Live preview substitutions as you type
-- vim.opt.inccommand = 'split'
vim.opt.hlsearch = false

vim.opt.cursorline = true

-- Tabs (can be overwritten by vim-sleuth plugin)
vim.opt.tabstop = 4 -- columns per \t
vim.opt.softtabstop = 4 -- columns per tab or backspace
vim.opt.shiftwidth = 4 -- columns per "level of indentation"
vim.opt.expandtab = true -- \t character become spaces
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.fileformat = "unix"
vim.opt.termguicolors = true
vim.opt.syntax = "off"
