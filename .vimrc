" Get Vundle up and running
let g:python_host_prog='/usr/local/bin/python'
set nocompatible
filetype off
"set runtimepath+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')
Plug 'sk1418/HowMuch'
Plug 'tpope/vim-commentary'
"Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-ragtag'
Plug 'vim-scripts/groovyindent'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'bleshik/vim-vebugger'
Plug 'henrik/vim-qargs'
"Plug 'JavaImp.vim--Lee'
Plug 'vim-scripts/camelcasemotion'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'wikitopian/hardmode'
Plug 'Alotor/groovim'
Plug 'kchmck/vim-coffee-script'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'SirVer/ultisnips'
Plug 'bleshik/vim-snippets'
"Plug 'bleshik/ensime-vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
"Plug 'bleshik/grails-vim'
Plug 'xolox/vim-easytags'
Plug 'rking/ag.vim'
Plug 'vim-scripts/bufkill.vim'
Plug 'MarcWeber/vim-addon-completion'
Plug 'vim-scripts/EasyMotion'
Plug 'derekwyatt/vim-fswitch'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/gnupg.vim'
Plug 'sjl/gundo.vim'
Plug 'laurentgoudet/vim-howdoi'
Plug 'elzr/vim-json'
Plug 'derekwyatt/vim-sbt'
Plug 'derekwyatt/vim-scala'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/VisIncr'
Plug 'GEverding/vim-hocon'
Plug 'xolox/vim-misc'
Plug 'henrik/rename.vim'
Plug 'junegunn/vim-emoji'
Plug 'mxw/vim-jsx'
Plug 'Quramy/tsuquyomi'
Plug 'Quramy/vim-js-pretty-template'
Plug 'leafgarland/typescript-vim'
"Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
Plug 'udalov/kotlin-vim'
Plug 'tfnico/vim-gradle'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()
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
let g:solarized_contrast='normal'
colorscheme solarized

" Highlights when searches
set hlsearch

" Incrementally match the search
set incsearch

" Register doesn't matter
set ic

" Ruler on
set ruler

" When use 'change' character, it puts '$' at the end
set cpoptions+=$

" Copy current file path
nmap ,cp :let @" = expand("%")<CR>:call system("pbcopy", getreg('"'))<CR>:echom getreg('"')<CR>
" Same, but with line number
nmap ,cl :let @" = expand("%").":".line(".")<CR>:call system("pbcopy", getreg('"'))<CR>:echom getreg('"')<CR>
" Create a new file in the same directory
nmap ,cn :let @a = expand("%:h")<CR>:e <C-R>a/
" Move the current file
command! -nargs=* -complete=file -bang MoveTo call Rename(<q-args>, '<bang>')
nmap ,mf :let @a = expand("%")<CR>:MoveTo <C-R>a
" Copy the current file
command! -nargs=* -complete=file -bang CopyTo call s:copyCurrentFileTo(<q-args>)
nmap ,cf :let @a = expand("%")<CR>:CopyTo <C-R>a
" Copy Java canonical class name
autocmd FileType java,groovy,scala,kotlin nmap <buffer> ,cc :let @" = GetPackage(expand("%")).".".expand("%:t:r")<CR>:call system("pbcopy", getreg("\""))<CR>:echom getreg('"')<CR>

set cinoptions=j1,(1s

" IDEA-like formatting after inserting } character
autocmd FileType java,groovy,scala,kotlin inoremap <buffer> } }<C-C>m'V[{=`'a

autocmd FileType groovy nnoremap <buffer> ,bm 0f(a<cr><C-C>b%i<cr><C-C>l%wvb%ge:s/,\s*\(\w\+\):/,\r\1:/g<cr><cr>v%=
autocmd FileType java,groovy,scala,kotlin nnoremap <buffer> ,bc 0f{a<cr><C-C>]}i<cr><C-C>

