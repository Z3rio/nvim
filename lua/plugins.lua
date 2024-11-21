local whichkey = require("configs.whichkey")
local comment = require("configs.comment")
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
        config = function()
            require("configs.colorizer")
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

    -- Utils
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        init = function()
          require("ibl").setup()
        end,
    },
    {
        "folke/which-key.nvim",
        keys = whichkey.keys,
        cmd = whichkey.cmd,
        config = function()
            whichkey.setup()
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
        keys = comment.keys,
        config = function()
            comment.setup()
        end,
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" }
    },
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },
    {
        "wakatime/vim-wakatime",
        lazy = false,
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
        "folke/trouble.nvim",
        config = function()
            require("configs.trouble")
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSPs
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            "Z3rio/fivem-data.nvim",

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
            'rafamadriz/friendly-snippets'
        },
        branch = 'v3.x',
        config = function()
            require("configs.lsp")
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp"
    },
    {
        "windwp/nvim-ts-autotag",

        config = function()
            require("configs.html_autotag")
        end,

        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },

        lazy = false,
    },
    {
        "windwp/nvim-autopairs",
        config = function(_)
            require("configs.brackets_autotag")
        end,
    },
}

return M
