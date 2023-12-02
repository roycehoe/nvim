return {
	'nvim-telescope/telescope.nvim', tag = '0.1.4',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>pf', builtin.find_files, {}) -- [p]roject [f]iles
		vim.keymap.set('n', '<C-p>', builtin.git_files, {}) -- git files
		vim.keymap.set('n', '<leader>ps', function() 
			-- [p]roject [s]earch (with grep)
			builtin.grep_string({ search = vim.fn.input(" Grep > ") }) 
		end)
	end
}
