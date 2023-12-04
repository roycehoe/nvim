vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- [p]roject [v]iew
vim.keymap.set("n", "<leader>gs", vim.cmd.Git) --[g]et [s]tatus
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle) --[g]et [s]tatus

vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help) --[s]ignature
vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help) --[s]ignature
