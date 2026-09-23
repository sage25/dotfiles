LINUXDIR := $(CURDIR)
export LINUXDIR

VIM_SH = vim/install.sh
NODE_SH = nodejs/install.sh

.PHONY: vim nodejs wget
vim: nodejs
	bash $(VIM_SH)

nodejs:
	bash $(NODE_SH)
