local group = vim.api.nvim_create_augroup('user_cmds', {clear = true})
vim.api.nvim_create_augroup('AutoFormat', {clear = true})

vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight on yank',
    group = group,
    callback = function()
        vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'help', 'man'},
    group = group,
    command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

vim.api.nvim_create_autocmd('VimLeavePre', {
    group = group,
    command = "Neotree close"
}
)


-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_augroup("AutoFormat", {})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  group = "AutoFormat",
  callback = function()
    vim.cmd("silent !ruff --quiet %")
    vim.cmd("edit")
  end,
})

vim.api.nvim_create_augroup("lspAutocmd", {})

function OpenDiagnosticIfNoFloat()
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then
      return
    end
  end
  -- THIS IS FOR BUILTIN LSP
  vim.diagnostic.open_float({
    scope = "cursor",
    focusable = false,
    close_events = {
      "CursorMoved",
      "CursorMovedI",
      "BufHidden",
      "InsertCharPre",
      "WinLeave",
    },
  })
end

vim.api.nvim_create_autocmd("CursorHold", {
  group = "lspAutocmd",
  callback = function()
    OpenDiagnosticIfNoFloat()
    vim.diagnostic.show(nil, nil, nil, { virtual_text = false })
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = "lspAutocmd",
  callback = function()
    vim.diagnostic.enable()
    vim.diagnostic.show(nil, nil, nil, { virtual_text = false })
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  group = "lspAutocmd",
  callback = function()
    vim.diagnostic.hide()
    vim.diagnostic.enable(false)
  end,
})

vim.api.nvim_create_augroup("AutoFormat", {clear = true})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = "AutoFormat",
    pattern = "*.py",
    callback = function ()
        vim.cmd('silent !python3 -m isort format %')
        vim.cmd('silent !python3 -m ruff format %')
        vim.cmd('edit')
        vim.cmd('w')
    end
})

vim.api.nvim_create_autocmd({"TextChangedI", "TextChangedP"}, {
    group = "lspAutocmd",
    pattern = "*",
    callback = function ()
        vim.lsp.buf.signature_help()
    end
} )

vim.api.nvim_create_augroup("TerminalAutoInsert", {clear = true})
vim.api.nvim_create_autocmd({"TermEnter"}, {
    group = "TerminalAutoInsert",
    pattern = "*",
    callback = function ()
        vim.cmd("startinsert")
    end
})

--
--
-- User commands 
--
--

