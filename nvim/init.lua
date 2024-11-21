--[[
 _   _ _____ _____     _____ __  __ _ 
| \ | | ____/ _ \ \   / /_ _|  \/  | |
|  \| |  _|| | | \ \ / / | || |\/| | |
| |\  | |__| |_| |\ V /  | || |  | |_|
|_| \_|_____\___/  \_/  |___|_|  |_(_)
                                      
--]]
-- MAKE SURE TO RUN :PackerSync after getting this init.lua
-- Auto-install packer.nvim if not installed
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print("Installing packer, close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Packer setup
local status, packer = pcall(require, 'packer')
if not status then
    return
end

packer.init()

packer.startup(function(use)
    use 'wbthomason/packer.nvim'  -- Manage itself
    use 'nvim-treesitter/nvim-treesitter'  -- Treesitter
    use 'nvim-treesitter/playground'  -- Optional Treesitter Playground
    use { "catppuccin/nvim", as = "catppuccin" }  -- Catppuccin theme
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require('nvim-tree').setup {
                view = { width = 20, side = 'left', auto_close = true },
            }
        end,
    }
end)

-- Treesitter configuration
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "lua", "python", "javascript" },  -- Add more languages as needed
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- Enable true colors
vim.opt.termguicolors = true

require("catppuccin").setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    transparent_background = true, -- i reccommend you use my kitty terminal config if you want this to work well, otherwise disable it.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = true, -- Force no italic
    no_bold = true, -- Force no bold
    no_underline = false, -- Force no underline
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"

-- Set custom highlight for variables and other syntax elements
vim.api.nvim_set_hl(0, '@variable', { fg = '#ed8796' })
vim.api.nvim_set_hl(0, '@punctuation.bracket', { fg = '#FFC34D' })
vim.api.nvim_set_hl(0, '@function.builtin', { fg = '#8aadf4' })
vim.api.nvim_set_hl(0, '@operator', { fg = '#f5a97f' })
vim.api.nvim_set_hl(0, '@function.macro', { fg = '#75baff' })
vim.api.nvim_set_hl(0, '@punctuation.delimiter', { fg = '#FFB84E' })
vim.api.nvim_set_hl(0, '@comment', { fg = '#6e738d' })

-- Line numbers
vim.wo.number = true

-- Tab and indentation settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false
