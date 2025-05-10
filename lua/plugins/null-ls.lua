return {
  "jose-elias-alvarez/null-ls.nvim",
  ft = {"go", "python", "typescript", "typescriptreact"},
  opts = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local opts = {
      sources = {
        -- Go formatting sources
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.formatting.golines,
        -- Python (and other) formatting sources
        null_ls.builtins.formatting.jq,
        null_ls.builtins.formatting.ruff,    -- ruff handles formatting and (via code action) organizing imports
        null_ls.builtins.formatting.prettier,
        -- Diagnostics
        null_ls.builtins.diagnostics.golangci_lint,
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              -- First, request the code action that organizes imports using ruff.
              -- This is targeted specifically by filtering on the code action kind.
              vim.lsp.buf.code_action({
               context = {
                 only = { "source.organizeImports.ruff" },
               },
                apply = true,
              })
              -- Wait briefly to allow the code action to apply.
              vim.wait(100)
              -- Then trigger formatting.
              vim.lsp.buf.format({ bufnr = bufnr, async = true })
            end,
          })
        end
      end,
    }
    return opts
  end,
}

