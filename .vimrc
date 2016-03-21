" Get Vundle up and running
let g:python_host_prog='/usr/local/bin/python'
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'tpope/vim-commentary'
Plugin 'junegunn/vim-easy-align'
Plugin 'tpope/vim-ragtag'
Plugin 'vim-scripts/groovyindent'
Plugin 'Shougo/vimproc.vim'
Plugin 'bleshik/vim-vebugger'
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
Plugin 'bleshik/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'bleshik/grails-vim'
Plugin 'xolox/vim-easytags'
Plugin 'rking/ag.vim'
Plugin 'bufkill.vim'
Plugin 'MarcWeber/vim-addon-completion'
Plugin 'ctrlpvim/ctrlp.vim'
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
Plugin 'henrik/rename.vim'
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
let g:solarized_contrast="high"
let g:solarized_termcolors=256
colorscheme solarized
set background=light

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
nmap ,cp :let @a = expand("%")<CR>:call system("pbcopy", getreg("a"))<CR>
" Same, but with line number
nmap ,cl :let @a = expand("%")<CR>:call system("pbcopy", getreg("a").":".line("."))<CR>
" Create a new file in the same directory
nmap ,cn :let @a = expand("%:h")<CR>:e <C-R>a/
" Move the current file
command! -nargs=* -complete=file -bang MoveTo call Rename(<q-args>, '<bang>')
nmap ,mf :let @a = expand("%")<CR>:MoveTo <C-R>a
" Copy the current file
command! -nargs=* -complete=file -bang CopyTo call s:copyCurrentFileTo(<q-args>)
nmap ,cf :let @a = expand("%")<CR>:CopyTo <C-R>a
" Copy Java canonical class name
autocmd FileType java,groovy nmap <buffer> cc :let @" = GetPackage(expand("%")).".".expand("%:t:r")<CR>:call system("pbcopy", getreg("\""))<CR>

" IDEA-like formatting after inserting } character
autocmd FileType java,groovy inoremap <buffer> } }<C-C>m'V[{=`'a

" Couldn't make such a snippet
autocmd FileType java,groovy inoremap <buffer> ,l private final Log log = LogFactory.getLog(this.getClass())<C-C>m'<CR>:call append(2, "import org.apache.commons.logging.Log")<CR>:call append(2, "import org.apache.commons.logging.LogFactory")<CR>`'a
autocmd FileType java,groovy nmap <buffer> ,l o,l<C-C>

" Jump to the base class
autocmd FileType java,groovy nnoremap <buffer> <C-P> /extends\\|implements<CR>:nohls<CR>w<C-]>

" Shortcut for replacing the selected word
vmap ,r y<C-C>:%s/<C-R>"//g<LEFT><LEFT>
nmap ,r ebve,r

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
" Highlight the 121th column as a recommendation for maximum amount of characters in single line for code
autocmd FileType java,groovy,javascript,coffeescript,scala setlocal colorcolumn=121

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
nmap <silent> ,cr :lcd <c-r>=FindGitDirOrCurrent()<cr><cr>
nmap <silent> ,md :silent !mkdir -p %:p:h<CR>

" remove the current file
nmap <silent> ,rm :call delete(expand("%"))<CR>:bdelete!<CR>

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
au BufNewFile * :silent exe ': !mkdir -p ' . escape(fnamemodify(bufname('%'),':p:h'),'#% \\')

" copies the line above word by word
inoremap <F1> @<Esc>kyWjPA<BS>
nnoremap <F1> @<Esc>kyWjPA<BS>
inoremap <F2> <Esc>o<Esc>kyWjPA<BS><Space>
nnoremap <F2> <Esc>o<Esc>kyWjPA<BS><Space>

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
  let l:dir = FindGitDirOrCurrent()
  echom a:pattern . " in " . l:dir
  execute ':Ag ' . a:pattern . ' "' . dir . '"'
endfunction

command! -nargs=+ AgProjectRoot call AgProjectRoot(<q-args>)
let g:ag_prg = '/usr/local/bin/ag --ignore-dir=target --ignore=.vimtags --ignore=*.log --ignore=*.css.map --ignore=*.log.* --ignore-dir=third-party --ignore-dir=node_modules --vimgrep'

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
" Gundo Settings
"-----------------------------------------------------------------------------
nmap <c-F5> :GundoToggle<cr>

