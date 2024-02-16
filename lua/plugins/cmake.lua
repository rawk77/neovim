return {
    "Civitasv/cmake-tools.nvim",
    event = "VeryLazy",
    config = true,
    keys = {
        { "<Leader>cg", ":CMakeGenerate<CR>", desc = "CMake Configure"},
        { "<Leader>cb", ":CMakeBuild<CR>", desc = "CMake Build"},
        { "<Leader>cr", ":CMakeRun<CR>", desc = "CMake Run"},
    },
    opts = function()
        return {
            cmake_build_directory = "build",
            cmake_compile_commands_from_lsp = true,
        }
    end,
}