" Couldn't make such a snippet
autocmd FileType groovy,scala inoremap <buffer> ,ll private final Log log = LogFactory.getLog(this.getClass())<C-C>m'<CR>:call append(2, "import org.apache.commons.logging.Log")<CR>:call append(2, "import org.apache.commons.logging.LogFactory")<CR>`'a
autocmd FileType groovy,scala nmap <buffer> ,ll o,ll<C-C>
autocmd FileType groovy,scala inoremap <buffer> ,sl private final Logger logger = LoggerFactory.getLogger(this.getClass())<C-C>m'<CR>:call append(2, "import org.slf4j.Logger")<CR>:call append(2, "import org.slf4j.LoggerFactory")<CR>`'a
autocmd FileType groovy,scala nmap <buffer> ,sl o,sl<C-C>
autocmd FileType java inoremap <buffer> ,sl private final Logger logger = LoggerFactory.getLogger(this.getClass());<C-C>m'<CR>:call append(2, "import org.slf4j.Logger;")<CR>:call append(2, "import org.slf4j.LoggerFactory;")<CR>`'a
autocmd FileType java nmap <buffer> ,sl o,sl<C-C>

" Jump to the base class
autocmd FileType java,groovy,scala nnoremap <buffer> <C-P> /\(extends\\|implements\)\s*\w\+\s*[<\s{$\[]<CR>:nohls<CR>w<C-]>:call histdel("search", -1)<CR>:let @/ = histget("search", -1)<CR>

" JSON format shortcut
autocmd FileType json nmap =j :%!python -m json.tool<CR>

" Shortcut for replacing the selected word
vmap ,r y<C-C>:%s/<C-R>"//g<LEFT><LEFT>
nmap ,r ebve,r

" To use system clipboard
" On OSX
vmap <C-C> y:call system("pbcopy", getreg("\""))<CR>
nmap <C-B> :call setreg("\"",system("pbpaste"))<CR>p
" groovyness in Insert mode (lets you paste and keep on typing)
imap <C-B> <c-c><C-B>a

nnoremap <C-J> :m .+1<CR>==
nnoremap <C-K> :m .-2<CR>==
inoremap <C-J> <Esc>:m .+1<CR>==gi
inoremap <C-K> <Esc>:m .-2<CR>==gi
vnoremap <C-J> :m '>+1<CR>gv=gv
vnoremap <C-K> :m '<-2<CR>gv=gv

" toolbars suck!
if has('gui_running')
    set guioptions-=r
    set lines=999 columns=999
    set fullscreen
endif

"For Cyrilic
"set keymap=russian-jcukenwin
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
set laststatus=2
set statusline=%f

" Font
if has("gui_running")
    set guifont=Monaco:h12
    set t_Co=8 t_md=
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
"set encoding=utf-8

" set timeout for key characters
set tm=200

" ESC on jk
imap jk <c-c>
vmap jk <c-c>
"inoremap <esc> <NOP>

" Make command line two lines high
set ch=2

" set visual bell -- i hate that damned beeping
set vb

" Show the current mode
set showmode

" Disable it... every time I hit the limit I unset this anyway. It's annoying
set textwidth=0
" Highlight the 120th column as a recommendation for maximum amount of characters in single line for code
"autocmd FileType java,groovy,javascript,typescript,coffeescript,scala setlocal colorcolumn=120
" this is too slow
"set cursorcolumn
" Highlight the current line and column
" Don't do this - It makes window redraws painfully slow
"set nocursorline
"set nocursorcolumn

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
nmap <silent> ,sv :source $MYVIMRC<CR>

" Use the bufkill plugin to eliminate a buffer but keep the window layout
nmap ,bd :BD<cr>

" use nonumber by default and toogle if needed
set nonumber
function! NumberToggle()
    if(&number == 1)
        set nonumber
        highlight LineNr ctermfg=yellow
    else
        set number 
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

command! -nargs=1 ImportClass call ImportClass(<q-args>)
autocmd FileType java,groovy,scala,kotlin nmap <buffer> ,i :execute ":ImportClass ".expand("<cword>") <CR>
autocmd FileType java,groovy,scala,kotlin nmap <buffer> ,ii :ImportClass 
autocmd FileType typescript nmap <buffer> ,i :TsuImport<CR>

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
    "let l:dir = FindGitDirOrCurrent()
    let l:dir = getcwd()
    echom a:pattern . " in " . l:dir
    execute ':Ag ' . a:pattern . ' "' . dir . '"'
endfunction

command! -nargs=+ AgProjectRoot call AgProjectRoot(<q-args>)
let s:ag_ignore="--ignore-dir=.git --ignore-dir=vendor --ignore-dir=fonts --ignore-dir=images --ignore-dir=img --ignore-dir=bower_components --ignore-dir=dist --ignore-dir=build --ignore-dir=target --ignore-dir=webpack --ignore=*.class --ignore=.tags --ignore=*.log --ignore=*.css.map --ignore=*.log.* --ignore-dir=third-party --ignore-dir=node_modules"
let g:ag_prg = 'ag --vimgrep '.s:ag_ignore

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

function! GetCurrentGitBranch()
    return system('git rev-parse --abbrev-ref HEAD 2>/dev/null | xargs echo -n')
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
    return ''
endfunction

function! GuessPackage(filename)
    let l:stopWords = [ "sbt-ctags-dep-srcs", "domain", "taglib", "integration", "unit", "services", "controllers", "jobs", "groovy", "java", "kotlin", "scala", fnamemodify(a:filename, ":e") ]
    let l:skipWords = [ ]
    if match(fnamemodify(a:filename, ":p"), $JAVA_HOME) >= 0
        call add(l:stopWords, "src")
    endif
    if match(fnamemodify(a:filename, ":p"), ".m2") >= 0
        call add(l:skipWords, ".m2")
        call add(l:stopWords, ".*\\d\\..*")
    endif
    let l:packageStarted = 0
    let l:package = ""
    let l:packageStarted = 0
    for l:dirname in split(fnamemodify(a:filename, ":p:h"), "/")
        let l:skip = 0
        for l:skipWord in l:skipWords
            if match(l:dirname, l:skipWord) >= 0
                let l:skip = 1
            endif
        endfor
        if l:skip == 0
            if l:packageStarted == 1
                let l:package = len(l:package) > 0 ? l:package.".".l:dirname : l:dirname
            endif
            if l:packageStarted == 0
                for l:stopWord in l:stopWords
                    if match(l:dirname, '^'.l:stopWord.'$\C') >= 0
                        let l:packageStarted = 1
                    endif
                endfor
            endif
        endif
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
    let l:tag = s:getJvmTypeTag(a:identifier)
    if (len(l:tag) > 0)
        let l:package = GetPackage(l:tag.filename)
        let l:suffix = ""
        if (&filetype == "java")
            let l:suffix = ";"
        endif
        call append(2, "import " . l:package . "." . l:tag.name . l:suffix)
        execute ":normal mpgg"
        silent! execute '/^import \(static\)\@\!/,?^import \(static\)\@\!?g/^\s*$/normal dd'
        execute ":normal gg"
        silent! execute ':/^import \(static\)\@\!/,?^import \(static\)\@\!?sort u'
        execute ":normal 'pzz"
        return
    endif
    echom a:identifier." was not found"
endfunction

function! GoToJvmType(typeName)
    let l:tag = s:getJvmTypeTag(a:typeName)
    if (len(l:tag) > 0)
        execute ":e ".l:tag["filename"]
    else
        execute ":tag /".a:typeName
    endif
endfunction

function! s:getJvmTypeTag(typeName)
    "let l:tags = s:getTagsContainingString(a:typeName, "", "\\(object\\|class\\|interface\\|trait\\|enum\\)\\s\\+".a:typeName."\\W", 1)
    let l:tags = Unique(
                    \filter(
                    \s:getTagsContainingString(a:typeName, "", "", 1),
                    \"(v:val.kind ==# 'c' || v:val.kind ==# 'o' || v:val.kind ==# 'i' || v:val.kind ==# 'e') && !has_key(v:val, 'class') && v:val.name ==# a:typeName"),
                \"v:val.package")
    if (len(l:tags) == 1)
        return l:tags[0]
    endif
    if (len(l:tags) <= 0)
        return {}
    endif

    let l:c = 0
    let l:tagsNames = []
    for l:tag in l:tags
        let l:c += 1
        call add(l:tagsNames, l:c.". ".string(l:tag.package.".".l:tag.name))
    endfor

    if (len(l:tagsNames) == 1)
        return l:tags[0]
    endif

    return l:tags[inputlist(l:tagsNames) - 1]
endfunction

function! s:getTagsContainingString(id, language, str, include)
    let l:tags = taglist(a:id)
    let l:result = []
    if (len(l:tags) > 0)
        for l:tag in l:tags
            if ((len(a:language) <= 0 || tolower(a:language) == tolower(l:tag.language)) &&
                        \filereadable(l:tag.filename) && (len(a:str) <= 0 ||
                        \(a:include && match(readfile(l:tag.filename), a:str) >= 0 ||
                        \!a:include && match(readfile(l:tag.filename), a:str) < 0)))
                let l:tag.package = GuessPackage(l:tag.filename)
                call add(l:result, l:tag)
            endif
        endfor
    endif
    return Unique(l:result, '(v:val["kind"]).(v:val["name"]).(fnamemodify(v:val["filename"], ":p"))')
endfunction

function! Unique(list, value)
    let l:mappedValues = map(copy(a:list), a:value)
    return filter(copy(a:list), 'index(l:mappedValues, '.a:value.', v:key+1) == -1')
endfunction

"-----------------------------------------------------------------------------
" EasyTags
"-----------------------------------------------------------------------------
command! -nargs=1 GoToJvmType call GoToJvmType(<q-args>)
autocmd FileType java,groovy,scala,kotlin nmap <buffer> <C-]> :execute ":call GoToJvmType('" . expand("<cword>") . "')"<cr>
autocmd FileType java,groovy,scala,kotlin nmap <buffer> ,tt :GoToJvmType 
autocmd FileType typescript nmap <buffer> ,tt :TsuDefinition 
" Do not update tags automatically
let g:easytags_events = []
let g:easytags_file = '.tags'
set cpoptions+=d
let g:easytags_dynamic_files = 2
let g:home_code_dir = '/Users/bleshik/K'
let g:easytags_async = 1
let g:easytags_auto_highlight = 0
let g:easytags_languages = {
            \   'scala': {
            \   },
            \   'groovy': {
            \   },
            \   'kotlin': {
            \   }
            \}

