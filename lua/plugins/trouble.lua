return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        vim.keymap.set("n", "<leader>cd", function() require("trouble").toggle() end, {desc = "Diagnostics list with Trouble"})
        -- your configuration comes here
        -- or leave it empty to use the default settings
    },
}
