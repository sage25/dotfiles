DOTFILE_LINUX := $(CURDIR)
VIM_SH = vim/install.sh
NODE_SH = nodejs/install.sh

WGET_SH = wget/install.sh

.PHONY: vim
vim: $(VIM_SH)
	bash $(VIM_SH)

$(VIM_SH): $(NODE_SH)
	bash $(NODE_SH)

$(NODE_SH): $(WGET_SH)
	bash $(WGET_SH)
