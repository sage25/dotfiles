-- ============================================================================
-- Neo-tree — 文件树
-- ============================================================================

return {
    {
        "nvim-neo-tree/neo-tree.nvim",

        branch = "v3.x",

        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },

        config = function()
            local neotree = require("neo-tree.command")

            --------------------------------------------------------------------
            -- Neo-tree
            --------------------------------------------------------------------

            require("neo-tree").setup({
                close_if_last_window = true,

                window = {
                    width = 30,
                },
            })

            --------------------------------------------------------------------
            -- 启动时自动打开文件树
            --------------------------------------------------------------------

            vim.api.nvim_create_autocmd("VimEnter", {
                once = true,
                callback = function()
                    if vim.fn.argc() > 0 then
                        neotree.execute({
                            action = "show",
                            reveal = true,
                        })
                        vim.schedule(function()
                            vim.cmd("wincmd p")
                        end)
                    end
                end,
            })

            --------------------------------------------------------------------
            -- LeetCode 自动关闭 Neo-tree
            --------------------------------------------------------------------

            local group =
                vim.api.nvim_create_augroup("NeoTreeLeetCode", { clear = true })

            local function close_if_leetcode()
                local buf = vim.api.nvim_get_current_buf()
                local name = vim.api.nvim_buf_get_name(buf)
                local ft = vim.bo[buf].filetype

                if name:lower():find("leetcode", 1, true)
                    or ft == "leetcode"
                    or ft == "leetcode.nvim"
                then
                    pcall(function()
                        neotree.execute({
                            action = "close",
			    reveal = true,
                        })
                    end)
                end
            end

            vim.api.nvim_create_autocmd({
                "BufEnter",
                "WinEnter",
                "FileType",
            }, {
                group = group,
                callback = function()
                    vim.schedule(close_if_leetcode)
                end,
            })
        end,
    },
}
