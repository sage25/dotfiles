-- ============================================================================
-- Blink.cmp — 自动补全
-- ============================================================================

return {
  {
    'saghen/blink.cmp',

    dependencies = {
      'rafamadriz/friendly-snippets',
    },

    version = '*',

    opts = {
      sources = {
        default = { 'lsp', 'snippets', 'path' },
      },
      keymap = {
        ['<Tab>']   = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<CR>']    = { 'accept', 'fallback' },
      },
      appearance = {
        nerd_font_variant = 'mono',
    },
    completion = {
      list = {
        selection = {
          preselect = false,
            auto_insert = false,
          },
      },
      documentation = {
        auto_show = true,
      },
  },
},
  },
}
