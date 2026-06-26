-- ============================================================================
-- Telescope — 模糊查找
-- ============================================================================

return {
  {
    'nvim-telescope/telescope.nvim',

    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-frecency.nvim',
    },

    config = function()
      local telescope = require('telescope')
      local actions   = require('telescope.actions')

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({}),
          },
        },
      })

      telescope.load_extension('ui-select')
      telescope.load_extension('frecency')
    end,
  },
}
