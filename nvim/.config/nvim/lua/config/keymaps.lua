-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ==================================================
-- @file keymaps.lua
-- @brief Neovim keymaps
-- ==================================================

local keymap = vim.keymap.set

-- --------------------------------------------------
-- insert mode
-- --------------------------------------------------
keymap("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })
keymap("i", "kj", "<Esc>", { desc = "Exit insert mode with kj" })

-- --------------------------------------------------
-- line movement
-- --------------------------------------------------
keymap({ "n", "x" }, "H", "g0", { remap = true, silent = true, desc = "Start of visual line" })
keymap({ "n", "x" }, "L", "g$", { remap = true, silent = true, desc = "End of visual line" })

keymap("n", "j", function()
    return vim.v.count == 0 and "gj" or "j"
end, { expr = true, remap = true, silent = true, desc = "Down visual line" })

keymap("n", "k", function()
    return vim.v.count == 0 and "gk" or "k"
end, { expr = true, remap = true, silent = true, desc = "Up visual line" })

-- --------------------------------------------------
-- search
-- --------------------------------------------------
keymap("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
