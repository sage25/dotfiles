-- ============================================================================
-- Indent Blankline — 缩进参考线
-- ============================================================================

return {
  {
    'lukas-reineke/indent-blankline.nvim',

    main = 'ibl',

    config = function()
      require('ibl').setup()
    end,
  },
}
