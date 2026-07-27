-- ============================================================================
-- Alpha.nvim - 启动页
-- ============================================================================

return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",

        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },

        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            --------------------------------------------------------------------
            -- Header
            --------------------------------------------------------------------

            dashboard.section.header.val = {
                "                                                      ",
                "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                "                                                      ",
            }

            --------------------------------------------------------------------
            -- Menu
            --------------------------------------------------------------------

            dashboard.section.buttons.val = {
                dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
                dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
                dashboard.button("e", "  New File", ":ene <BAR> startinsert<CR>"),
                dashboard.button("t", "󰱼  Find Text", ":Telescope live_grep<CR>"),
                dashboard.button("n", "  File Tree", ":Neotree toggle<CR>"),
                dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
                dashboard.button("q", "󰗼  Quit", ":qa<CR>"),
            }

            --------------------------------------------------------------------
            -- Footer
            --------------------------------------------------------------------

            local stats = require("lazy").stats()

            dashboard.section.footer.val = {
                "",
                string.format(
                    "⚡ Loaded %d plugins in %.2f ms",
                    stats.loaded,
                    stats.startuptime
                ),
            }

            --------------------------------------------------------------------
            -- Layout
            --------------------------------------------------------------------

            dashboard.config.layout = {
                { type = "padding", val = 2 },
                dashboard.section.header,
                { type = "padding", val = 2 },
                dashboard.section.buttons,
                { type = "padding", val = 2 },
                dashboard.section.footer,
            }

            alpha.setup(dashboard.config)
        end,
    },
}