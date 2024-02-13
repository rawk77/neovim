return {
    {
        "nvim-telescope/telescope.nvim", tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            -- Telescope Keymaps
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
            vim.keymap.set("n", "<leader>ft", builtin.live_grep, {desc = "Live Grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {desc = "Find in Buffers" })
            vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {desc = "Find in Old Files" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {desc = "Find in Help Tags" })
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
              extensions = {
                ["ui-select"] = {
                  require("telescope.themes").get_dropdown {
                  }
                }
              }
            })
            require("telescope").load_extension("ui-select")
        end
    },
}
