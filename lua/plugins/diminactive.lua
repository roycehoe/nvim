return {
    {
        "blueyed/vim-diminactive",
        init = function()
            -- Also dim when nvim loses focus (e.g. switching tmux panes).
            -- Pairs with `set -g focus-events on` in tmux.
            vim.g.diminactive_enable_focus = 1
        end,
    }
}
