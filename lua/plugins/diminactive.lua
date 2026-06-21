return {
    {
        "blueyed/vim-diminactive",
        init = function()
            -- Also dim when nvim loses focus (e.g. switching tmux panes).
            -- Pairs with `set -g focus-events on` in tmux.
            vim.g.diminactive_enable_focus = 1
        end,
        config = function()
            -- vim-diminactive dims via the ColorColumn highlight; override it
            -- to a clearly darker Nord shade so the dim is visible with nordic.
            -- Re-apply on ColorScheme so the colorscheme can't clobber it.
            local function set_dim_hl()
                vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#191D24" })
            end
            set_dim_hl()
            vim.api.nvim_create_autocmd("ColorScheme", { callback = set_dim_hl })
        end,
    }
}