function! s:updateTagsValue()
    exe ":set tags=./.tags;,$HOME/.m2/.tags,$HOME,$JAVA_HOME/.tags,*/.tags,*/*/.tags,*/*/*/.tags"
endfunction
command! -nargs=0 UpdateTagsValue call s:updateTagsValue()
UpdateTagsValue

function! s:updateGrailsTags()
    call s:updateTagsValue() 
    call system('(for i in `find . -name "grails-app" | grep -v target` ; do (cd $i/../;grails refresh-dependencies --include-source) ; done ; find ~/.sdkman/candidates/grails/current/lib | grep "\.jar" | grep -v sources | grep -v javadoc | sed -e "s/.*\/lib\///g" | while read line ; do echo $line && [ ! -f ~/.sdkman/candidates/grails/current/lib/`echo $line | sed -e "s/\.jar/-sources.jar/g"` ] && curl --fail -L http://search.maven.org/remotecontent?filepath=`echo $line | sed -e "s/\/jars.*//g" | sed -e "s/\./\//g"`/`echo $line | sed -e "s/.*jars\///g" | sed -e "s/\(.*\)-\(.*\)\.jar/\2\/\1-\2-sources.jar/g"` > ~/.sdkman/candidates/grails/current/lib/`echo $line | sed -e "s/\.jar/-sources.jar/g"` && echo Downloaded $line ; done ; for i in `(find ~/.sdkman/candidates/grails/current/lib -name "*sources*.jar" ; find ~/.m2/repository/ -name "*sources*.jar")` ; do unzip -od `dirname $i` $i 2>&1 ; done ; echo "Tagging Grails stuff" && ctags -R -a -f .tags ~/.sdkman/candidates/grails/current/lib && ctags -R -a -f .tags ~/.m2/repository && echo "Done" && date) >> /tmp/vim-grails-refresh.log &')
