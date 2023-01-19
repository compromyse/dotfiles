-- General Settings
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.keymodel = 'startsel','stopsel'
vim.opt.termguicolors = true
vim.opt.ww = "<,>,[,]"

-- Setup Packages
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'navarasu/onedark.nvim'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'jiangmiao/auto-pairs'
	use 'kyazdani42/nvim-tree.lua'
	use 'editorconfig/editorconfig-vim'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/vim-vsnip'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'mhinz/vim-startify'

	use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

	use {
	'nvim-lualine/lualine.nvim',
	requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'}}
	}
	use {
		'numToStr/Comment.nvim',
		config = function()
		require('Comment').setup()
		end
	}
	if install_plugins then
		require('packer').sync()
	end
end)

if install_plugins then
  return
end

--Keymaps

vim.keymap.set('n', ',,', '<cmd>NvimTreeToggle<cr>')
vim.keymap.set('n', '<space><space>', '<cmd>Telescope buffers<cr>')

vim.keymap.set('n', 'nn', '<cmd>bnext<cr>')
vim.keymap.set('n', 'bb', '<cmd>bprev<cr>')

vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
vim.keymap.set('n', 'C-k', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
vim.keymap.set('n', 'C-p', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', 'C-n', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>')

vim.keymap.set('n', 'tt', '<cmd>tab ter<cr>')

require('onedark').setup {
	style = 'warmer'
}
require('onedark').load()

require('lualine').setup {
	options = {
		theme = 'onedark'
	}
}

require('bufferline').setup {
  options = {
    mode = 'buffers',
    offsets = {
      {filetype = 'NvimTree'}
    },
  },
  highlights = {
    buffer_selected = {
      italic = false
    },
    indicator_selected = {
      fg = {attribute = 'fg', highlight = 'Function'},
      italic = false
    }
  }
}

require('indent_blankline').setup {
  char = '▏',
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  show_current_context = false
}

require('Comment').setup {
	padding = true,
		toggler = {
			line = '..'
		}
}

-- Nvim-Tree Setup
require('nvim-tree').setup {
  hijack_cursor = false,
  on_attach = function(bufnr)
    local bufmap = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, {buffer = bufnr, desc = desc})
    end

    local api = require('nvim-tree.api')
    bufmap('L', api.node.open.edit, 'Expand folder or go to file')
    bufmap('H', api.node.navigate.parent_close, 'Close parent folder')
    bufmap('gh', api.tree.toggle_hidden_filter, 'Toggle hidden files')
  end
}

-- CMP Setup
local cmp = require'cmp'
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<TAB>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
	}, {
		{ name = 'buffer' },
	})
})
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' },
	}, {
		{ name = 'buffer' },
	})
})
cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
})
cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{ name = 'cmdline' }
		})
})

-- Set Up Lspconfig
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['pyright'].setup {
	capabilities = capabilities
}

-- Reset Cursor On Exit
local au_id = vim.api.nvim_create_augroup("RestoreCursorShapeOnExit", {clear = true})
vim.api.nvim_create_autocmd("VimLeave",{
  command = 'set guicursor=a:ver20',
  group = au_id
})
