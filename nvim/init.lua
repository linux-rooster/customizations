-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print("Installing packer, close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

local status, packer = pcall(require, 'packer')
if not status then
    return
end

packer.init()

packer.startup(function(use)
    use 'wbthomason/packer.nvim'  -- Manage itself
    use 'nvim-treesitter/nvim-treesitter'  -- Treesitter
    use 'nvim-treesitter/playground'  -- Optional Treesitter Playground
    use 'navarasu/onedark.nvim'   -- OneDark theme
	use { "catppuccin/nvim", as = "catppuccin" }
    -- Add nvim-tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        config = function()
            require('nvim-tree').setup {
                view = {
                    width = 20,
                    side = 'left',  -- or 'right'
                    auto_close = true,
                },
                -- other configurations can go here
            }
        end
    }
end)

require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp" },  -- Ensure C and C++ are installed
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

require('onedark').setup {
    style = 'warm',
}
require('onedark').load()

-- Set custom highlight for variables
vim.api.nvim_set_hl(0, '@variable', { fg = '#ff8080' })  -- Change color of variables

-- Set custom highlight for comments
vim.api.nvim_set_hl(0, '@comment', { italic = false, fg = '#696969' })

vim.api.nvim_set_hl(0, '@punctuation.bracket', { fg = '#FFC34D' })

vim.api.nvim_set_hl(0, '@operator', { fg = '#FFB65D' })

vim.api.nvim_set_hl(0, '@function.macro', { fg = '#75baff' })

vim.api.nvim_set_hl(0, '@punctuation.delimiter', { fg = '#FFB84E' })

vim.wo.number = true -- set line numbers

-- Set custom highlight for print statements (function calls)
vim.api.nvim_set_hl(0, '@function.builtin', { fg = '#78C1FF' })  -- Custom color for print statements

-- Set tab and shift width to 4 spaces
vim.opt.tabstop = 4       -- Number of spaces a <Tab> counts for
vim.opt.softtabstop = 4   -- Number of spaces a <Tab> counts for while editing
vim.opt.shiftwidth = 4     -- Number of spaces to use for each step of (auto)indent

vim.opt.wrap = false



-- Enable true colors
vim.opt.termguicolors = true

-- Function to disable bold for highlight groups
local function disable_bold()
    local highlight_groups = vim.fn.getcompletion('', 'highlight')
    for _, hl in ipairs(highlight_groups) do
        -- Get current highlight attributes
        local attrs = vim.api.nvim_get_hl_by_name(hl, true)
        -- Check if bold is set
        if attrs.bold then
            -- Set it to NONE while preserving other attributes
            vim.api.nvim_set_hl(0, hl, {
                bold = false,
                fg = attrs.foreground and string.format("#%06x", attrs.foreground) or nil,
                bg = attrs.background and string.format("#%06x", attrs.background) or nil
            })
        end
    end
end

-- Call the function to disable bold
disable_bold()



