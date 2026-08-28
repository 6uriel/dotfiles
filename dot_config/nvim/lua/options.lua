vim.opt.mouse = ""

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 4
vim.opt.cmdheight = 0
vim.opt.laststatus = 0

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.autoread = true
vim.opt.autowrite = false

vim.opt.errorbells = false
vim.opt.iskeyword:append("-")

vim.opt.splitbelow = true
vim.opt.splitright = true

-- check if undodir
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end

vim.opt.fillchars =
{ vert = " ", horiz = " ", horizup = " ", horizdown = " ", vertleft = " ", vertright = " " }

vim.diagnostic.config({
  virtual_text = true,
  signs = false,
})
