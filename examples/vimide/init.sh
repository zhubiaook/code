#!/usr/bin/bash

install_protobuf() {
	# install protobuf
	cd /tmp/
	git clone --depth=1 https://github.com/protocolbuffers/protobuf
	cd protobuf
	./autogen.sh
	./configure
	make
	sudo make install
	protoc --version

	# install protoc-gen-go
	go get -u github.com/golang/protobuf/protoc-gen-go
}

install_ohmyzsh() {
	# install zsh
	dnf -y install zsh

	# install oh-my-zsh
	curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o tmpl/ohmyzsh-install.sh
	bash tmpl/ohmyzsh-install.sh
	
	# zsh as default shell
	usermod -s /bin/zsh root

	mv ~/.zshrc{,.bk}
	cp tmpl/zshrc ~/.zshrc

	# plugins
	# zsh-autosuggestions & zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
}

install_go() {
	version=1.16

	mkdir pkg
	cd pkg
	wget https://go.dev/dl/go1.16.14.linux-amd64.tar.gz
	pkg=go${version}*.linux-amd64.tar.gz
	mkdir -p /opt/go
	tar -xvf pkg/$pkg -C /opt/go
	mv /opt/go/{go,go$version}
	sed -ri "s/^export GOVERSION=.*$/export GOVERSION=go$version/" ~/.zshrc
}

install_neovim() {
	dnf -y install neovim
}

install_spacevim() {
	cd /tmp
	wget https://marmotedu-1254073058.cos.ap-beijing.myqcloud.com/tools/marmotVim.tar.gz
	tar -xvzf marmotVim.tar.gz
	cd marmotVim
	./marmotVimCtl install

	# python dependence
	pip3 install pynvim flake8 yapf autoflake isort jedi
}

install_python() {
	dnf -y install python3 python3-pip
	
	mkdir ~/.pip
	echo -e "[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple" > ~/.pip/pip.conf 
}

basic_env() {
	dnf -y install vim git wget tree

	# workspace
	mkdir /home/workspace
	
	# git config
	git config --global user.name "zhubiaook"
	git config --global user.email "zhubiaook@outlook.com"
	git config --global credential.helper store
	git config --global core.longpaths true
 	git config --global core.quotepath off
	git lfs install --skip-repo
}

dev_env() {
	dnf -y install make autoconf automake cmake perl-CPAN libcurl-devel libtool gcc gcc-c++ glibc-headers zlib-devel git-lfs telnet ctags lrzsz jq expat-devel openssl-devel

  # go
	install_go
	
	# protobuf
	install_protobuf

	# python
	install_python

	# neovim
	install_neovim

  # spacevim
  install_spacevim
}

uninstall() {
  uninstall_oh_my_zsh
  cd /tmp/marmotVim && ./marmotVimCtl uninstall
}

if [[ "$#" -eq 1 ]]; then
	"$1"
else
	basic_env
	install_ohmyzsh
	dev_env
fi
