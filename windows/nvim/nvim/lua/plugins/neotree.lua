-- ============================================================================
-- Neo-tree — 文件树
-- ============================================================================

return {
  {
    'nvim-neo-tree/neo-tree.nvim',

    branch = 'v3.x',

    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },

      config = function()
        require('neo-tree').setup({
          close_if_last_window = true,
          window = {
            width = 30,
          },
      })
        vim.api.nvim_create_autocmd('VimEnter', {
          once = true,
          callback = function()
            if vim.fn.argc() > 0 then
              local bufname = vim.api.nvim_buf_get_name(0)
              if not bufname:find('leetcode', 1, true) then
                require('neo-tree.command').execute({ toggle = true })
              end
            end
          end,
       })
      end,
  },
}
