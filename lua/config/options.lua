-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.colorcolumn = "88"
vim.opt.mouse = ""

vim.diagnostic.config({ virtual_text = false })

vim.diagnostic.show(nil, nil, nil, { virtual_text = false })
vim.diagnostic.hide()
