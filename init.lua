-- Theme & transparency
vim.cmd.colorscheme 'default'
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })

-- Vim Options
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Basic settings
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.showmatch = true

-- Visual settings
vim.opt.list = true -- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.showmode = false
vim.opt.signcolumn = "auto"
vim.o.winborder = "rounded"

-- Behavior settings
vim.o.mouse = 'a'
vim.opt.errorbells = false
vim.opt.iskeyword:append '-'
vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)
vim.o.breakindent = true -- Enable break indent on wrapped lines
vim.o.updatetime = 250   -- Decrease update time
vim.o.timeoutlen = 500   -- Set the leader key wait time
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.inccommand = 'split'
vim.o.confirm = true

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    -- Plugins go here
    spec = {
        -- Theme
        {
            "rebelot/kanagawa.nvim",
            enabled = false,
            lazy = false,
            priority = 1000,
            config = function()
                require('kanagawa').setup({
                    transparent = true,
                    terminalColors = true,
                })
                vim.cmd([[colorscheme kanagawa]])
            end
        },

        -- Mini modules
        {
            'echasnovski/mini.nvim',
            config = function()
                require('mini.ai').setup()
                require('mini.surround').setup()
                require('mini.completion').setup()
                require('mini.icons').setup()
                require('mini.snippets').setup()
                require('mini.basics').setup()
                require('mini.extra').setup()
                require('mini.statusline').setup()
                require('mini.pick').setup({
                    vim.keymap.set("n", "<leader>ff", "<cmd>Pick files<cr>", { silent = true, desc = "Find files" }),
                    vim.keymap.set("n", "<leader>fb", "<cmd>Pick buffers<cr>", { silent = true, desc = "Buffers" }),
                    vim.keymap.set("n", "<leader>fh", "<cmd>Pick help<cr>", { silent = true, desc = "Find Help" }),
                    vim.keymap.set("n", "<leader>fg", "<cmd>Pick grep_live<cr>", { silent = true, desc = "Live Grep" }),
                    vim.keymap.set("n", "<leader>fd", "<cmd>Pick diagnostic<cr>", { silent = true, desc = "Diagnostics" }),
                })
                require('mini.files').setup({
                    vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>", { silent = true, desc = "File Explorer" }),
                })
                require('mini.tabline').setup()
            end
        },
        {
            'nvim-treesitter/nvim-treesitter',
            branch = 'main',
            lazy = false,
            build = ':TSUpdate',
            config = function ()
                local config = require("nvim-treesitter.config")
                config.setup({
                    ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'python', 'go', 'gosum', 'gomod' },
                    highlight = { enabled = true },
                    indent = { enabled = true },
                })
            end
        },
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                {
                    "folke/lazydev.nvim",
                    ft = "lua",
                    opts = {
                        library = {
                            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                        },
                    },
                },
            },
        },
    },

    install = { colorscheme = { "default" } },
    checker = { enabled = false },
    ui = { border = "rounded" },
})

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        -- Display documentation of the symbol under the cursor
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)

        -- Jump to the definition
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)

        -- Format current file
        vim.keymap.set({ 'n', 'x' }, 'gf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)

        -- Displays a function's signature information
        vim.keymap.set('i', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

        -- Jump to declaration
        vim.keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)

        -- Lists all the implementations for the symbol under the cursor
        vim.keymap.set('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)

        -- Jumps to the definition of the type symbol
        vim.keymap.set('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)

        -- Lists all the references
        vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)

        -- Renames all references to the symbol under the cursor
        vim.keymap.set('n', '<leader>ln', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)

        -- Selects a code action available at the current cursor position
        vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})
vim.lsp.enable({ 'lua_ls', 'pylsp', 'gopls'})

-- [ Keymaps ]
vim.keymap.set("i", "jj", "<esc>", { silent = true })

-- Better window navigation
vim.keymap.set("n", "<c-j>", "<c-w><c-j>")
vim.keymap.set("n", "<c-k>", "<c-w><c-k>")
vim.keymap.set("n", "<c-l>", "<c-w><c-l>")
vim.keymap.set("n", "<c-h>", "<c-w><c-h>")
vim.keymap.set("n", "<leader>wq", "<c-w>q")
vim.keymap.set("n", '<leader>ws', "<c-w>v")
vim.keymap.set("n", '<leader>wh', "<c-w>s")

-- Resize window splits
vim.keymap.set("n", "<M-,>", "<c-w>5<")
vim.keymap.set("n", "<M-.>", "<c-w>5>")
vim.keymap.set("n", "<M-=>", "<C-W>+")
vim.keymap.set("n", "<M-->", "<C-W>-")

-- Better Buffer navigation
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
vim.keymap.set('n', '<leader>`', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })

-- Explorer
-- vim.keymap.set('n', '<leader>e', ':Ex<cr>', { silent = true, desc = 'Open Netwrx' })

-- Navigate in Insert mode (emacs)
vim.keymap.set('i', '<C-b>', '<Left>', { silent = true })
vim.keymap.set('i', '<C-f>', '<Right>', { silent = true })
vim.keymap.set('i', '<C-p>', '<Up>', { silent = true })
vim.keymap.set('i', '<C-n>', '<Down>', { silent = true })
vim.keymap.set('i', '<C-a>', '<Home>', { silent = true })
vim.keymap.set('i', '<C-e>', '<End>', { silent = true })

-- Eval lua files in neovim config
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- Open neovim config file
vim.keymap.set("n", "<leader>ec", function()
    vim.cmd('edit ' .. vim.fn.stdpath('config') .. '/init.lua')
end, { desc = "Edit Config" })

-- Exit terminal mode using escape
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
