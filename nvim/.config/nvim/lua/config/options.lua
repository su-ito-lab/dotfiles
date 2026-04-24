-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- ==================================================
-- @file options.lua
-- @brief Neovim options
-- ==================================================

local opt = vim.opt

-- --------------------------------------------------
-- display
-- --------------------------------------------------
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.showmatch = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.list = false
opt.wrap = false

-- --------------------------------------------------
-- search
-- --------------------------------------------------
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- --------------------------------------------------
-- indentation
-- --------------------------------------------------
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

-- --------------------------------------------------
-- editing
-- --------------------------------------------------
opt.backspace = { "indent", "eol", "start" }
opt.mouse = "a"
opt.whichwrap = "<,>,h,l"
opt.clipboard = "unnamedplus"

-- --------------------------------------------------
-- timing
-- --------------------------------------------------
opt.timeoutlen = 500
opt.updatetime = 250

-- --------------------------------------------------
-- appearance
-- --------------------------------------------------
opt.termguicolors = true

-- --------------------------------------------------
-- window
-- --------------------------------------------------
opt.splitright = true
opt.splitbelow = true

-- --------------------------------------------------
-- undo
-- --------------------------------------------------
opt.undofile = true

-- --------------------------------------------------
-- smooth scroll
-- --------------------------------------------------
opt.smoothscroll = true

-- --------------------------------------------------
-- WSL clipboard integration
-- --------------------------------------------------
if vim.fn.has("wsl") == 1 then
    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
            ["+"] = "clip.exe",
            ["*"] = "clip.exe",
        },
        paste = {
            ["+"] =
            'powershell.exe -NoProfile -Command "[Console]::OutputEncoding=[System.Text.Encoding]::UTF8; Get-Clipboard"',
            ["*"] =
            'powershell.exe -NoProfile -Command "[Console]::OutputEncoding=[System.Text.Encoding]::UTF8; Get-Clipboard"',
        },
        cache_enabled = 0,
    }
end
