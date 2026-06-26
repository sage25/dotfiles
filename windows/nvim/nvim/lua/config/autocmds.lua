-- ============================================================================
-- 自动命令
-- ============================================================================

-- 打开文件恢复上次光标位置 -------------------------------------------------
local group = vim.api.nvim_create_augroup('lastplace', {})

vim.api.nvim_create_autocmd('BufReadPost', {
  group   = group,
  callback = function()
    local mark       = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)

    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- 自动保存（每 5 分钟） ----------------------------------------------------
vim.fn.timer_start(300000, function()
  if vim.bo.modified then
    vim.cmd('silent write')
  end
end, { ['repeat'] = -1 })
