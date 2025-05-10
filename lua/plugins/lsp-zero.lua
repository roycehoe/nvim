return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip"
        },
    },
    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets"
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()
            require("luasnip.loaders.from_vscode").lazy_load()

            local cmp = require('cmp')
            local cmp_select = {behavior = cmp.SelectBehavior.Select}

            cmp.setup({
                snippet = {
                    expand = function (args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = 'luasnip'},
                    { name = 'nvim_lsp'},
                })
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'williamboman/mason-lspconfig.nvim'},
        },
        opts = {
            inlay_hints = { enabled = true },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()
            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({buffer = bufnr})
            end)

            require('mason-lspconfig').setup({
                ensure_installed = {'gopls'},
                handlers = {
                    lsp_zero.default_setup,
                }
            })
            require('lspconfig')['gopls'].setup({
                settings = {
                    gopls = {
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        },
                    },
                },
            })
            require('lspconfig')['ltex'].setup({
                settings = {
                    ltex = {
                        language = "en-GB",
                    },
                },
            })
            require('lspconfig')['lua_ls'].setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                },
            })
            require('lspconfig')['eslint'].setup({
                on_attach = function(client, bufnr)
                    -- LSP keymaps and autocmd to fix on save
                    lsp_zero.default_keymaps({buffer = bufnr})
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
                settings = {
                    codeActionOnSave = {
                        enable = true,
                        mode = "all",
                    },
                    format = true,
                    run = "onType",
                },
            })
            require('lspconfig')['ruff_lsp'].setup({
                init_options = {
                    settings = {
                        args = {},
                    }
                }
            })
        end
    },
}
