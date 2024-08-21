vim.g.mapleader = " "

local opt = vim.opt

-- UI/General
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.cursorline = false
opt.termguicolors = true
opt.confirm = true
opt.mouse = "a"
opt.undofile = true
opt.swapfile = false
opt.conceallevel = 1
opt.scrolloff = 12
opt.wrap = true
opt.linebreak = true
opt.spelllang = "en_nz"
opt.showtabline = 0

-- Set tab width
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.expandtab = true
