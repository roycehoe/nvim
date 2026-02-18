vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- [p]roject [v]iew
vim.keymap.set('n', '<leader>pf', function() require('telescope.builtin').find_files({
}) end) -- [p]roject [f]ind
vim.keymap.set('n', '<leader>pg', function() require('telescope.builtin').git_files() end) -- [p]roject [g]it
vim.keymap.set('n', '<leader>ps', function() require('telescope.builtin').live_grep() end) -- [p]roject [s]earch

vim.keymap.set("n", "<leader>gs", vim.cmd.Git) --[g]it [s]tatus
vim.keymap.set("n", "<leader>gl", ":Git log<CR>") --[g]it [l]og
vim.keymap.set("n", "<leader>gp", ":Git push<CR>") --[g]it [p]ush
vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<cr>") -- [g]it [b]lame
vim.keymap.set("n", "<leader>gr", "<cmd>Telescope git_branches<CR>") -- [g]it [b]lame

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle) --[u]ndo tree toggle

vim.keymap.set('n', 'gd', vim.lsp.buf.definition) -- [g]o to [d]efinition
vim.keymap.set('n', 'gD', function() require('telescope.builtin').lsp_references(
    {

    -- use fd to "find files" and return absolute paths
	find_command = { "fd", "-t=f", "-a" },
	path_display = { "absolute" },
        wrap_results = true
    }


) end) -- [g]o to all [D]efinitions
vim.keymap.set('n', 'gs', vim.lsp.buf.hover) -- [g]et [s]ignature
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation) -- [g]et [i]mplementation
vim.keymap.set('n', 'gr', vim.lsp.buf.references) -- [g]et [r]eferences

vim.keymap.set('n', '<leader>ss', function() require('telescope.builtin').lsp_document_symbols() end) -- [s]earch [s]ymbol
vim.keymap.set("n", "<leader>w", ":nnoremap <silent> <c-c> :if (&hlsearch == 1) | set nohlsearch | else | set hlsearch | endif<cr>") -- [w]ord highlight all
vim.keymap.set("n", "<leader>hf", function() require("harpoon.ui").toggle_quick_menu() end ) -- [h]arpoon [f]iles
vim.keymap.set("n", "<leader>ha", function() require("harpoon.mark").add_file() end ) -- [h]arpoon [a]dd
vim.keymap.set("n", "<leader>hj", function() require("harpoon.ui").nav_next() end ) -- [h]arpoon nav next [vim bindings]
vim.keymap.set("n", "<leader>hk", function() require("harpoon.ui").nav_prev() end ) -- [h]arpoon nav prev [vim bindings]
vim.keymap.set({"x", "s"}, "<c-_>", "<plug>Commentary", { noremap = true }) -- comment out line
vim.keymap.set("n", "<c-_>", "<plug>CommentaryLine", { noremap = true }) -- comment out line

-- debugger
vim.keymap.set('n', '<f5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end)
vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

-- gopher mappings
vim.api.nvim_set_keymap('n', '<leader>json', '<cmd>GoTagAdd json<CR>', {noremap = true, silent = true, desc = 'Add json struct tags' })
vim.api.nvim_set_keymap('n', '<leader>yaml', '<cmd>GoTagAdd yaml<CR>', {noremap = true, silent = true, desc = 'Add yaml struct tags'})

-- Window navigation mappings
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', { silent = true })
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', { silent = true })
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', { silent = true })
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', { silent = true })
