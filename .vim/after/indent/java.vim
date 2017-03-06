setlocal indentexpr=GetMyJavaIndent()
function! GetMyJavaIndent()
    " When the line starts with a ), try aligning it with the matching (
    if getline(v:lnum) =~ '^\s*)'
        call cursor(v:lnum, 1)
        silent normal! %
        let lnum = line('.')
        if lnum < v:lnum
            return indent(lnum)
        endif
    endif
    return GetJavaIndent()
endfunction
