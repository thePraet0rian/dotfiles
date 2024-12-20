-- DOTTILES BY thePraet0ria -------------------------------
-- Original Vim Mappings ------------------------

vim.opt.number = true
vim.opt.expandtab = false
vim.opt.tabstop = 4 
vim.opt.softtabstop = 4 
vim.opt.shiftwidth = 4

vim.cmd.nmap "j <LEFT>"
vim.cmd.nmap "k <DOWN>"
vim.cmd.nmap "l <UP>"
vim.cmd.nmap "ö <RIGHT>"
vim.cmd.nmap "<leader>g :noh<CR>"

vim.cmd.vmap "j <LEFT>"
vim.cmd.vmap "k <DOWN>"
vim.cmd.vmap "l <UP>"
vim.cmd.vmap "ö <RIGHT>"

vim.cmd.nmap "<TAB> <C-W><C-W>"
vim.cmd.nmap "<S-TAB> <C-W><S-W>"

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}


-- Lazy Plugins -------------------------------------------

-- Load Lazy ------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


-- Setup lazy.nvim ------------------------------
local lazy = require("lazy")
lazy.setup({
	spec = {
		{ "catppuccin/nvim", name = "catppuccin"},
		{ "nvim-telescope/telescope.nvim", tag="0.1.8", dependencies = {"nvim-lua/plenary.nvim"} },
		{ "nvim-treesitter/nvim-treesitter", build=":TSUpdate"},
		{ "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/vim-vsnip", "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp" } },
		{ "neovim/nvim-lspconfig" },
		{ 'windwp/nvim-autopairs', event = "InsertEnter", config = true },
		{ "williamboman/mason.nvim" }
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})

local catppuccin = require("catppuccin")
catppuccin.setup()
vim.cmd.colorscheme "catppuccin"

local telescope = require("telescope/builtin")
vim.keymap.set("n", "<C-o>", telescope.find_files, {}) 

local treesitter = require("nvim-treesitter.configs")
treesitter.setup({
	ensure_installed = {"lua", "gdscript", "java", "c"},
	highlight = {enable = true},
	indent = {endable = true},
})

local cmp = require('cmp')
cmp.setup({
	snippet = {
      expand = function(args)
        lspconfig.lsp_expand(args.body)
      end,
    },
	mapping = cmp.mapping.preset.insert({
		["<TAB>"] = cmp.mapping.select_next_item(),
		["<S-TAB>"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true}),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer"},
		{ name = "vsnip"},
	},
})

require("lspconfig").gdscript.setup{}
require("mason").setup()

-----------------------------------------------------------
