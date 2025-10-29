return {
    "https://github.com/stevearc/oil.nvim",
    opts = {
        lsp_file_methods = {
            enabled = true,
            timeout_ms = 1000,
            autosave_changes = true,
        },
        columns = {
            "permissions",
            "icon",
        },
        float = {
            max_width = 0.7,
            max_height = 0.6,
            border = "rounded",
        },
    },
    init = function()
        vim.keymap.set({ "n" }, "<leader>e", "<cmd>Oil<CR>")
    end,
}