endfunction
command! -nargs=0 UpdateGrailsTags call s:updateGrailsTags()

function! s:updateSbtTags()
    call system('(for i in `find . -name "build.sbt"` ; do (echo $i; cd "`dirname $i`"; rm -f .tags; sbt gen-ctags 2>&1) ; done && echo "Done" && date) >> /tmp/vim-sbt-refresh.log &')
endfunction
command! -nargs=0 UpdateSbtTags call s:updateSbtTags()

function! s:updateMavenTags()
    call system('(find ~/.m2 | grep "\.jar$" | grep -v sources | grep -v javadoc | sed -e "s/.*\/repository\///g" | while read line ; do [ ! -f ~/.m2/repository/`echo $line | sed -e "s/\.jar/-sources.jar/g"` ] && echo $line && curl --fail -L http://search.maven.org/remotecontent?filepath=`echo $line | sed -e "s/\.jar$/-sources.jar/g"` > ~/.m2/repository/`echo $line | sed -e "s/\.jar/-sources.jar/g"` && echo Downloaded $line ; done; for i in `(find ~/.m2/repository/ -name "*sources*.jar")` ; do unzip -od `dirname $i` $i 2>&1 ; done ; echo "Tagging m2 stuff" && ctags -R -a -f ~/.m2/.tags ~/.m2/repository && echo "Done" && date) >> /tmp/vim-m2-refresh.log &')
