return {
    -- 'gbprod/nord.nvim',
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- vim.cmd[[colorscheme nord]]
        -- Transparent bg lets tmux dim inactive panes through nvim (see ~/.tmux/.tmux.conf).
        require 'nordic' .load({ transparent = { bg = true } })
    end
}
