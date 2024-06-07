-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation (choose either 2 or 4 based on your preference)
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Turn off swapfile and backup
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Key pressed speed
opt.timeoutlen = 500

-- Search enhancements
opt.incsearch = true
opt.hlsearch = true

-- Set the backspace for deletion
opt.backspace = "indent,eol,start"

-- Show color column
vim.wo.colorcolumn = "80"

-- Enable mouse for scrolling and re sizing
opt.mouse = "a"

-- Enhancements for user interface and interaction
opt.visualbell = true
opt.title = true
opt.history = 1000
opt.showcmd = true
opt.showmode = true
opt.autoread = true
opt.hidden = true
opt.laststatus = 2
opt.ruler = true
opt.wildmenu = true
opt.pumblend = 17
opt.wildmode = "longest:full"
opt.wildoptions = "pum"
opt.wildignore = "*.swp,*.bak,.git,*.pyc"
opt.tabpagemax = 40
opt.textwidth = 80
opt.linebreak = true
opt.scrolloff = 3
opt.sidescrolloff = 5

-- Persistent undo
local undodir = vim.fn.expand("~/.config/nvim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir
vim.opt.undofile = true

-- Set spelling
opt.spell = true
