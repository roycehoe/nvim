-- return {
--     {
--         'VonHeikemen/lsp-zero.nvim',
--         branch = 'v3.x',
--     },
--     {
--         'williamboman/mason.nvim',
--         lazy = false,
--         config = true,
--     },
--     {
--         "L3MON4D3/LuaSnip",
--         dependencies = { "rafamadriz/friendly-snippets",
--             "saadparwaiz1/cmp_luasnip"
--         },
--     },
--     -- Autocompletion
--     {
--         'hrsh7th/nvim-cmp',
--         event = 'InsertEnter',
--         dependencies = {
--             "L3MON4D3/LuaSnip",
--             "rafamadriz/friendly-snippets"
--         },
--         config = function()
--             -- Here is where you configure the autocompletion settings.
--             local lsp_zero = require('lsp-zero')
--             lsp_zero.extend_cmp()
--             require("luasnip.loaders.from_vscode").lazy_load()

--             local cmp = require('cmp')
--             local cmp_select = {behavior = cmp.SelectBehavior.Select}

--             cmp.setup({
--                 snippet = {
--                     expand = function (args)
--                         require('luasnip').lsp_expand(args.body)
--                     end
--                 },
--                 window = {
--                     completion = cmp.config.window.bordered(),
--                     documentation = cmp.config.window.bordered(),
--                 },
--                 mapping = cmp.mapping.preset.insert({
--                     ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
--                     ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
--                     ['<Tab>'] = cmp.mapping.confirm({ select = true }),
--                     ["<C-Space>"] = cmp.mapping.complete(),
--                 }),
--                 sources = cmp.config.sources({
--                     { name = 'luasnip'},
--                     { name = 'nvim_lsp'},
--                 })
--             })
--         end
--     },

--     -- LSP
--     config = function()
--         local lsp_zero = require('lsp-zero')

--         lsp_zero.on_attach(function(_, bufnr)
--             lsp_zero.default_keymaps({ buffer = bufnr })
--         end)

--         -- Mason: install servers, but don't auto-enable (we'll enable explicitly below).
--         require('mason-lspconfig').setup({
--             ensure_installed = { 'gopls', 'ltex', 'lua_ls', 'vtsls', 'ruff' },
--             automatic_enable = false,
--         })

--         -- gopls
--         vim.lsp.config('gopls', {
--             settings = {
--                 gopls = {
--                     usePlaceholders = true,
--                     analyses = { unusedparams = true },
--                 },
--             },
--         })
--         vim.lsp.enable('gopls')

--         -- ltex
--         vim.lsp.config('ltex', {
--             settings = {
--                 ltex = { language = "en-GB" },
--             },
--         })
--         vim.lsp.enable('ltex')

--         -- lua_ls
--         vim.lsp.config('lua_ls', {
--             settings = {
--                 Lua = {
--                     diagnostics = { globals = { 'vim' } },
--                 },
--             },
--         })
--         vim.lsp.enable('lua_ls')

--         -- vtsls (disable formatting)
--         vim.lsp.config('vtsls', {
--             on_attach = function(client, bufnr)
--                 client.server_capabilities.documentFormattingProvider = false
--                 client.server_capabilities.documentRangeFormattingProvider = false
--                 lsp_zero.default_keymaps({ buffer = bufnr })
--             end,
--         })
--         vim.lsp.enable('vtsls')

--         -- ruff (replace ruff_lsp)
--         -- ruff_lsp is deprecated; use ruff (native `ruff server`). :contentReference[oaicite:3]{index=3}
--         vim.lsp.config('ruff', {
--             init_options = {
--                 settings = {
--                     args = {},
--                 },
--             },
--         })
--         vim.lsp.enable('ruff')
--     end

-- }
return {
  -- LSP Zero (kept)
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = false,
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- completion deps you already had
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local lsp_zero = require("lsp-zero")

      lsp_zero.on_attach(function(_, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = { "gopls", "ltex", "lua_ls", "vtsls", "ruff" },
        automatic_installation = true,
      })

      -- gopls
      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            usePlaceholders = true,
            analyses = { unusedparams = true },
          },
        },
      })
      vim.lsp.enable("gopls")

      -- ltex
      vim.lsp.config("ltex", {
        settings = {
          ltex = { language = "en-GB" },
        },
      })
      vim.lsp.enable("ltex")

      -- lua_ls
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      -- vtsls (disable formatting)
      vim.lsp.config("vtsls", {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          lsp_zero.default_keymaps({ buffer = bufnr })
        end,
      })
      vim.lsp.enable("vtsls")

      -- ruff (use ruff server; keep formatting ON here)
      vim.lsp.config("ruff", {
        init_options = {
          settings = {
            args = {},
          },
        },
      })
      vim.lsp.enable("ruff")

      -- Optional: format-on-save for Python using Ruff specifically
      local aug = vim.api.nvim_create_augroup("PyFormatRuff", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = aug,
        pattern = "*.py",
        callback = function()
          -- organize imports via ruff if available, then format via ruff
          vim.lsp.buf.code_action({
            context = { only = { "source.organizeImports" } },
            apply = true,
          })
          vim.wait(80)
          vim.lsp.buf.format({
            async = false,
            filter = function(client)
              return client.name == "ruff"
            end,
          })
        end,
      })
    end,
  },

  -- Completion config (keep separate so it’s not nested weirdly)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_cmp()

      require("luasnip.loaders.from_vscode").lazy_load()

      local cmp = require("cmp")
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "luasnip" },
          { name = "nvim_lsp" },
        }),
      })
    end,
  },

  -- none-ls: DO NOT use formatting.ruff here (that builtin isn’t in your install)
  {
    "nvimtools/none-ls.nvim",
    ft = { "go", "python", "typescript", "typescriptreact" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          -- Go formatting
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.goimports_reviser,
          null_ls.builtins.formatting.golines,

          -- Other formatting
          -- null_ls.builtins.formatting.jq,
          null_ls.builtins.formatting.prettier,

          -- Diagnostics
          null_ls.builtins.diagnostics.golangci_lint,
        },
      }
    end,
  },
}

