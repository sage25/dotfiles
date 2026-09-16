LINUXDIR := $(CURDIR)
export LINUXDIR

VIM_SH = vim/install.sh
NODE_SH = nodejs/install.sh
WGET_SH = wget/install.sh

.PHONY: vim nodejs wget
vim: nodejs
	bash $(VIM_SH)

nodejs: wget
	bash $(NODE_SH)

wget:
	bash $(WGET_SH)
