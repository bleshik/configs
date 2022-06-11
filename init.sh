#!/bin/sh

cd `dirname $0`
ln -sFf $PWD/.inputrc ~/.inputrc
ln -sFf $PWD/.ctags ~/.ctags
ln -sFf $PWD/.vim ~/.vim
ln -sFf $PWD/.vimrc ~/.vimrc
ln -sFf $PWD/.bashrc ~/.bashrc
ln -sFf $PWD/.bash_aliases ~/.bash_aliases
ln -sFf $PWD/.bash_profile ~/.bash_profile
ln -sFf $PWD/.gitconfig ~/.gitconfig
ln -sFf $PWD/.git-completion.bash ~/.git-completion.bash
ln -sFf $PWD/git-hooks ~/.git-hooks
ln -sFf $PWD/scripts ~/.scripts
ln -sFf $PWD/.bash_plugins ~/.bash_plugins
ln -sFf /dev/null ~/.bash_history
mkdir -p ~/.config/nvim/
ln -sFf $PWD/neovim/init.vim ~/.config/nvim/init.vim
git submodule init
git submodule update --init --recursive
if [ ! -z "`which brew`" ] ; then
    brew install bash
    brew install fzf && /usr/local/opt/fzf/install
    brew install the_silver_searcher
    brew install jq
fi
