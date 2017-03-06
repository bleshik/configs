#!/bin/sh

cd `dirname $0`
mkdir -p ~/.sbt/0.13/plugins
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
ln -sFf $PWD/sbt/plugins/plugins.sbt ~/.sbt/0.13/plugins/plugins.sbt
ln -sFf /dev/null ~/.bash_history
git submodule update --init --recursive
if [ ! -z "`which brew`" ] ; then
    brew install tmux
    brew install reattach-to-user-namespace
    brew install bash
    brew install fzf && /usr/local/opt/fzf/install
    brew install neovim && mkdir -p ~/.config/nvim && ln -s ~/.vimrc ~/.config/nvim/init.vim && pip install neovim --user
    brew install neovim-dot-app
    pip install websocket-client sexpdata --user
fi
