" Get Vundle up and running
set nocompatible
filetype off 
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'henrik/vim-qargs'
Plugin 'JavaImp.vim--Lee'
Plugin 'camelcasemotion'
Plugin 'jeetsukumaran/vim-indentwise'
Plugin 'wikitopian/hardmode'
Plugin 'Alotor/groovim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bleshik/grails-vim'
Plugin 'xolox/vim-easytags'
Plugin 'rking/ag.vim'
Plugin 'bufkill.vim'
Plugin 'MarcWeber/vim-addon-completion'
Plugin 'kien/ctrlp.vim'
Plugin 'EasyMotion'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/gnupg.vim'
Plugin 'sjl/gundo.vim'
Plugin 'laurentgoudet/vim-howdoi'
Plugin 'elzr/vim-json'
Plugin 'scrooloose/nerdtree'
Plugin 'derekwyatt/vim-sbt'
Plugin 'derekwyatt/vim-scala'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-unimpaired'
Plugin 'VisIncr'
Plugin 'GEverding/vim-hocon'
Plugin 'xolox/vim-misc'
call vundle#end()
filetype plugin indent on
syntax on

" I got used to switching between tabs using <C-Tab> in every apps
nnoremap <C-tab>   :e#<CR>
inoremap <C-tab>   <Esc>:e#<CR>i

" default tab settings
set tabstop=4 shiftwidth=4 expandtab

" make backspace work
set backspace=indent,eol,start

" switch files without saving 
set hidden

" disable folding
set nofoldenable

" Chooses colorscheme and changes some colors
set background=light
let g:solarized_contrast="high"
let g:solarized_termcolors=256
colorscheme solarized

" Highlights when searches
set hlsearch

" Incrementally match the search
set incsearch

" Register doesn't matter
set ic

" Enables lines numbers 
set nu

" Ruler on
set ruler

" When use 'change' character, it puts '$' at the end
set cpoptions+=$

" Copy current file path
nmap cp :let @" = expand("%")<CR>:call system("pbcopy", getreg("\""))<CR>

" To use system clipboard
" On OSX
vmap <C-C> y:call system("pbcopy", getreg("\""))<CR>
nmap <C-B> :call setreg("\"",system("pbpaste"))<CR>p
" groovyness in Insert mode (lets you paste and keep on typing)
imap <C-B> <c-c><C-B>a

" NERD
"  NERDTree maps
nmap ,v :NERDTree<cr>
vmap ,v <c-c>:NERDTree<cr>i
imap ,v <c-c>:NERDTree<cr>i

nmap ,x :NERDTreeClose<cr>
vmap ,x <c-c>:NERDTreeClose<cr>i
imap ,x <c-c>:NERDTreeClose<cr>i

" toolbars suck!
if has('gui_running')
    set guioptions-=r
    set lines=999 columns=999
    set fullscreen
endif

"For Cyrilic
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
hi SpellBad cterm=underline ctermfg=red

" For .vimrc automatic reloading
autocmd! bufwritepost ~/.vimrc execute "normal! :source ~/.vimrc"

" Bracket blinking.
set mat=5

" No blinking
set novisualbell
" No noise
set noerrorbells
" Always show status line
"set laststatus=2

" Font
if has("gui_running")
    set guifont=Menlo:h10:cDEFAULT
endif

" CtrlP plugin
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|idea)$',
  \ 'file': '\v\.(exe|so|dll|class|DS_Store|swp|gitignore)$',
  \ 'link': 'some_bad_symbolic_links'
  \ }

" buffers
nmap <C-l> :bn<CR>
vmap <C-l> <c-c>:bn<CR>
imap <C-l> <c-c>:bn<CR>i
nmap <C-h> :bp<CR>
vmap <C-h> <c-c>:bn<CR>
imap <C-h> <c-c>:bn<CR>i

" encodings
set fileencodings=utf-8,cp1251,koi8-r,ucs-2,cp866
set encoding=utf-8

" set timeout for key characters
set tm=200

" ESC on jk
imap jk <c-c>:w<cr>
vmap jk <c-c>

" Make command line two lines high
set ch=2

" set visual bell -- i hate that damned beeping
set vb

" Show the current mode
set showmode

" Disable it... every time I hit the limit I unset this anyway. It's annoying
set textwidth=0

" When completing by tag, show the whole tag, not just the function name
set showfulltag

" Automatically read a file that has changed on disk
set autoread

" OK, so I'm gonna remove the VIM safety net for a while and see if kicks my ass
set nobackup
set nowritebackup
set noswapfile

" System default for mappings is now the "," character
let mapleader = ","

" Wipe out all buffers
nmap <silent> ,wa :call BWipeoutAll()<cr>

