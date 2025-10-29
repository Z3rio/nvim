local map = vim.keymap.set

return {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        defaults = {
            preview = { treesitter = false },
            color_devicons = true,
            sorting_strategy = "ascending",
            borderchars = {
                "─", -- top
                "│", -- right
                "─", -- bottom
                "│", -- left
                "┌", -- top-left
                "┐", -- top-right
                "┘", -- bottom-right
                "└", -- bottom-left
            },
            path_displays = { "smart" },
            layout_config = {
                height = 100,
                width = 400,
                prompt_position = "top",
                preview_cutoff = 40,
            }
        }
    },
    init = function()
        local builtin = require("telescope.builtin")
        require('telescope').load_extension("ui-select")

        map({ "n" }, "<leader>se", "<cmd>Telescope env<cr>")
        map({ "n" }, "<leader>f", builtin.find_files, { desc = "Telescope live grep" })
        map({ "n" }, "<leader>g", builtin.live_grep)
        map({ "n" }, "<leader>sg", function() builtin.find_files({ no_ignore = true }) end)
        map({ "n" }, "<leader>sb", builtin.buffers)
        map({ "n" }, "<leader>si", builtin.grep_string)
        map({ "n" }, "<leader>so", builtin.oldfiles)
        map({ "n" }, "<leader>sh", builtin.help_tags)
        map({ "n" }, "<leader>sm", builtin.man_pages)
        map({ "n" }, "<leader>ss", builtin.current_buffer_fuzzy_find)
        map({ "n" }, "<leader>st", builtin.builtin)
        map({ "n" }, "<leader>sc", builtin.git_bcommits)
        map({ "n" }, "<leader>sk", builtin.keymaps)
    end
}
