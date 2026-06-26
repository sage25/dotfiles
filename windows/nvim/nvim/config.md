# Neovim 配置说明

项目结构基于 lazy.nvim 插件管理器，入口为 init.lua，配置模块位于 lua/config/，插件定义位于 lua/plugins/。

---

## 入口文件

### init.lua
- **作用**：Neovim 启动入口
- **如何配置**：按顺序 require 以下四个配置模块：
  - config.options — 基础选项
  - config.keymaps — 按键映射
  - config.autocmds — 自动命令
  - config.lazy — lazy.nvim 启动器

---

## 基础配置 (lua/config/)

### options.lua — Neovim 基础选项
- **作用**：设置编辑器核心行为选项
- **可配置项**（通过 im.opt / im.g）：
  - mapleader / maplocalleader — 前缀键
  - 
umber / elativenumber — 行号模式
  - cursorline / scrolloff — 光标显示
  - guicursor — 各模式光标样式
  - expandtab / 	abstop / shiftwidth / softtabstop / smartindent — 缩进
  - ignorecase / smartcase — 搜索
  - mouse — 鼠标支持
  - 	ermguicolors — 真彩色
  - splitbelow / splitright — 分屏方向
  - completeopt — 补全弹窗行为
  - updatetime — 更新时间
  - hidden — 隐藏缓冲区
  - undofile / undodir — 撤销持久化

### keymaps.lua — 按键映射
- **作用**：自定义编辑器快捷键
- **如何配置**：使用 im.keymap.set(mode, lhs, rhs, opts)
  - 插入模式退出键：jk → <Esc>
  - 窗口导航：leader+h/j/k/l → 各方向窗口跳转
  - Telescope 快捷键：leader+ff 查找文件、leader+fg 内容搜索、leader+fb 缓冲区列表
  - 粘贴模式切换：F6
- **需删除**：Ctrl+S 保存、leader+gs Git、Esc 清除高亮（用户未选择）

### utocmds.lua — 自动命令
- **作用**：文件事件触发自动行为
- **如何配置**：使用 im.api.nvim_create_autocmd(event, opts) 和 im.fn.timer_start
  - BufReadPost — 打开文件时恢复上次光标位置
  - 	imer_start(300000, ...) — 每 5 分钟自动保存修改

### lazy.lua — 插件管理器
- **作用**：自动安装并启动 lazy.nvim 插件管理器
- **如何配置**：
  - 判断 lazy.nvim 是否已安装，未装则 git clone
  - im.opt.rtp:prepend(lazypath) 加入 runtimepath
  - equire("lazy").setup({ import = "plugins" }) 导入 lua/plugins/ 下所有插件定义

---

## 插件配置 (lua/plugins/)

### 	elescope.lua — 模糊查找
- **插件**：
vim-telescope/telescope.nvim
- **依赖**：
vim-lua/plenary.nvim、
vim-telescope/telescope-ui-select.nvim、
vim-telescope/telescope-frecency.nvim
- **作用**：文件/文本/缓冲区模糊搜索
- **如何配置**：
  - equire("telescope").setup({ extensions }) 注册扩展
  - equire("telescope").load_extension("ui-select") 替换 im.ui.select
  - equire("telescope").load_extension("frecency") 启用频率排序
  - 快捷键已在 keymaps.lua 中绑定

### 	reesitter.lua — 语法高亮
- **插件**：
vim-treesitter/nvim-treesitter
- **作用**：基于语法树的高亮和解析
- **如何配置**：在 ensure_installed 列表声明语言（c, cpp, lua, vim, markdown, go），highlight.enable = true

### lsp.lua — 语言服务
- **插件**：
  - williamboman/mason.nvim — LSP 安装管理器
  - williamboman/mason-lspconfig.nvim — 桥接层
  - 
eovim/nvim-lspconfig — LSP 客户端
- **作用**：代码补全、诊断、跳转、悬停提示等
- **如何配置**：
  - equire("mason").setup() 初始化
  - equire("mason-lspconfig").setup({ ensure_installed = { "gopls" } }) 自动安装
  - im.lsp.enable("gopls") 启用服务器

### completion.lua — 自动补全
- **插件**：saghen/blink.cmp
- **依赖**：afamadriz/friendly-snippets
- **作用**：代码补全弹窗
- **如何配置**：在 opts 中指定补全来源（LSP、snippets、path 等）、快捷键预设、图标集、文档自动显示、模糊匹配实现

### 
eotree.lua — 文件树
- **插件**：
vim-neo-tree/neo-tree.nvim
- **依赖**：
vim-lua/plenary.nvim、
vim-tree/nvim-web-devicons、MunifTanjim/nui.nvim
- **作用**：侧边栏文件浏览器
- **如何配置**：config 回调中 equire("neo-tree").setup({ close_if_last_window = true })
  - close_if_last_window = true — 当文件树是最后一个窗口时自动关闭

### lualine.lua — 状态栏
- **插件**：
vim-lualine/lualine.nvim
- **作用**：美化底部状态栏
- **如何配置**：自定义以下内容：
  - **主题**：不同模式（Normal/Insert/Visual）显示不同颜色
  - **a 段**：模式标识
  - **b 段**：文件路径
  - **c 段**：LSP 状态（通过 equire('lsp-status') 或内置检测）
  - **x 段**：编码
  - **y 段**：文件格式

### whichkey.lua — 按键提示
- **插件**：olke/which-key.nvim
- **作用**：按前缀键后弹出可用快捷键提示
- **如何配置**：config = true 使用默认设置

### colorscheme.lua — 配色方案
- **插件**：catppuccin/nvim
- **作用**：编辑器颜色主题
- **如何配置**：equire("catppuccin").setup() 初始化，im.cmd.colorscheme("catppuccin") 应用

### dashboard.lua — 启动页
- **插件**：
vimdev/dashboard-nvim
- **依赖**：
vim-tree/nvim-web-devicons
- **作用**：Neovim 启动欢迎界面
- **如何配置**：在 opts 中配置：
  - **按钮**：最近文件、打开配置
  - 其他可选：头部图标、底部信息

### git.lua — Git 集成
- **插件**：
  - 	pope/vim-fugitive — Git 命令面板
  - lewis6991/gitsigns.nvim — 行内 git 状态标志
- **作用**：版本控制
- **如何配置**：gitsigns 用 config = true 默认配置

### leetcode.lua — LeetCode 刷题
- **插件**：kawre/leetcode.nvim
- **依赖**：
vim-lua/plenary.nvim、MunifTanjim/nui.nvim
- **作用**：在 Neovim 中刷 LeetCode
- **如何配置**：在 opts 中指定 lang = "go"，cn = { enabled = true, translator = true, translate_problems = true }

### comment.lua — 代码注释
- **插件**：
umToStr/Comment.nvim
- **作用**：快速注释/取消注释
- **如何配置**：config = true 默认配置

### indent.lua — 缩进线
- **插件**：lukas-reineke/indent-blankline.nvim
- **作用**：显示缩进参考线
- **如何配置**：equire("ibl").setup() 默认配置

### utopairs.lua — 自动括号
- **插件**：windwp/nvim-autopairs
- **作用**：自动补全括号和引号
- **如何配置**：equire("nvim-autopairs").setup() 默认配置

### surround.lua — 环绕编辑
- **插件**：kylechui/nvim-surround
- **作用**：添加/删除/修改环绕字符（括号、引号、HTML 标签等）
- **如何配置**：equire("nvim-surround").setup() 默认配置
