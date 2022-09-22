#!/bin/bash

set -e

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

# Oh My Zsh
if [ ! -d "$ZSH" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Norminette
python3 -m pip install --upgrade pip setuptools
python3 -m pip install norminette
echo 'alias norminette="python3 -m norminette' >> ~/.zshrc

# Vim
mkdir -p ~/.vim/plugin ~/.vim/colors/ ~/.vim/autoload/

# .vimrc
wget -O ~/.vimrc https://raw.githubusercontent.com/LexouDuck/42/master/.vimrc

# 42 Header
wget -O ~/.vim/plugin/stdheader.vim https://raw.githubusercontent.com/42Paris/42header/master/plugin/stdheader.vim
if [ $(echo -n "$MAIL" | wc -m) -eq 0 ]; then
    echo 'export MAIL=$USER@student.42.fr' >> ~/.zshrc
fi

# Onedark vim theme
wget -O ~/.vim/autoload/onedark.vim https://raw.githubusercontent.com/joshdick/onedark.vim/main/autoload/onedark.vim
wget -O ~/.vim/colors/onedark.vim https://raw.githubusercontent.com/joshdick/onedark.vim/main/colors/onedark.vim
echo '\n" onedark.vim theme\ncolorscheme onedark' >> ~/.vimrc

. ~/.zshrc
