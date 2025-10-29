require("misc.bootstrap")
require("misc.settings")

require("lazy").setup({
	spec = {
		require("plugins.catppuccin"),
		require("plugins.marks"),
		require("plugins.oil"),
		{ "https://github.com/nvim-tree/nvim-web-devicons" },
		require("plugins.telescope"),
		{ "https://github.com/nvim-treesitter/nvim-treesitter",        version = "main" },
		{ "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
		{ "https://github.com/nvim-lua/plenary.nvim" },
		{ "https://github.com/chomosuke/typst-preview.nvim" },
		{ "https://github.com/neovim/nvim-lspconfig" },
		require("plugins.mason"),
		{ "https://github.com/LinArcX/telescope-env.nvim" },
		require("plugins.which-key"),
		require("plugins.avante")
	},
	-- automatically check for plugin updates
	-- checker = { enabled = true },
})

require("misc.keybinds")
require("misc.terminal")
require("misc.lsp")
