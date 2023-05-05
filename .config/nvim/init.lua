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
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.ww = "<,>,[,]"
vim.api.nvim_set_option("clipboard","unnamedplus")
vim.opt.ruler = false

-- Reset Cursor On Exit
local au_id = vim.api.nvim_create_augroup("RestoreCursorShapeOnExit", {clear = true})
vim.api.nvim_create_autocmd("VimLeave",{
  command = 'set guicursor=a:ver20',
  group = au_id
})

-- Setup Packages
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'jiangmiao/auto-pairs'
	use 'kyazdani42/nvim-tree.lua'
  use {
		'numToStr/Comment.nvim',
		config = function()
      require('Comment').setup {
        padding = true,
        toggler = {
          line = '..'
        }
      }
		end
	}

  use 'kvrohit/mellow.nvim'
	use 'mhinz/vim-startify'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }
	use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}

	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/nvim-cmp'
	use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'}}
	}

	if install_plugins then
		require('packer').sync()
	end
end)

if install_plugins then
  return
end

-- Color Scheme
vim.cmd [[colorscheme mellow]]

require('lualine').setup {
  options = {
    section_separators = { left = '', right = '' },
    component_separators = { left = '|', right = '|' }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
  }
}

require('nvim-tree').setup {
  hijack_cursor = true,
  actions = {
    open_file = {
      quit_on_open = true,
    }
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

-- CMP Setup
local cmp = require'cmp'
cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<TAB>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
      { name = 'nvim_lsp' }
    }, {
      { name = 'buffer' },
    }
  )
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
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
servers = { 'pyright' }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities
  }
end

-- Keyboard Shortcuts
vim.keymap.set('n', 'P', '<cmd>pu<cr>', { noremap = true })

vim.keymap.set('n', ',,', '<cmd>NvimTreeToggle<cr>', { noremap = true })
vim.keymap.set('n', '<space><space>', '<cmd>Telescope find_files<cr>', { noremap = true })
vim.keymap.set('n', '<space>b', '<cmd>Telescope buffers<cr>', { noremap = true })
vim.keymap.set('n', '<space>f', '<cmd>Telescope live_grep<cr>', { noremap = true })

vim.keymap.set('n', 'nn', '<cmd>bnext<cr>', { noremap = true })
vim.keymap.set('n', 'bb', '<cmd>bprev<cr>', { noremap = true })
vim.keymap.set('n', 'cw', '<cmd>bdelete!<cr>', { noremap = true })


vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { noremap = true })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true })

vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true })

vim.keymap.set('n', 'tt', '<cmd>tab ter<cr>', { noremap = true })

-- Splitting The Window
vim.api.nvim_set_keymap('n', '<C-x>|', ':vsplit<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-x>-', ':split<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<C-x><Left>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-x><Down>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-x><Up>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-x><Right>', '<C-w>l', { noremap = true })
