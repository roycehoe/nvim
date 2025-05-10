return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            sections = {
                lualine_a = {
                    {
                        'filename',
                        path = 1,                -- 0: Just the filename
                        shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                        -- for other components. (terrible name, any suggestions?)
                    }
                }
            }

        })
    end
}
