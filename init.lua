-- Vim options
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.termguicolors = true

vim.opt.signcolumn = "yes"

vim.opt.number = true
vim.opt.relativenumber = true

-- vim.opt.laststatus = 3

vim.opt.updatetime = 250

-- Plugins
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

require("lazy").setup({

})