" cd to the directory containing the file in the buffer
nmap <silent> ,cd :lcd %:h<CR>
nmap <silent> ,cr :lcd <c-r>=FindGitDirOrRoot()<cr><cr>
nmap <silent> ,md :silent !mkdir -p %:p:h<CR>

" Turn off that stupid highlight search
nmap <silent> ,n :nohls<CR>

" set text wrapping toggles
nmap <silent> ,ww :set invwrap<cr>
nmap <silent> ,wW :windo set invwrap<cr>

" Edit the vimrc file
nmap <silent> ,ev :e $MYVIMRC<CR>

" Use the bufkill plugin to eliminate a buffer but keep the window layout
nmap ,bd :BD<cr>

" Highlight the current line and column
" Don't do this - It makes window redraws painfully slow
set nocursorline
set nocursorcolumn

" use number by default and toogle if needed
set norelativenumber
set number
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
    highlight LineNr ctermfg=yellow
  else
    set relativenumber
    highlight LineNr ctermfg=green
  endif
endfunc
nnoremap ,t :call NumberToggle()<cr>

" add E command so that I can easily create a file with its directories,
" which is especially relevant in java with its package conventions
au BufNewFile * :exe ': !mkdir -p ' . escape(fnamemodify(bufname('%'),':p:h'),'#% \\')

" copies the line above word by word
inoremap <F1> @<Esc>kyWjPA<BS>
nnoremap <F1> @<Esc>kyWjPA<BS>
inoremap <F2> <Esc>o<Esc>kyWjPA<BS><Space>
nnoremap <F2> <Esc>o<Esc>kyWjPA<BS><Space>

" imports java/groovy class under cursor using tags
function! ImportClass(identifier)
  let tags = taglist(a:identifier)
  if (len(tags) > 0)
    let cmd = 'cat ' . tags[0].filename . ' | grep package | head -n1 | sed -e "s/^ *package *\(.*\) *;* */\1/g" | tr "\n" "."'
    let package = system(cmd)
    let suffix = ""
    if (&filetype == "java")
      suffix = ";"
    endif
    call append(2, "import " . package . tags[0].name . suffix)
  endif
endfunction
nmap ,i :execute ":call ImportClass('" . expand("<cword>") . "')" <CR>

"-----------------------------------------------------------------------------
" Fugitive
"-----------------------------------------------------------------------------
" Thanks to Drew Neil
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \  noremap <buffer> .. :edit %:h<cr> |
  \ endif
autocmd BufReadPost fugitive://* set bufhidden=delete

"nmap ,gs :Gstatus<cr>
"nmap ,ge :Gedit<cr>
"nmap ,gw :Gwrite<cr>
"nmap ,gr :Gread<cr>

"-----------------------------------------------------------------------------
" AG (SilverSearcher) Settings
"-----------------------------------------------------------------------------
function! AgProjectRoot(pattern)
  echom a:pattern
  let dir = FindGitDirOrRoot()
  execute ':Ag ' . a:pattern . ' ' . dir
endfunction

command! -nargs=+ AgProjectRoot call AgProjectRoot(<q-args>)
let g:agprg = '/usr/local/bin/ag --ignore=*.log --ignore=*.log.* --ignore-dir=target --ignore-dir=third-party --vimgrep'

nmap ,sr :AgProjectRoot 
nmap ,ss :execute ":AgProjectRoot " . expand("<cword>") <CR>

"-----------------------------------------------------------------------------
" FSwitch mappings
"-----------------------------------------------------------------------------
nmap <silent> ,of :FSHere<CR>
nmap <silent> ,ol :FSRight<CR>
nmap <silent> ,oL :FSSplitRight<CR>
nmap <silent> ,oh :FSLeft<CR>
nmap <silent> ,oH :FSSplitLeft<CR>
nmap <silent> ,ok :FSAbove<CR>
nmap <silent> ,oK :FSSplitAbove<CR>
nmap <silent> ,oj :FSBelow<CR>
nmap <silent> ,oJ :FSSplitBelow<CR>

"-----------------------------------------------------------------------------
" CtrlP Settings
"-----------------------------------------------------------------------------
let g:ctrlp_switch_buffer = 'E'
let g:ctrlp_tabpage_position = 'c'
let g:ctrlp_working_path_mode = 'rc'
"let g:ctrlp_root_markers = ['.project.root']
"let g:ctrlp_custom_ignore = '\v'
"let g:ctrlp_custom_ignore .= '%(/\.'
"let g:ctrlp_custom_ignore .= '%(git|hg|svn)|'
"let g:ctrlp_custom_ignore .= '\.%(class|o|png|jpg|jpeg|bmp|tar|jar|tgz|deb|zip|xml|html)$|'
"let g:ctrlp_custom_ignore .= '/target/%(quickfix|resolution-cache|streams)|'
"let g:ctrlp_custom_ignore .= '/target/scala-2.1./%(classes|test-classes|sbt-0.13|cache)|'
"let g:ctrlp_custom_ignore .= '/project/target|/project/project'
"let g:ctrlp_custom_ignore .= ')'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_open_multiple_files = '1ri'
let g:ctrlp_match_window = 'max:40'
let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")':   ['<c-n>'],
  \ 'PrtSelectMove("k")':   ['<c-p>'],
  \ 'PrtHistory(-1)':       ['<c-j>', '<down>'],
  \ 'PrtHistory(1)':        ['<c-i>', '<up>']
