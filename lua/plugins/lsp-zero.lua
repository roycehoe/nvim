function configure_lsp_zero()
	local lsp_zero = require('lsp-zero')

	lsp_zero.on_attach(function(client, bufnr)
		-- see :help lsp-zero-keybindings
		-- to learn the available actions
		lsp_zero.default_keymaps({buffer = bufnr})
	end)

end

function configure_cmp()
	local cmp = require('cmp')

	local cmp_select = {behavior = cmp.SelectBehavior.Select}
	local cmp_mappings = cmp.mapping.preset.insert({
		['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	})
	cmp.setup({
		mapping = cmp_mappings
	})
end

return {
	{
		{
			'VonHeikemen/lsp-zero.nvim',
			branch = 'v3.x',
		},
		{
			'williamboman/mason.nvim',
			config = true,
		},

		-- Autocompletion
		{
			'hrsh7th/nvim-cmp',
			event = 'InsertEnter',
			dependencies = {
				{'L3MON4D3/LuaSnip'},
			},
			config = function()
				configure_cmp()
			end
		},

		-- LSP
		{
			'neovim/nvim-lspconfig',
			cmd = {'LspInfo', 'LspInstall', 'LspStart'},
			event = {'BufReadPre', 'BufNewFile'},
			dependencies = {
				{'hrsh7th/cmp-nvim-lsp'},
				{'williamboman/mason-lspconfig.nvim'},
			},
			config = function()
				configure_lsp_zero()
			end
		}
	}
}
