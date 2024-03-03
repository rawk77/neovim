return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "tsserver",
                    "clangd",
                    --"codelldb",
                    "gopls",
                    "rust_analyzer",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            local util = require("lspconfig/util")
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
            })
            lspconfig.tsserver.setup({
                capabilities = capabilities,
            })
            lspconfig.clangd.setup({
                capabilities = capabilities,
            })
            lspconfig.gopls.setup({
                capabilities = capabilities,
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = {"rust"},
                root_dir = util.root_pattern("Cargo.toml"),
                -- cmd = {
                --     "rustup", "run", "stable", "rust-analyzer",
                -- },
                settings = {
                    ['rust-analyzer'] = {
                        cargo = {
                            allFeatures = true,
                        }
                    }
                }
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show symbol information" })
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
            vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Goto References" })
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
        end,
    },
}
