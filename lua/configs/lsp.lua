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
    somesass_ls = {
        filetypes = {
            "scss",
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
        "jsonls",
        "tailwindcss",
        "somesass_ls"
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
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        else
            fallback()
        end
    end, {
        "i",
        "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        else
            fallback()
        end
    end, {
        "i",
        "s",
    }),
})

local cmp_ui = {
    icons = true,
    lspkind_text = true,
    style = "default",            -- default/flat_light/flat_dark/atom/atom_colored
    border_color = "grey_fg",     -- only applicable for "default" style, use color names from base30 variables
    selected_item_bg = "colored", -- colored / simple
}
local cmp_style = cmp_ui.style


local field_arrangement = {
    atom = { "kind", "abbr", "menu" },
    atom_colored = { "kind", "abbr", "menu" },
}

local function border(hl_name)
    return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
    }
end

local icons = {
    Namespace = "󰌗",
    Text = "󰉿",
    Method = "󰆧",
    Function = "󰆧",
    Constructor = "",
    Field = "󰜢",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "󰑭",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈚",
    Reference = "󰈇",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "󰙅",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰊄",
    Table = "",
    Object = "󰅩",
    Tag = "",
    Array = "[]",
    Boolean = "",
    Number = "",
    Null = "󰟢",
    String = "󰉿",
    Calendar = "",
    Watch = "󰥔",
    Package = "",
    Copilot = "",
    Codeium = "",
    TabNine = "",
}

local formatting_style = {
    -- default fields order i.e completion word + item.kind + item.kind icons
    fields = field_arrangement[cmp_style] or { "abbr", "kind", "menu" },

    format = function(_, item)
        local icon = (cmp_ui.icons and icons[item.kind]) or ""

        if cmp_style == "atom" or cmp_style == "atom_colored" then
            icon = " " .. icon .. " "
            item.menu = cmp_ui.lspkind_text and "   (" .. item.kind .. ")" or ""
            item.kind = icon
        else
            icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
            item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")
        end

        return item
    end,
}

require("cmp").setup({
    completion = {
        completeopt = "menu,menuone",
    },

    window = {
        completion = {
            side_padding = (cmp_style ~= "atom" and cmp_style ~= "atom_colored") and 1 or 0,
            winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
            scrollbar = false,
        },
        documentation = {
            border = border("CmpBorder"),
            winhighlight = "Normal:CmpDoc",
        },
    },

    formatting = formatting_style,

    mapping = cmp_mappings,

    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
    },
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
