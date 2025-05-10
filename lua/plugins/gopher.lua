return {
    {
        "olexsmir/gopher.nvim",
        config = function()
            -- Define Gopher (Go development) key mappings directly
        end,
        build = function()
            -- Automatically install Go dependencies when setting up the plugin
            vim.cmd [[silent! GoInstallDeps]]
        end
    },
}
