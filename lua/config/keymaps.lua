-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "yy", "+yy", { noremap = true, silent = true })
vim.keymap.set("v", "y", "+y", { noremap = true, silent = true })

vim.keymap.set("n", "p", "+p", { noremap = true, silent = true })
vim.keymap.set("v", "p", "+p", { noremap = true, silent = true })

-- Set leader
vim.g.mapleader = " "

-- Vim Options
vim.opt.number = true
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.mouse = nv
vim.opt.colorcolumn = "88"
vim.opt.incsearch = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.wildmode = { "longest", "list" }
vim.opt.cursorline = true
vim.opt.ttyfast = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.showtabline = 1

--vim.cmd("highlight Pmenu ctermbg=DarkGrey ctermfg=LightGrey guibg=Purple")
--vim.cmd('highlight NormalFloat ctermbg=DarkGrey ctermfg=LightGrey guibg=LightGrey')
--vim.cmd('highlight MasonNormal ctermbg=DarkGrey ctermfg=LightGrey')
--vim.cmd('highlight MasonHeader ctermbg=LightBlue ctermfg=White')

vim.cmd([[
highlight LspDiagnosticsDefaultError ctermfg=LightGrey guifg=#db4b4b
highlight LspDiagnosticsDefaultWarning ctermfg=LightGrey guifg=#e0af68
highlight LspDiagnosticsDefaultInformation ctermfg=LightGrey guifg=#0db9d7
highlight LspDiagnosticsDefaultHint ctermfg=LightGrey guifg=#10b981
]])

vim.keymap.set("n", "<leader>1", "1gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>2", "2gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>3", "3gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>4", "4gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>5", "5gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>6", "6gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>7", "7gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>8", "8gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>9", "9gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>0", ":tablast<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-1>", ":b1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-2>", ":b2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-3>", ":b3<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-4>", ":b4<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-5>", ":b5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-6>", ":b6<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-7>", ":b7<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-8>", ":b8<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-9>", ":b9<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-0>", ":b0<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<A-b>", ":buffers<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<A-]>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-[>", ":blast<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-q>", ":bdelete<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>]", ":tnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>[", ":tlast<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", ":tdelete<CR>", { noremap = true, silent = true })

vim.keymap.set("i", "<C-CR>", "<C-n>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-CR>", "<C-n>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>nt", ":NERDTree<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ut", ":UndotreeToggle<CR>", { noremap = true, silent = true })

vim.keymap.set("t", "<Esc>", "<C-/><C-n>", { noremap = true, silent = true })

vim.keymap.set("n", "<A-.>", "<C-w>>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-,>", "<C-w><", { noremap = true, silent = true })
vim.keymap.set("n", "<A-/>", ":horizontal resize +1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-'>", ":horizontal resize -1<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<A-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<A-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<A-l>", "<C-w>l", { noremap = true, silent = true })

vim.keymap.set("n", "<C-b>", ":!black %", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>hl", ":nohl<CR>", { noremap = true, silent = true })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>cp", ":Copilot toggle<CR>", { noremap = true, silent = true })