"-----------------------------------------------------------------------------
" EasyTags
"-----------------------------------------------------------------------------
nmap <C-]> :execute ":tag /" . expand("<cword>")<cr>
" Do not update tags automatically
let g:easytags_events = []
let g:easytags_file = '~/.vimtags'
set tags=~/.vimtags,./.vimtags;~/.vimtags,.vimtags;
set cpoptions+=d
let g:easytags_dynamic_files = 2
let g:home_code_dir = '/Users/bleshik/K'
let g:easytags_async = 1
let g:easytags_auto_highlight = 0
let g:easytags_languages = {
\   'groovy': {
\   }
\}

"-----------------------------------------------------------------------------
" Functions
"-----------------------------------------------------------------------------
function! s:copyCurrentFileTo(name)
    silent! call mkdir(fnamemodify(a:name, ":p:h"), 'p')
    exe 'saveas! ' . a:name
endfunction

function! BWipeoutAll()
  let lastbuf = bufnr('$')
  let ids = sort(filter(range(1, bufnr('$')), 'bufexists(v:val)'))
  execute ":" . ids[0] . "," . lastbuf . "bwipeout!"
  unlet lastbuf
endfunction

function! FindGitDirOrCurrent()
  let filedir = expand('%:p:h')
  if isdirectory(filedir)
    let cmd = 'bash -c "(cd ' . filedir . '; git rev-parse --show-toplevel 2>/dev/null)"'
    let gitdir = system(cmd)
    if strlen(gitdir) == 0
      return getcwd()
    else
      return gitdir[:-2] " chomp
    endif
  else
    return getcwd() 
  endif
endfunction

function! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction

function! GetPackage(filename)
	for l:line in readfile(a:filename)
    " trailing ; is optional to make it work for groovy as well
		let l:matches=matchlist(l:line,'\vpackage\s+(%(\w|\.)+)\s*;?')
		if 1<len(l:matches)
			return l:matches[1]
		endif
	endfor
	return l:className
endfunction

function! GuessPackage(filename)
    let l:stopWords = [ "domain", "taglib", "integration", "unit", "services", "controllers", "jobs", "groovy", "java", fnamemodify(a:filename, ":e") ]
    let l:packageStarted = 0
    let l:package = ""
    for l:dirname in split(fnamemodify(a:filename, ":p:h"), "/")
        if l:packageStarted
            let l:package = len(l:package) > 0 ? l:package.".".l:dirname : l:dirname
        endif
        let l:packageStarted = l:packageStarted || index(l:stopWords, l:dirname) >= 0
    endfor
    return l:package
endfunction

function! GrailsTestFilename(sourceFile, suffix, testType)
    let l:stopWords = [ "grails-app", "src" ]
    let l:grailsAppDir = ""
    for l:dirname in split(fnamemodify(a:sourceFile, ":p:h"), "/")
        if index(l:stopWords, l:dirname) >= 0
            break
        endif
        let l:grailsAppDir = l:grailsAppDir . "/" . l:dirname
    endfor
    return l:grailsAppDir . "/test/" . a:testType . "/" . tr(GuessPackage(a:sourceFile), ".", "/") . "/" . fnamemodify(a:sourceFile, ":t:r") . a:suffix . "." . fnamemodify(a:sourceFile, ":e")
endfunction

" imports java/groovy class under cursor using tags
function! ImportClass(identifier)
  for l:keyword in [ "class", "interface", "trait", "enum"]
      let l:tag = s:getTagContainingString(a:identifier, "", l:keyword."\\s\\+".a:identifier."\\W", 1)
      if (len(l:tag) > 0)
        echom l:tag.filename
        let l:package = GetPackage(l:tag.filename)
        let l:suffix = ""
        if (&filetype == "java")
          let l:suffix = ";"
        endif
        call append(2, "import " . l:package . "." . l:tag.name . l:suffix)
        return
      endif
  endfor
  echom a:identifier." was not found"
endfunction

