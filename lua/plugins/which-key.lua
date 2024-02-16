return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function()
            local wk = require("which-key")
            wk.setup({
                window = {
                    winblend = 30,
                    margin = { 0, 0, 0, 0 },
                    padding = { 1, 1, 1, 1 },
                }
            })
            wk.register({
                ["<leader>f"] = { name = "File" },
                ["<leader>l"] = { name = "Lsp" },
                ["<leader>g"] = { name = "Format" },
                ["<leader>u"] = { name = "User Interface" },
                ["<leader>e"] = { name = "Explorer" },
                ["<leader>t"] = { name = "Terminal" },
                ["<leader>d"] = { name = "Debug" },
                ["<leader>h"] = { name = "Harpoon" },
                ["<leader>b"] = { name = "Buffer" },
                ["<leader>c"] = { name = "Code" },
            })
        end,
        -- opts = {
        --     icons = {
        --         group = "",
        --     },
        --     -- layout = {
        --     --     align = "center",
        --     -- },
        --     defaults = {
        --         ["<leader>ci"] = { name = "info" },
        --         ["<leader><tab>"] = { name = "󰓩 tabs" },
        --         ["<leader>b"] = { name = "󰖯 buffer" },
        --         ["<leader>c"] = { name = " code" },
        --         ["<leader>f"] = { name = "󰈔 file/find" },
        --         ["<leader>g"] = { name = " git" },
        --         ["<leader>l"] = { name = "󰒲 lazy" },
        --         ["<leader>q"] = { name = "󰗼 quit/session" },
        --         ["<leader>s"] = { name = " search" },
        --         ["<leader>u"] = { name = " ui" },
        --         ["<leader>w"] = { name = "󱂬 windows" },
        --         ["<leader>x"] = { name = "󰁨 diagnostics/quickfix" },
        --     },
        -- },
    },
}
