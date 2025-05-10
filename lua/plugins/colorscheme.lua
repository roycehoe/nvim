return {
    -- 'gbprod/nord.nvim',
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- vim.cmd[[colorscheme nord]]
         require 'nordic' .load()
    end
}
