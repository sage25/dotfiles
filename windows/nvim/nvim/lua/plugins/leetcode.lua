-- ============================================================================
-- LeetCode 刷题
-- ============================================================================

return {
  {
    'kawre/leetcode.nvim',

    build = ':TSUpdate html',

    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },

    opts = {
      arg  = 'leetcode.nvim',
      lang = 'go',

      cn = {
        enabled            = true,
        translator         = true,
        translate_problems = true,
      },
    },
  },
}
