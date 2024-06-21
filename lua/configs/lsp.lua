local lsp = require("lsp-zero")

lsp.preset("recommended")

local LspOpts = {
    lua_ls = {
        settings = {
            Lua = {
                format = {
                    enable = true,
                    defaultConfig = { indent_style = "space", indent_size = 2 },
                },
                diagnostics = {
                    globals = {
                        "vim",
                        "MySQL",
                        "QBCore",
                        "ESX",
                        "MySQL.Async",
                        "MySQL.Sync",
                    }
                },
                workspace = {
                    library = require("nvchad_customdata").getPaths(),
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                }
            }
        }
    },
    tsserver = {
        init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = vim.fn.stdpath('data') ..
                        '/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin',
                    languages = { 'typescript', 'javascript', 'vue' }
                },
                -- TODO: as of today (4/16/2024) @vue/typescript-plugin does not work with:
                -- "typescript-svelte-plugin",
                -- it should however be fixed in this PR: https://github.com/sveltejs/language-tools/pull/2317
            }
        },
        filetypes = {
            "javascript",
            "typescript",
            "vue",
        },
    },
    volar = {
        init_options = {
            vue = {
                hybridMode = true
            }
        },
        filetypes = { 'vue' }
    }
}

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'tsserver',
        'rust_analyzer',
        "lua_ls",
        "volar",
        "cssls",
        "html",
        "emmet_ls",
        "jsonls"
    },
    handlers = {
        function(server_name)
            local opts = LspOpts[server_name]

            if opts == nil then
                opts = {}
            end

            require('lspconfig')[server_name].setup(opts)
        end,
    },
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

require("cmp").setup({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
