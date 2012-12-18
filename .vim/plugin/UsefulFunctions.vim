function! UsefulFunctions#LeaveOnlyExceptionsAndErrors()
   v/\cerror\|exception\|\s*\(in\|a\|в\)\s\+[A-ZА-Я]\+\./normal dd
endfunction

function! UsefulFunctions#LeaveOnlyExceptionsAndErrors2()
	exe 'normal gg'
	let i = 0
	let errorLine = -1
	let needToDelete = 0
	let useless='Throw404\|does\ not\ found\ in\ configuration\|Thread\sprocessing\srequest\|OPTIONS\|Can\ not\ find\ BargainType\ property\|Недопустимый\ запрос\ на\ ресурс\ скрипта\|Это\ недействительный\ запрос\ веб-ресурса\|Duplicate\ FileType\ (folder)\|System\.Data\.SqlClient\.SqlException\|Bargain\ type\ code\ can\ not\ be\ null\ or\ empty\|System.ArgumentException:\ Недействительный\ аргумент\ обратной\ передачи\ или\ обратного\ вызова.\|Процесс\ не\ может\ получить\ доступ\ к\ файлу\|Обнаружено\ потенциально\ опасное\ значение\ Request.Path'
	while i <= line("$")
		let line = getline(i)
		if line =~ '\[\d\+\]' || i == line("$")
			if needToDelete == 0
				let errorLine = i
				if !(line =~ 'ERROR') || line =~ useless
				   let needToDelete = 1
				endif	
			else
				if errorLine >= 0 && i > errorLine
					if i == line("$")
						let i += 1
					endif
					exe 'silent! '.errorLine.','.(i-1).'d'
					let i -= (i - errorLine + 1)
				endif
				let errorLine = i
				let needToDelete = 0
			endif
		elseif line =~ useless
			let needToDelete = 1
		endif 
		let i += 1
	endwhile
endfunction

function! UsefulFunctions#DeleteMTKUselessLogInfo()
   g/\cdoes\snot\sfound\sin\sconfiguration\|Thread\sprocessing\srequest\|OPTIONS\|Can\ not\ find\ BargainType\ property\|Недопустимый\ запрос\ на\ ресурс\ скрипта\|Это\ недействительный\ запрос\ веб-ресурса/normal dd
endfunction

let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 16
function! AdjustFontSize(amount)
  if has("gui_gtk2") && has("gui_running")
	let fontname = substitute(&guifont, s:pattern, '\1', '')
	let cursize = substitute(&guifont, s:pattern, '\2', '')
	let newsize = cursize + a:amount
	if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
	  let newfont = fontname . newsize
	  let &guifont = newfont
	endif
  else
	echoerr "You need to run the GTK2 version of Vim to use this function."
  endif
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

function! Nextmatch()
  let v:errmsg = "X"
  let s:x = bufnr("%")
  while v:errmsg != ""
	bnext
	if bufnr("%") == s:x
	  break
	endif
	1
	let v:errmsg = ""
	silent! /
  endwhile
endfunction
command! Nextmatch call Nextmatch()

function! SearchWrap()
	 let s:wr = &wrapscan
	 try
	   normal n
	 catch
	   Nextmatch
	 finally
	   let &wrapscan = s:wr
	 endtry
endfunction
command! SearchWrap call SearchWrap()

function! Badd(...)
  if(a:0 == 0)
    return
  else
    let i = a:0
    while(i > 0)
      execute 'let file = a:' . i
      execute 'badd ' . file
      let i = i - 1
    endwhile
  endif
endfunction
command! -nargs=* -complete=file Badd call Badd(<f-args>)
