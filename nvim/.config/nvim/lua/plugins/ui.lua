-- ==================================================
-- @file ui.lua
-- @brief Neovim UI plugins
-- ==================================================

return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "LazyFile",
        opts = {
            indent = {
                char = "▏",
            },
            scope = {
                enabled = false,
            },
        },
    },

    {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        opts = {
            easing = "quadratic",
            hide_cursor = false,
            stop_eof = true,
            respect_scrolloff = true,
            cursor_scrolls_alone = true,
        },
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        opts = {
            window = {
                width = 32,
            },
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
                follow_current_file = {
                    enabled = true,
                },
                hijack_netrw_behavior = "open_default",
            },
            default_component_configs = {
                indent = {
                    indent_size = 2,
                    with_markers = true,
                },
            },
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            opts.options.theme = "auto"
            opts.options.globalstatus = true
            return opts
        end,
    },
}
