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
    config = function()
        local lsp_zero = require('lsp-zero')

        lsp_zero.on_attach(function(_, bufnr)
            lsp_zero.default_keymaps({ buffer = bufnr })
        end)

        -- Mason: install servers, but don't auto-enable (we'll enable explicitly below).
        require('mason-lspconfig').setup({
            ensure_installed = { 'gopls', 'ltex', 'lua_ls', 'vtsls', 'ruff' },
            automatic_enable = false,
        })

        -- gopls
        vim.lsp.config('gopls', {
            settings = {
                gopls = {
                    usePlaceholders = true,
                    analyses = { unusedparams = true },
                },
            },
        })
        vim.lsp.enable('gopls')

        -- ltex
        vim.lsp.config('ltex', {
            settings = {
                ltex = { language = "en-GB" },
            },
        })
        vim.lsp.enable('ltex')

        -- lua_ls
        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    diagnostics = { globals = { 'vim' } },
                },
            },
        })
        vim.lsp.enable('lua_ls')

        -- vtsls (disable formatting)
        vim.lsp.config('vtsls', {
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
                lsp_zero.default_keymaps({ buffer = bufnr })
            end,
        })
        vim.lsp.enable('vtsls')

        -- ruff (replace ruff_lsp)
        -- ruff_lsp is deprecated; use ruff (native `ruff server`). :contentReference[oaicite:3]{index=3}
        vim.lsp.config('ruff', {
            init_options = {
                settings = {
                    args = {},
                },
            },
        })
        vim.lsp.enable('ruff')
    end

}
