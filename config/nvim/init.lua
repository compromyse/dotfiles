-- General Settings
vim.opt.number = true
vim.opt.rnu = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 5
vim.opt.mouse= 'a'
vim.api.nvim_set_option('clipboard','unnamedplus')
vim.opt.ruler = false
vim.opt.showtabline = 2

-- Reset Cursor On Exit
local au_id = vim.api.nvim_create_augroup('RestoreCursorShapeOnExit', {clear = true})
vim.api.nvim_create_autocmd('VimLeave',{
    command = 'set guicursor=a:ver20',
    group = au_id
})

-- Setup Packages
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    'stevearc/oil.nvim',

    'lukas-reineke/indent-blankline.nvim',
    'windwp/nvim-autopairs',
    'numToStr/Comment.nvim',

    'nvim-tree/nvim-web-devicons',

    'hrsh7th/cmp-nvim-lsp',
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',

    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',

    'klen/nvim-config-local',

    'christoomey/vim-tmux-navigator',

    'metalelf0/black-metal-theme-neovim',
})

require('config-local').setup {
    config_files = { ".nvim.lua", ".nvimrc", ".exrc" },
    hashfile = vim.fn.stdpath("data") .. "/config-local",
}

local oil = require('oil')
_G.oil = oil
oil.setup {
    default_file_explorer = true,
    view_options = {
        show_hidden = true
    }
}

require('ibl').setup()

require('Comment').setup {
    padding = true,
    toggler = {
        line = '\\\\',
        block = ']]'
    },
    opleader = {
        line = '\\\\',
        block = ']]'
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
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'nvim_lsp_signature_help' },
    }
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

-- Set Up Autopairs
require('nvim-autopairs').setup({ map_cr = true })

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

vim.cmd.colorscheme('bathory')

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<A-.>', '<Cmd>tabnext<CR>', opts)
map('n', '<A-,>', '<Cmd>tabprev<CR>', opts)
map('n', '<A-t>', '<Cmd>tabnew<CR>', opts)
map('n', '<A-w>', '<Cmd>tabclose<CR>', opts)

map('n', '<A-]>', '<Cmd>bnext<CR>', opts)
map('n', '<A-[>', '<Cmd>bprev<CR>', opts)

vim.api.nvim_create_augroup('AutoFormatting', {})
vim.api.nvim_create_autocmd('BufWritePre', {
    group = 'AutoFormatting',
    callback = function()
        vim.lsp.buf.format()
    end,
})

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
