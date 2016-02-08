#!/bin/sh

cd `dirname $0`
ln -sFf $PWD/.inputrc ~/.inputrc
ln -sFf $PWD/.ctags ~/.ctags
ln -sFf $PWD/.vim ~/.vim
ln -sFf $PWD/.vimrc ~/.vimrc
ln -sFf $PWD/.bashrc ~/.bashrc
ln -sFf $PWD/.bash_aliases ~/.bash_aliases
ln -sFf $PWD/.bash_rm_aliases ~/.bash_rm_aliases
ln -sFf $PWD/.bash_profile ~/.bash_profile
ln -sFf $PWD/.tmux.conf ~/.tmux.conf
ln -sFf $PWD/.gitconfig ~/.gitconfig
ln -sFf $PWD/.git-completion.bash ~/.git-completion.bash
ln -sFf $PWD/git-hooks ~/.git-hooks
ln -sFf $PWD/.gradle-tab-completion.bash ~/.gradle-tab-completion.bash
ln -sFf $PWD/grails/.grails-completion.sh ~/.grails-completion.sh
ln -sFf $PWD/scripts ~/.scripts
ln -sFf $PWD/.bash_plugins ~/.bash_plugins
ln -sFf /dev/null ~/.bash_history
git submodule update --init --recursive
brew install tmux
brew install cpanm
sudo cpanm App::AltSQL
