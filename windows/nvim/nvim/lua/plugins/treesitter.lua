-- ============================================================================
-- Treesitter — 语法高亮
-- ============================================================================

return {
  {
    'nvim-treesitter/nvim-treesitter',

    build = ':TSUpdate',

    config = function()
      require('nvim-treesitter').setup({
        ensure_installed = {
          'c',
          'cpp',
          'go',
          'lua',
          'vim',
          'markdown',
        },
        highlight = { enable = true },
      })
    end,
  },
}
