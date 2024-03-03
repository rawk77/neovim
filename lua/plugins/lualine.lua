return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require('lualine').setup({
            options = {
                theme = 'onedark',
                section_separators = '',
                component_separators = '',
            }
        })
    end
}
