#!/bin/bash

set -e

if [ $(uname) = "Linux" ]; then
	sudo apt-get -y update
	sudo apt-get -y upgrade

	sudo apt-get install -y clang \
                                git \
				curl \
				make \
				python3 \
				pip \
				vim \
				zsh
	# Norminette
	python3 -m pip install --upgrade pip setuptools
	python3 -m pip install norminette
else
	brew update
	brew upgrade
fi

# Oh My Zsh
if [ ! -d "$ZSH" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

zsh -c "source ~/.zshrc && alias norminette" &> /dev/null
if [ $? -ne 0 ]; then
    echo 'alias norminette="python3 -m norminette' >> ~/.zshrc
fi

# Vim
mkdir -p ~/.vim/plugin ~/.vim/colors/ ~/.vim/autoload/
if [ ! -d ~/.vim/pack/plugins/start/vim-polyglot ]; then
    git clone https://github.com/sheerun/vim-polyglot.git ~/.vim/pack/plugins/start/vim-polyglot
fi

# .vimrc
wget -O ~/.vimrc https://raw.githubusercontent.com/ugo-dt/templates/main/.vimrc --no-check-certificate

# 42 Header
wget -O ~/.vim/plugin/stdheader.vim https://raw.githubusercontent.com/ugo-dt/templates/main/.vim/plugin/stdheader.vim --no-check-certificate
if [ $(echo -n "$MAIL" | wc -m) -eq 0 ]; then
    echo 'export MAIL=$USER@student.42.fr' >> ~/.zshrc
fi

# Onedark vim theme
wget -O ~/.vim/autoload/onedark.vim https://raw.githubusercontent.com/ugo-dt/templates/main/.vim/autoload/onedark.vim --no-check-certificate
wget -O ~/.vim/colors/onedark.vim https://raw.githubusercontent.com/ugo-dt/templates/main/.vim/colors/onedark.vim --no-check-certificate
### echo '\n" onedark.vim theme\ncolorscheme onedark' >> ~/.vimrc