\ }
nmap ,fb :CtrlPBuffer<cr>
nmap ,ff :CtrlP .<cr>
nmap ,fF :execute ":CtrlP " . expand('%:p:h')<cr>
nmap ,fr :CtrlP<cr>
nmap ,fm :CtrlPMixed<cr>

"-----------------------------------------------------------------------------
" Gundo Settings
"-----------------------------------------------------------------------------
nmap <c-F5> :GundoToggle<cr>

"-----------------------------------------------------------------------------
" EasyTags
"-----------------------------------------------------------------------------
nmap <C-]> :execute ":tag /" . expand("<cword>")<cr>
let g:easytags_file = '~/.vimtags'
set tags=~/.vimtags;
let g:home_code_dir = '/Users/bleshik/K'
let g:easytags_async = 1
let g:easytags_auto_highlight = 1
let g:easytags_languages = {
\   'groovy': {
\   }
\}

"-----------------------------------------------------------------------------
" Functions
"-----------------------------------------------------------------------------
function! BWipeoutAll()
  let lastbuf = bufnr('$')
  let ids = sort(filter(range(1, bufnr('$')), 'bufexists(v:val)'))
  execute ":" . ids[0] . "," . lastbuf . "bwipeout!"
  unlet lastbuf
endfunction

function! FindGitDirOrRoot()
  let filedir = expand('%:p:h')
  if isdirectory(filedir)
    let cmd = 'bash -c "(cd ' . filedir . '; git rev-parse --show-toplevel 2>/dev/null)"'
    let gitdir = system(cmd)
    if strlen(gitdir) == 0
      return g:home_code_dir
    else
      return gitdir[:-2] " chomp
    endif
  else
    return '/'
  endif
endfunction

"-----------------------------------------------------------------------------
" Fix constant spelling mistakes
"-----------------------------------------------------------------------------

iab Acheive    Achieve
iab acheive    achieve
iab Alos       Also
iab alos       also
iab Aslo       Also
iab aslo       also
iab Becuase    Because
iab becuase    because
iab Bianries   Binaries
iab bianries   binaries
iab Bianry     Binary
iab bianry     binary
iab Charcter   Character
iab charcter   character
iab Charcters  Characters
iab charcters  characters
iab Exmaple    Example
iab exmaple    example
iab Exmaples   Examples
iab exmaples   examples
iab Fone       Phone
iab fone       phone
iab Lifecycle  Life-cycle
iab lifecycle  life-cycle
iab Lifecycles Life-cycles
iab lifecycles life-cycles
iab Seperate   Separate
iab seperate   separate
iab Seureth    Suereth
iab seureth    suereth
iab Shoudl     Should
iab shoudl     should
iab Taht       That
iab taht       that
iab Teh        The
iab teh        the

"-----------------------------------------------------------------------------
" Grails
"-----------------------------------------------------------------------------
let g:grails_tests_suffix = "Spec"

function! UpdateGrailsTags()
    system('(for i in `find . -name "grails-app" | grep -v target` ; do (echo $i/../; grails refresh-dependencies --include-source 2>&1 >> /tmp/vim-grails-refresh.log) ; done && for i in `find ~/.gvm/grails/current/lib -name "*sources*.jar"` ; do tar -xvf $i -C `dirname $i` 2>&1 >> /tmp/vim-grails-refresh.log ; done) &')
endfunction

"-----------------------------------------------------------------------------
" UtilSnips 
"-----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<tab>"
" UltiSnips completion function that tries to expand a snippet. If there's no
" snippet for expanding, it checks for completion window and if it's
" shown, selects first element. If there's no completion window it tries to
" jump to next placeholder. If there's no placeholder it just returns TAB key 
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

"-----------------------------------------------------------------------------
" YouCompleteMe
"-----------------------------------------------------------------------------
let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
let g:ycm_collect_identifiers_from_tags_files = 1

"-----------------------------------------------------------------------------
" Hard Mode
"-----------------------------------------------------------------------------
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

"-----------------------------------------------------------------------------
" JavaImp
"-----------------------------------------------------------------------------
"let g:JavaImpDataDir = $HOME . "/.JavaImp.vim"
"let g:JavaImpPaths = system('find ~/K/risk -maxdepth 3 -type d | grep "classes" | tr "\n" "," | sed -e "s/,$//g"')
