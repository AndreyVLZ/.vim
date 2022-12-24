"MAIN
set encoding=utf-8
syntax on
set number relativenumber
set mouse=a
filetype plugin indent on
set nowrap
set laststatus=2
set hidden              " Позволяет иметь скрытые буферы без их сохранения
"set colorcolumn=80
set wildmenu            " Автодополнение в commandMode
set scrolloff=5         " Количество строк выше и ниже курсора при прокрутке
"set showmatch           " Показывать совпадающие скобки, когда текстовый индикатор находится над ними
"set mat=10               " Сколько десятых долей секунды мигать при совпадении скобок
set showcmd
set shortmess-=S		" Кол-во совпадений при поиски в commandLine
"set ruler
set splitbelow			" Разделение экрана внизу
set splitright			" Разделение экрана справа

"TAB
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
"set smarttab

" SEARCH
set hlsearch			" Подсветка при поиске
set incsearch         	" Поиск по мере ввода символов
set ignorecase        	" Игнорировать регистр при поиске
set smartcase         	" Поиск чувствительный к регистру, если вводится заглавная буква

"Cursor Settings
set ttimeout
set ttimeoutlen=0
set ttyfast

let &t_ti.="\e[2 q"
let &t_EI.="\e[2 q"		"EI = NORMAL mode (ELSE)
let &t_SI.="\e[6 q"		"SI = INSERT mode
let &t_SR.="\e[4 q"		"SR = REPLACE mode
"let &t_te.="\e[0 q"
" enable omni-completion
set omnifunc=syntaxcomplete#Complete

"set notitle
"  1 -> blinking block
"  2 -> solid block 
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

"Mapping
let mapleader="\\"
nnoremap <leader>ev :tabedit $MYVIMRC<CR>  
nnoremap <leader>sv :source $MYVIMRC<CR>  
nnoremap <leader>a :nohl<CR>  
"nnoremap <silent> <Space> :silent noh<Bar>echom<CR>
nnoremap <leader>t :terminal ++rows=8<CR>
nnoremap <leader>T :tab terminal<CR>
"nnoremap <ENTER> :25Vexplore<CR>
"nnoremap <ENTER> :Explore<CR>

"HI
hi CursorLineNR		cterm=NONE	ctermfg=214
hi CursorLine		cterm=NONE 	ctermbg=237
hi CursorColumn					ctermbg=237
hi ModeMsg			cterm=bold		ctermfg=210

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

let g:curMode={
	\ 'n'		: 'Normal',
	\ 'no'		: 'Normal·Operator Pending',
	\ 'v' 		: 'Visual',
	\ 'V'		: 'V·Line',
	\ "\<C-V>"	: 'V·Block',
	\ 's'		: 'Select',
	\ 'S'		: 'S·Line',
	\ "\<C-S>"	: 'S·Block',
	\ 'i'		: 'Insert',
	\ 'R'		: 'Replace',
	\ 'Rv'		: 'V·Replace',
	\ 'c'		: 'Command',
	\ 'cv'		: 'Vim Ex',	
	\ 'ce'		: 'Ex',
	\ 'r'		: 'Prompt',
	\ 'rm'		: 'More',
	\ 'r?'		: 'Confirm',
	\ '!'		: 'Shell',
	\ 't'		: 'Terminal'
\}

let g:curModeColor={
    \ 'n'		: 'hi_normal',
    \ 'i'		: 'hi_insert',
    \ 'v'		: 'hi_visual',
    \ 'c'		: 'hi_command',
    \ 'noact'		: 'hi_noact'
\}

"   name	    style_text	    color	    color_text
hi StatusLine	    cterm=reverse   ctermfg=237	    ctermbg=223 
hi StatusLineNC	    cterm=reverse   ctermfg=237	    ctermbg=249
hi hi_normal					    ctermbg=23
hi hi_insert					    ctermbg=33
hi hi_visual					    ctermbg=134
hi hi_command					    ctermbg=203
hi hi_noact		    cterm=reverse   ctermfg=246	    ctermbg=235
hi hi_mod		    cterm=bold	    ctermfg=32	    ctermbg=237
hi Warnings						    ctermbg=196

" Подсветка линии и столбца курсора только в активном окне
augroup CursorLineOnlyActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline cursorcolumn
    autocmd WinLeave * setlocal nocursorline nocursorcolumn
augroup END

" Перерисовать строку состояния текущего окна при перемещении в командную строку
augroup statusline
    autocmd!
    autocmd CmdlineEnter * if state('s')=='' | redrawstatus | endif
augroup END

func! s:liner(act)
    let s:mode_color = get(g:curModeColor, (a:act?mode():'noact'), 'Warnings')
    let s:md=mode()
    return (a:act
		\?'%#'.s:mode_color.'# '
		\.toupper(get(g:curMode, mode(), mode()))
		\.' %*'
	    \:'')
	\."%#hi_mod#"
	\." %{(!&ma||&ro)?'-':(&mod?'+':' ')} "
	\."%*"
	\.((&mod && &ma)?'%#hi_mod#%F%*':'%F')
	\."%=%{expand(&filetype)} %{strlen(&fenc)?&fenc:&enc}[%{&ff}] "
	\.'%#'.s:mode_color.'#'
	\." %3l:%02v/%L %P "
	\.'%*'
endf

fun! BuildStatusLine()
    return s:liner(g:statusline_winid ==# win_getid())
endf

"set statusline=%!BuildStatusLine()

"au FileType go packadd vim-go

" Tmux vim resize
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

" golang
  "let g:go_fmt_fail_silently = 0
  let g:go_fmt_command = 'goimports'
  "let g:go_fmt_autosave = 1
  "let g:go_gopls_enabled = 1
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_build_constraints = 1
  let g:go_auto_type_info = 1
  let g:go_auto_sameids = 0

  "let g:go_highlight_variable_declarations = 1
  "let g:go_highlight_variable_assignments = 1
  "let g:go_highlight_diagnostic_errors = 1
  "let g:go_highlight_diagnostic_warnings = 1
  "let g:go_auto_type_info = 1 " forces 'Press ENTER' too much
  "let g:go_auto_sameids = 0



autocmd vimenter * ++nested colorscheme gruvbox
set bg=dark
