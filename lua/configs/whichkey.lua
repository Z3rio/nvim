local M = {}

M.setup = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").setup()
end

M.keys = { "<leader>", "<c-r>", "<c-w>", "\"", "'", "`", "c", "v", "g" }
M.cmd = "WhichKey"

return M
