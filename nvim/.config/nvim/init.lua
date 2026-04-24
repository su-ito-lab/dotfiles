-- bootstrap lazy.nvim, LazyVim and your plugins

-- ==================================================
-- @file init.lua
-- @brief Neovim configuration entry point
-- ==================================================

if vim.g.vscode then
    require("config.keymaps")
else
    require("config.lazy")
end
