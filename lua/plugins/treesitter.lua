return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    -- config = function ()
    --     local configs = require("nvim-treesitter.config")
    --     configs.setup({
    --         ensure_installed = {
    --             "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "python", "go"
    --         },
    --         sync_install = false,
    --         highlight = { enable = true },
    --         indent = { enable = true },
    --     })
    -- end
}