endfunction
command! -nargs=0 UpdateMavenTags call s:updateMavenTags()

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
iab retreive   retrieve
iab Retreive   Retrieve

"-----------------------------------------------------------------------------
" Grails
"-----------------------------------------------------------------------------
let g:grails_tests_suffix = "Spec"

nnoremap ,gt :let @" = GrailsTestFilename(expand('%'), g:grails_tests_suffix, 'unit')<CR>:e <C-R>"<CR>
nnoremap ,gti :let @" = GrailsTestFilename(expand('%'), g:grails_tests_suffix, 'integration')<CR>:e <C-R>"<CR>

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
autocmd FileType java,groovy,scala nmap ,vs :VBGattachJdb 5005
nmap ,vk :VBGkill<CR>

"-----------------------------------------------------------------------------
" fzf
"-----------------------------------------------------------------------------
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

nmap ,ff :call fzf#run({'source': g:ag_prg." -g .", 'sink': 'e', 'options': "--preview 'head -n 1000 {}' --color light" }, 1)<cr>
nmap ,fF :call fzf#run({'source': "cd " . expand('%:p:h') . "; " . g:ag_prg." -g .", 'sink': 'e', 'options': "--preview 'head -n 1000 " .  expand('%:p:h') . "/{}' --color light"}, 1)<cr>
nmap ,fl :Lines<cr>
nmap ,fb :Buffers<cr>
nmap ,ft :Tags<cr>

"-----------------------------------------------------------------------------
" EasyAlign
"-----------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
"vmap = <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
"nmap ga <Plug>(EasyAlign)

"-----------------------------------------------------------------------------
" JSX
"-----------------------------------------------------------------------------
let g:jsx_ext_required = 0

"-----------------------------------------------------------------------------
" Tsuquyomi
"-----------------------------------------------------------------------------
let g:tsuquyomi_shortest_import_path = 0
let g:tsuquyomi_single_quote_import = 1
let g:tsuquyomi_use_local_typescript = 0

"-----------------------------------------------------------------------------
" Ensime
"-----------------------------------------------------------------------------
"autocmd BufWritePost *.java,*.scala,*.kt silent :EnTypeCheck
"autocmd FileType java,scala,kotlin silent :EnInstall

"-----------------------------------------------------------------------------
" json-vim
"-----------------------------------------------------------------------------
let g:vim_json_syntax_conceal = 0
