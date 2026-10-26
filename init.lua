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
vim.o.pumborder = "rounded"

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

-- Packages
vim.pack.add({
    { src = 'https://github.com/nvim-mini/mini.nvim' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/folke/snacks.nvim' },
    { src = 'https://github.com/rebelot/kanagawa.nvim' },
    { src = 'https://github.com/EdenEast/nightfox.nvim' },
})

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP keymaps",
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set({ "n", "x" }, "gf", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
        vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    end,
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = { workspace = { library = vim.api.nvim_get_runtime_file("", true), }, },
    },
})

vim.lsp.enable({ "lua_ls", "pylsp", "gopls", "clangd", "zls" })

-- Treesitter
local treesitter = require("nvim-treesitter")
treesitter.setup({})
treesitter.install({ "lua", "vim", "vimdoc", "bash", "c", "cpp", "go", "python", "json", "markdown", "markdown_inline",
    "zig" })
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

-- Diagnostics
vim.diagnostic.config {
update_in_insert = false,
severity_sort = true,
float = { border = 'rounded', source = 'if_many' },
underline = { severity = { min = vim.diagnostic.severity.WARN } },
virtual_text = true, -- Text shows up at the end of the line
virtual_lines = false, -- Text shows up underneath the line, with virtual lines
jump = {
  on_jump = function(_, bufnr)
    vim.diagnostic.open_float {
      bufnr = bufnr,
      scope = 'cursor',
      focus = false,
    }
  end,
},
}

-- Package setups
require('snacks').setup({
    picker = { enabled = true },
})
require('mini.surround').setup()
require('mini.completion').setup()
require('mini.pairs').setup()
require('mini.icons').setup()
require('mini.snippets').setup()
require('mini.statusline').setup()

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
vim.keymap.set('n', '<leader>e', ':Ex<cr>', { silent = true, desc = 'Open Netwrx' })

-- Picker
local picker = Snacks.picker
vim.keymap.set("n", "<leader>ff", picker.files, { silent = true, desc = "Find files" })
vim.keymap.set("n", "<leader>fb", picker.buffers, { silent = true, desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", picker.help, { silent = true, desc = "Find Help" })
vim.keymap.set("n", "<leader>fg", picker.grep, { silent = true, desc = "Live Grep" })
vim.keymap.set("n", "<leader>fd", picker.diagnostics, { silent = true, desc = "Diagnostics" })

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

-- Theme & transparency
vim.cmd.colorscheme 'nightfox'
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
