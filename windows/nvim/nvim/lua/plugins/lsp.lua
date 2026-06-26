-- ============================================================================
-- LSP - language server
-- ============================================================================

return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      -- 手动启动 gopls，先解析 exepath 再调用 lsp.start
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'go',
        group   = vim.api.nvim_create_augroup('lsp-gopls', { clear = true }),
        callback = function(ev)
          local bufnr = ev.buf
          local config = vim.lsp.config.gopls
          if not config then return end
          
          -- 在 Windows 上，需要将命令解析为完整路径（同 lspconfig 的 sanitize_cmd）
          if vim.fn.has('win32') == 1 and type(config.cmd) == 'table' and #config.cmd > 0 then
            local exe = vim.fn.exepath(config.cmd[1])
            if #exe > 0 then
              config.cmd[1] = exe
            end
          end
          
          vim.lsp.start(config, { bufnr = bufnr })
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = { "gopls" },
      automatic_installation = true,
      automatic_enable = false,
    },
  },
}