function! s:getTagContainingString(id, language, str, include)
  let l:tags = taglist(a:id)
  if (len(l:tags) > 0)
    for l:tag in l:tags
        if ((len(a:language) <= 0 || tolower(a:language) == tolower(l:tag.language)) &&
            \filereadable(l:tag.filename) &&
            \(a:include && match(readfile(l:tag.filename), a:str) >= 0 ||
            \!a:include && match(readfile(l:tag.filename), a:str) < 0))
        return l:tag
      endif
    endfor
  endif
  return {}
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
iab recieve    receive
iab Recieve    Receive

"-----------------------------------------------------------------------------
" Grails
"-----------------------------------------------------------------------------
let g:grails_tests_suffix = "Spec"

nnoremap ,gt :let @" = GrailsTestFilename(expand('%'), g:grails_tests_suffix, 'unit')<CR>:e <C-R>"<CR>
nnoremap ,gti :let @" = GrailsTestFilename(expand('%'), g:grails_tests_suffix, 'integration')<CR>:e <C-R>"<CR>

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
        call UltiSnips#JumpForwards()
        if g:ulti_jump_forwards_res == 0
            if pumvisible()
                return "\<C-n>"
            else
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
"let g:ycm_collect_identifiers_from_tags_files = 1

"-----------------------------------------------------------------------------
" Hard Mode
"-----------------------------------------------------------------------------
" no arrows
let g:HardMode_level = "wannabe"
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

"-----------------------------------------------------------------------------
" Howdoi
"-----------------------------------------------------------------------------
map ,,h <Plug>Howdoi

"-----------------------------------------------------------------------------
" JavaImp
"-----------------------------------------------------------------------------
"let g:JavaImpDataDir = $HOME . "/.JavaImp.vim"
"let g:JavaImpPaths = system('find ~/K/risk -maxdepth 3 -type d | grep "classes" | tr "\n" "," | sed -e "s/,$//g"')

"-----------------------------------------------------------------------------
" camelcasemotion
"-----------------------------------------------------------------------------
nmap ,dw  v,wd
nmap ,db  v,bd

"-----------------------------------------------------------------------------
" vebugger 
"-----------------------------------------------------------------------------
let g:vebugger_leader=',v'
let g:vebugger_use_tags=1
function! s:attachJDB(port)
    call vebugger#jdb#start({'con': a:port})
endfunction
command! -nargs=1 VBGattachJdb call s:attachJDB(<q-args>)
autocmd FileType java,groovy nmap ,vs :VBGattachJdb 5005
nmap ,vk :VBGkill<CR>

"-----------------------------------------------------------------------------
" CtrlP
"-----------------------------------------------------------------------------
let g:ctrlp_cache_dir           = $HOME . '/.cache/ctrlp'
let g:ctrlp_max_files           = 0
let g:ctrlp_switch_buffer       = 'E'
let g:ctrlp_tabpage_position    = 'c'
let g:ctrlp_working_path_mode   = 'rc'
let g:ctrlp_open_new_file       = 'r'
let g:ctrlp_open_multiple_files = '1ri'
let g:ctrlp_match_window        = 'max:40'
let g:ctrlp_prompt_mappings     = {
  \ 'PrtSelectMove("j")':   ['<c-n>'],
  \ 'PrtSelectMove("k")':   ['<c-p>'],
  \ 'PrtHistory(-1)':       ['<c-j>', '<down>'],
  \ 'PrtHistory(1)':        ['<c-i>', '<up>']
\ }
nmap ,fb :CtrlPBuffer<cr>
nmap ,ff :CtrlP .<cr>
nmap ,fF :execute ':CtrlP ' . expand('%:p:h')<cr>
nmap ,fr :CtrlP<cr>
nmap ,fm :CtrlPMixed<cr>
nmap ,fl :CtrlPLine<cr>
nmap ,fe :CtrlP 
let g:ctrlp_map = ',ff'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|\.idea|target|third-party)$',
  \ 'file': '\v\.(exe|so|dll|class|DS_Store|swp|gitignore|log)$',
  \ 'link': 'some_bad_symbolic_links'
  \ }

"-----------------------------------------------------------------------------
" EasyAlign
"-----------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap = <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
