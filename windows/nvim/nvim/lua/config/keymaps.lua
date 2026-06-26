-- ============================================================================
-- 按键映射
-- ============================================================================

-- 插入模式退出 ------------------------------------------------------------
vim.keymap.set('i', 'jk', '<Esc>')

-- 窗口导航（leader + hjkl） -----------------------------------------------
vim.keymap.set('n', '<leader>h', '<C-w>h')
vim.keymap.set('n', '<leader>j', '<C-w>j')
vim.keymap.set('n', '<leader>k', '<C-w>k')
vim.keymap.set('n', '<leader>l', '<C-w>l')

-- Telescope 快捷键 --------------------------------------------------------
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')

-- 粘贴模式切换 -----------------------------------------------------------
vim.keymap.set('n', '<F6>', function()
  vim.o.paste = not vim.o.paste
  print('paste: ' .. tostring(vim.o.paste))
end)
