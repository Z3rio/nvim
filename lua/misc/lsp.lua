vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

vim.cmd [[set completeopt+=menuone,noselect,popup]]

vim.lsp.enable({
    "lua_ls", "cssls", "svelte", "tinymist", "svelteserver",
    "rust_analyzer", "clangd", "ruff",
    "glsl_analyzer", "haskell-language-server", "hlint",
    "intelephense", "biome", "tailwindcss",
    "ts_ls", "emmet_language_server", "emmet_ls", "solargraph"
})


vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format({
            async = false, -- run synchronously before saving
            timeout_ms = 3000,
        })
    end,
})

local map = vim.keymap.set
local builtin = require("telescope.builtin")
map({ "n", "v", "x" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format current buffer" })
map({ "n" }, "<leader>sr", builtin.lsp_references)
map({ "n" }, "<leader>sd", builtin.diagnostics)
map({ "n" }, "<leader>si", builtin.lsp_implementations)
map({ "n" }, "<leader>sT", builtin.lsp_type_definitions)

-- Autocompletion
vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-n>"
    else
        return "<Tab>"
    end
end, { expr = true, silent = true })

-- Shift-Tab to move to the previous item
vim.keymap.set("i", "<S-Tab>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-p>"
    else
        return "<S-Tab>"
    end
end, { expr = true, silent = true })

-- Enter to confirm the selected completion
vim.keymap.set("i", "<CR>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-y>" -- confirms the current completion
    else
        return "<CR>"  -- just inserts a newline if no menu is open
    end
end, { expr = true, silent = true })
