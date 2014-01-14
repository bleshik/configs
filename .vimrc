" removing bad line endings
autocmd BufRead * :silent! %s/$//g

" Pathogen load
call pathogen#infect()
call pathogen#helptags()

" Set the runtimepath
silent! set runtimepath+=~/.vim/autoload
silent! set runtimepath+=~/.vim/doc

" If I'm at work (windows is dumb, can't load my plugins by himself)
silent! set runtimepath+=C:\Users\abalchunas\Dropbox\Public\Configurations\vim\.vim
silent! set runtimepath+=C:\Users\bleshik\Dropbox\Public\Configurations\vim\.vim
silent! set runtimepath+=~/configs/.vim

" Set dictionaries
silent! set dict+=~/.vim/dictionaries/drupal.dict

" Init some help articles
silent! helptags ~/.vim/doc
"
" Syntax
syntax on
let loaded_scala_syntax_checker = 0

" Number of things to remember in history.
set history=256
" Writes on make/shell commands
set autowrite

" Automatically detect file types.
"filetype on
"filetype plugin on

" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>

" Chooses colorscheme and changes some colors
set background=light
"set background=dark
let g:solarized_contrast="high"
let g:solarized_termcolors=256
set t_Co=256
"set term=xterm-256color
colorscheme solarized

" Sets comments symbols
set comments="b:#,:%,fb:-,n:>,n:)"

" Highlights when searches
set hlsearch

" Register doesn't matter
set ic

" Enables lines numbers 
"set nu

" Ruler on
set ruler

" Sets some text format
set ai sw=3 sts=3 expandtab cindent tw=0
" Line wrapping off
"set nowrap

" Enables a feature, so that cursor can be where there is no character
"set virtualedit=all

" When use 'change' character, it puts '$' at the end
set cpoptions+=$

" To use system clipboard
" On OSX
vmap <C-C> y:call system("pbcopy", getreg("\""))<CR>
nmap <C-B> :call setreg("\"",system("pbpaste"))<CR>p
" groovyness in Insert mode (lets you paste and keep on typing)
" This blows away i_CTRL-V though (see :help i_CTRL-V)
imap <C-B> <Esc><C-B>a

" My abbreviations
iab teh the

" NERD
"  NERDTree maps
nmap <Leader>v :NERDTree<cr>
vmap <Leader>v <esc>:NERDTree<cr>i
imap <Leader>v <esc>:NERDTree<cr>i

nmap <Leader>x :NERDTreeClose<cr>
vmap <Leader>x <esc>:NERDTreeClose<cr>i
imap <Leader>x <esc>:NERDTreeClose<cr>i

" pedal
"vmap <C-S-I> <esc>i
"imap <C-S-I> <esc>
"nmap <C-S-I> i

" toolbars suck!
if has('gui_running')
    set guioptions-=T
    set lines=999 columns=999
endif

"For Cyrilic
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
hi SpellBad cterm=underline ctermfg=red

" For .vimrc automatic reloading
autocmd! bufwritepost ~/Dropbox/Public/Configurations/vim/.vimrc execute "normal! :source ~/Dropbox/Public/Configurations/vim/.vimrc"

imap <C-SPACE> <C-N>

"inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>

" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set cinoptions=(0,l1,b1,J1
set cinwords=if,else,while,do,for,switch,case
"set formatoptions=cqrn
set nofoldenable
set cindent
set autoindent
set et
set listchars=tab:··
set list
set showmatch

