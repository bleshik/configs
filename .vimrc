source ~/.vim/commonrc.vim

call plug#begin('~/.vim/plugged')
source ~/.vim/common-plugs.vim
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
call plug#end()
