local M = {
    -- Theme/UI
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("configs.theme")
        end,
    },
    'nvim-tree/nvim-web-devicons',
    {
        "NvChad/nvim-colorizer.lua",
        init = function()
            require("utils").lazy_load("nvim-colorizer.lua")
        end,
        config = function(_, opts)
            require("colorizer").setup(opts)

            vim.defer_fn(function()
                require("colorizer").attach_to_buffer(0)
            end, 0)
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('configs.statusline')
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        ft = { "gitcommit", "diff" },
        init = function()
            require("configs.git_signs")
        end,
    },

    -- Tracking
    {
        "wakatime/vim-wakatime",
        lazy = false,
    },
    {
        "Z3rio/presence.nvim",

        lazy = false,

        config = function()
            require("configs.discord")
        end,
    },

    -- Utils
    {
        "folke/which-key.nvim",
        keys = { "<leader>", "<c-r>", "<c-w>", "\"", "'", "`", "c", "v", "g" },
        cmd = "WhichKey",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function(_, opts)
            require("which-key").setup(opts)
        end,
        lazy = false
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "numToStr/Comment.nvim",
        keys = {
            { "gcc", mode = "n",          desc = "Comment toggle current line" },
            { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
            { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
            { "gbc", mode = "n",          desc = "Comment toggle current block" },
            { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
            { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
        },
        config = function(_, _opts)
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },

    -- LSP
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("configs.treesitter")
        end
    },
    {
        "theprimeagen/refactoring.nvim",
        config = function()
            require("configs.refactoring")
        end
    },
    {
        "mbbill/undotree",
        config = function()
            require("configs.undotree")
        end
    },
    {
        "tpope/vim-fugitive",
        config = function()
            require("configs.fugitive")
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context"
    },
    {
        "folke/trouble.nvim",
        config = function()
            require("configs.trouble")
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            "Z3rio/NvChad-customdata",

            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Snippets
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets'
        },
        branch = 'v3.x',
        config = function()
            require("configs.lsp")
        end,
    },
    {
        "windwp/nvim-ts-autotag",

        config = function()
            require('nvim-ts-autotag').setup({
                opts = {
                    -- Defaults
                    enable_close = true,        -- Auto close tags
                    enable_rename = true,       -- Auto rename pairs of tags
                    enable_close_on_slash = false -- Auto close on trailing </
                },
                -- Also override individual filetype configs, these take priority.
                -- Empty by default, useful if one of the "opts" global settings
                -- doesn't work well in a specific filetype
                per_filetype = {
                    ["html"] = {
                        enable_close = false
                    }
                }
            })
        end,

        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },

        lazy = false,
    },
    {
        "windwp/nvim-autopairs",
        opts = {
            fast_wrap = {},
            disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
}

return M