" Filetype overrides
    " Python
        "autocmd BufWritePost *.py call Pyflakes()
        au BufRead,BufNewFile *.py set filetype=python
    " Python end   

    " Javascript / Coffeescript / Node
        au BufNewFile,BufRead *.less set filetype=less
        au BufNewFile,BufRead *.coffee set filetype=coffee
        au! BufRead,BufNewFile *.json set filetype=json 
        au BufRead,BufNewFile *.ejs set filetype=html
        au BufRead,BufNewFile *.eco set filetype=html
    " Javascript / Coffeescript / Node end

    " Web
        au BufNewFile,BufRead *.styl set filetype=stylus
        au BufNewFile,BufRead *.stylus set filetype=stylus
        au! BufWinEnter *.scss call colorv#preview("S")
        au! bufwritepost *.scss call colorv#preview("S")
        au! BufWinEnter *.styl call colorv#preview("S")
        au! bufwritepost *.styl call colorv#preview("S")
        autocmd BufNewFile,BufRead *.markdown setfiletype octopress
    " Web end

    " .NET
        au BufNewFile,BufRead *.cshtml set filetype=html
        au BufNewFile,BufRead *.master set filetype=html
        au BufNewFile,BufRead *.webconfig set filetype=xml
        au BufNewFile,BufRead *.nuspec set filetype=xml
        au BufNewFile,BufRead *.vb set filetype=vb
    " .NET end

    " C/C++
        au BufNewFile,BufRead *.c set filetype=c
        au BufNewFile,BufRead *.cpp set filetype=cpp
    " C/C++ end

    " Ruby
        au BufNewFile,BufRead *.rb set filetype=ruby
    " Ruby end
    if has("autocmd")
        autocmd Filetype java setlocal omnifunc=javacomplete#Complete
        autocmd Filetype java setlocal cfu=VjdeCompletionFun
        autocmd Filetype java retab!

        autocmd FileType tex set nocindent
        autocmd FileType tex set spelllang=ru_yo,en spell
        autocmd FileType tex nmap <C-N>l o\begin{enumerate}<ESC>
        autocmd FileType tex vmap <C-N>l <ESC>o\begin{enumerate}<ESC>
        autocmd FileType tex imap <C-N>l <ESC>o\begin{enumerate}
        autocmd FileType tex nmap <C-E>l o\end{enumerate}<ESC>
        autocmd FileType tex vmap <C-E>l <ESC>o\end{enumerate}<ESC>
        autocmd FileType tex imap <C-E>l <ESC>o\end{enumerate}
        autocmd FileType tex nmap <C-N>i i\item <ESC>
        autocmd FileType tex vmap <C-N>i <ESC>i\item <ESC>
        autocmd FileType tex imap <C-N>i <ESC>i\item <ESC>i

        autocmd FileType cshtml set filetype=html
    endif
" Filetype overrides end

" Bracket blinking.
set mat=5

" No blinking
set novisualbell
" No noise
set noerrorbells
" Always show status line
set laststatus=2

" Folding
"set nofoldenable
set foldmethod=indent
" Font
if has("gui_running")
    "set guifont=Monaco:h12:cDEFAULTset 
    set guifont=Consolas:h12:cDEFAULT
endif

" Python-mode
" Place error signs
let g:pymode_lint_signs = 1
" Run linter on the fly
let g:pymode_lint_onfly = 1
" Auto jump on first error
let g:pymode_lint_jump = 1
" Auto open cwindow if errors be finded
let g:pymode_lint_cwindow = 0

" CtrlP plugin
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|idea)$',
  \ 'file': '\v\.(exe|so|dll|class|DS_Store|swp|gitignore)$',
  \ 'link': 'some_bad_symbolic_links'
  \ }

" tabs
map <C-Tab> gt
map <C-S-Tab> gT

" buffers
nmap <C-l> :bn<CR>
vmap <C-l> <ESC>:bn<CR>
imap <C-l> <ESC>:bn<CR>i
nmap <C-h> :bp<CR>
vmap <C-h> <ESC>:bn<CR>
imap <C-h> <ESC>:bn<CR>i

" To jump over several buffer while search
nmap <C-S-N> :SearchWrap<CR>
"nmap n :cnext<CR>

if has('statusline')
    set laststatus=2
    " Broken down into easily includeable segments
    set statusline=%<%f\    " Filename
    set statusline+=\ [%{&ff}/%Y]            " filetype
    set statusline+=\ [%{getcwd()}]          " current dir
endif

" encodings
set fileencodings=utf-8,cp1251,koi8-r,ucs-2,cp866
set encoding=utf-8

" set timeout for key characters
set tm=200

" vimdiff
set diffopt+=iwhite
