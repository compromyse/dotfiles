-- General Settings
vim.opt.number = true
vim.opt.mouse = ''
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 5
vim.opt.mouse = 'a'
vim.api.nvim_set_option('clipboard','unnamedplus')
vim.opt.ruler = false

-- Reset Cursor On Exit
local au_id = vim.api.nvim_create_augroup('RestoreCursorShapeOnExit', {clear = true})
vim.api.nvim_create_autocmd('VimLeave',{
  command = 'set guicursor=a:ver20',
  group = au_id
})

-- Setup Packages
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'lukas-reineke/indent-blankline.nvim'
  use 'windwp/nvim-autopairs'
  use 'numToStr/Comment.nvim'

  use 'kvrohit/rasmus.nvim'

	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/nvim-cmp'
	use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'L3MON4D3/LuaSnip'
  use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

  use 'stevearc/oil.nvim'

  use 'akinsho/toggleterm.nvim'
  use 'christoomey/vim-tmux-navigator'

	if install_plugins then
		require('packer').sync()
	end
end)

if install_plugins then
  return
end


local oil = require('oil')
_G.oil = oil
oil.setup {
  default_file_explorer = true,
  columns = {
    'icon',
  },
  view_options = {
    show_hidden = true
  }
}

require('ibl').setup()

require('Comment').setup {
	padding = true,
		toggler = {
			line = '\\\\'
		},
    opleader = {
      block = '\\\\'
    }
}

-- CMP Setup
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },
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
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{ name = 'cmdline' }
		})
})

-- Set Up Lspconfig
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
servers = { 'pyright', 'ccls', 'gopls', 'rubocop' }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities
  }
end

-- Set Up Telescope
local actions = require('telescope.actions')
local telescope = require('telescope')
telescope.setup({
  pickers = {
    find_files = {
      hidden = true
    }
  },
  defaults = {
    layout_strategy = 'bottom_pane',
    layout_config = {
      height = 0.4
    },
  },
})

-- Set Up ToggleTerm
require('toggleterm').setup {
  direction = 'horizontal',
  size = math.floor(0.8 * vim.api.nvim_win_get_height(0))
}

-- Set Up Autopairs
require('nvim-autopairs').setup({ map_cr = true })

-- Set Up Compile.lua
require('compile')

-- Keyboard Shortcuts
vim.keymap.set('n', 'P', '<cmd>pu<cr>', { noremap = true })

vim.keymap.set('n', '<space><space>', '<cmd>Telescope find_files<cr>', { noremap = true })
vim.keymap.set('n', '<space>b', '<cmd>Telescope buffers<cr>', { noremap = true })
vim.keymap.set('n', '<space>f', '<cmd>Telescope live_grep<cr>', { noremap = true })

vim.keymap.set('n', '<A-x>', '<cmd>close<cr>', { noremap = true })
vim.keymap.set('n', '<A-q>', '<cmd>bdelete!<cr>', { noremap = true })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

vim.keymap.set('n', '\\d', vim.lsp.buf.definition, { noremap = true })
vim.keymap.set('n', '\\f', vim.lsp.buf.declaration, { noremap = true })

vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true })

vim.keymap.set('n', '<A-y>', '<cmd>ToggleTerm<cr>', { noremap = true })
vim.keymap.set('t', '<A-y>', '<cmd>ToggleTerm<cr>', { noremap = true })
vim.keymap.set('t', '<A-y>', '<cmd>ToggleTerm<cr>', { noremap = true })

vim.keymap.set('n', '<A-n>', '<cmd>bnext<cr>', { noremap = true })
vim.keymap.set('n', '<A-p>', '<cmd>bprev<cr>', { noremap = true })

vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>', { noremap = true })
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>', { noremap = true })
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>', { noremap = true })
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>', { noremap = true })

vim.keymap.set('n', '<A-a>', '<cmd>lua oil.toggle_float()<cr>', { noremap = true })

-- Splitting The Window
vim.api.nvim_set_keymap('n', '<A-\\>', ':vsplit<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-->', ':split<CR>', { noremap = true })

vim.cmd.colorscheme('rasmus')
