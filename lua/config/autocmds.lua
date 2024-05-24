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

local lspns = vim.api.nvim_create_namespace("CustomLspConfig")
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
    vim.diagnostic.disable()
  end,
})
