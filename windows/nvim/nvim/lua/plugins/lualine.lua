-- ============================================================================
-- Lualine — 状态栏
-- ============================================================================

return {
  {
    'nvim-lualine/lualine.nvim',

    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto',

          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
        },

        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'filename' },
          lualine_c = {
            {
              'diagnostics',
              sources = { 'nvim_lsp' },
            },
          },
          lualine_x = {
            {
              'encoding',
              fmt = string.upper,
            },
            {
              'fileformat',
              fmt = string.upper,
            },
          },
          lualine_y = { 'filetype' },
          lualine_z = { 'progress' },
        },

        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
}
