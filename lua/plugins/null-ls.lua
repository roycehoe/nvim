return {
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
}

