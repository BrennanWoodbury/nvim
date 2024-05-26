local Plugin = {'neovim/nvim-lspconfig'}
local user = {}

Plugin.dependencies =  {
    {'hrsh7th/cmp-nvim-lsp'},
    {'williamboman/mason-lspconfig.nvim'},
}

Plugin.cmd = {'LspInfo', 'LspInstall', 'LspUnInstall'}

Plugin.event = {'BufReadPre', 'BufNewFile'}

function Plugin.init()
    local sign = function(opts)
        -- See :help sign_define()
        vim.fn.sign_define(opts.name, {
            texthl = opts.name,
            text = opts.text,
            numhl = ''
        })
    end

    sign({name = 'DiagnosticSignError', text = '✘'})
    sign({name = 'DiagnosticSignWarn', text = '▲'})
    sign({name = 'DiagnosticSignHint', text = '⚑'})
    sign({name = 'DiagnosticSignInfo', text = '»'})

    -- See :help vim.diagnostic.config()
    vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        float = {
            border = 'rounded',
            source = 'always',
        },
    })

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = 'rounded'}
    )

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {focusable = false},
    {hide_related_information = true}
    )
end

function Plugin.config()
    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- get python path
    local function get_python_path()
        local venv_path = os.getenv('VIRTUAL_ENV')
        if venv_path then
            return venv_path .. '/bin/python'
        else
            return '/usr/bin/python'  -- or any other default Python path
        end
    end

    local group = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})

    vim.api.nvim_create_autocmd('LspAttach', {
        group = group,
        desc = 'LSP actions',
        callback = user.on_attach
    })


    local lspconfig = require('lspconfig')

    -- Function to display Python interpreter path
    local function show_python_path()
        -- Get the active client for the current buffer
        local clients = vim.lsp.buf_get_clients()
        for _, client in pairs(clients) do
            if client.name == 'pyright' or client.name == 'pylyzer' then
                local python_path = client.config.settings.python.pythonPath
                if python_path then
                    print('Python Path: ' .. python_path)
                else
                    print('Python Path not set in LSP settings')
                end
                return
            end
        end
        print('No active Python LSP client found')
    end

    -- Create a command to call the function
    vim.api.nvim_create_user_command('ShowPythonPath', show_python_path, {})

    -- See :help mason-lspconfig-settings
    require('mason-lspconfig').setup({
        ensure_installed = {
            'eslint',
            'tsserver',
            'html',
            'cssls',
            'lua_ls',
            'ruff_lsp',
        },
        handlers = {
            -- See :help mason-lspconfig-dynamic-server-setup
            function(server)
                -- See :help lspconfig-setup
                lspconfig[server].setup({
                    capabilities = lsp_capabilities,
                })
            end,
            ['tsserver'] = function()
                lspconfig.tsserver.setup({
                    capabilities = lsp_capabilities,
                    settings = {
                        completions = {
                            completeFunctionCalls = true
                        }
                    }
                })
            end,
            ['ruff_lsp'] = function ()
                require("lspconfig").ruff_lsp.setup({
                    capabilities = lsp_capabilities,
                    settings = {
                        python = {
                            pythonPath = get_python_path(),
                        },
                        init_options = {
                            settings = {
                                lint = {
                                    run = "onSave",
                                    args = {},
                                },
                            }
                        }
                    }
                })
            end,
            ['basedpyright'] = function ()
                require("lspconfig").basedpyright.setup({
                    capabilities = lsp_capabilities,
                    python = {
                        settings = {
                            analysis = {
                                typeCheckingMode = "off",
                                autoSearchPaths = false,
                                diagnosticMode = 'openFilesOnly',
                                useLibraryCodeForTypes = false,
                                loglevel = 'error',
                            }
                        },
                    },

                    handlers = {
                        ['textDocument/publishDianostics'] = function() end
                    }
                }) 
            end,
            ['pylyzer'] = function ()
                require("lspconfig").pylyzer.setup({
                    capabilities = lsp_capabilities,
                    settings = {
                            python = {--pythonPath = get_python_path(),
                            analysis = {
                                typeCheckingMode = "off",
                                autoSearchPaths = false,
                                diagnosticMode = 'openFilesOnly',
                                useLibraryCodeForTypes = false,
                                loglevel = 'error',
                            }
                        }

                  },
                    handlers = {
                        ['textDocument/publishDianostics'] = function() end
                    }
                }) 
            end,



            ['lua_ls'] = function()
                require('plugins.lsp.lua_ls')
            end
        }
    })
end

function user.on_attach()
    local bufmap = function(mode, lhs, rhs)
        local opts = {buffer = true}
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- You can search each function in the help page.
    -- For example :help vim.lsp.buf.hover()

    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
end

return Plugin

