-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup(require("configs.plugins"))

-- Configurations
local opt = vim.opt
local wo = vim.wo
local g = vim.g

opt.clipboard = "unnamedplus"
opt.cursorline = true
wo.relativenumber = true
opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true
opt.updatetime = 250
g.mapleader = " "

    -- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

    -- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

require("configs.keybinds").setup()
require("configs.terminal")