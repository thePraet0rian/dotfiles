return { 
	'nvim-telescope/telescope.nvim', 
	tag = '0.1.5', 
	dependencies = { 'nvim-lua/plenary.nvim'},
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<C-o>', builtin.find_files, { desc = 'Telescope find files' })
	end
}
