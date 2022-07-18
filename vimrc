" 前言：About Backup
"
" 到任何一台新机器, 备份策略
" https://blog.hulifa.cn/2019-10-20-Vim-8%E5%86%85%E7%BD%AE%E5%8C%85%E7%AE%A1%E7%90%86%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/




"******************************From this part, all the setting belong to me***********************************

syntax on
set nu

"set term=ansi
"set term=screen

"set foldmethod=syntax "代码折叠方式"
set nocompatible      " be iMproved, required
filetype on           " required
filetype plugin indent on

syntax enable
syntax on
set nu
set t_Co=256
set background=dark


colorscheme molokai
""hi comment ctermfg=137
"set t_Co=screen-256color
""let g:monokai_term_italic = 1
"let g:monokai_gui_italic = 1

""if &filetype == 'cpp'

"set <C-F11>="[ 23;5~]"

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match Error /\s\+$/

set hlsearch
highlight Search ctermbg=yellow ctermfg=black
highlight IncSearch ctermbg=black ctermfg=yellow
highlight MatchParen cterm=underline ctermbg=NONE ctermfg=NONE


"高亮行与列
set cursorline

let mapleader = "\<Space>" 
" 在处理未保存或只读文件的时候，弹出确认
set confirm


set scrolloff=6      ""  上下可视行数 
set number

set mouse=""
set nobackup      "覆盖文件时不备份

set formatoptions=tcrqn " 自动格式化
set autoindent 			" 继承前一行的缩进方式，特别适用于多行注释
set smartindent 		" 为C程序提供自动缩进
set cindent 			" 使用C样式的缩进
set smarttab 			" 在行和段开始处使用制表符
set softtabstop=4 		" 统一缩进为4
"set nowrap 			" 不要换行
set fileformats=unix,dos 	" 自动识别UNIX格式和MS-DOS格式

au Filetype py,CSS set expandtab | set tabstop=4 | set shiftwidth=4  " Python, CSS, etc.
au FileType c,cpp,html,htmldjango,lua,javascript,nsis.scheme set expandtab | set tabstop=2 | set shiftwidth=2
au FileType make set noexpandtab | set tabstop=8 | set shiftwidth=8


map<leader>\ :call Comment()<CR>
function Comment() range
	let begin = a:firstline
	let end = a:lastline
	exec "normal I//"
endfunc

"autocmd FileType cpp,c inoremap  ( ()<ESC>i 
"autocmd FileType cpp,c inoremap  " ""<ESC>i 
"autocmd FileType cpp,c inoremap  ' ''<ESC>i 
"autocmd FileType cpp,c inoremap  [ []<ESC>i 
"autocmd FileType cpp,c inoremap  { {<CR>}<ESC>O 

inoremap  ( ()<ESC>i
inoremap  " ""<ESC>i
inoremap  ' ''<ESC>i
inoremap  [ []<ESC>i
inoremap  { {<CR>}<ESC>O 
"自动补全 { } 并换行

inoremap jk <ESC>
map  <leader>; :
"jk  进入普通模式   
inoremap <C-l>  <ESC>la
"ALT + l 自动跳出括号 

""nmap<C-j> :cn<CR>
""nmap<C-k> :cp<CR>
map <leader>a :call Formatcode()<cr>
func! Formatcode()
	exec "w"
	if &filetype == 'c' || &filetype == 'h' || &filetype == 'md' || &filetype == 'hpp'
		exec "!astyle --style=allman -pn %"
	elseif &filetype == 'cpp'
		exec "!astyle --style=kr -google %"
		#exec "!astyle --style=kr -pn %"
	elseif &filetype == 'java'
		exec "!astyle --style=java -pn %"
	elseif &filetype == 'go'
		exec "!gofmt -w  %"
	elseif &filetype == 'jsp'
		exec "!astyle --style=gnu --suffix=none -n %"
	elseif &filetype == 'xml'
		exec "!astyle --style=gnu --suffix=none -U%"
	elseif &filetype == 'py'
		exec "!yapf --style pep8 %"
	else
		exec "normal gg=G"
		return
	endif
endfunc

"c, c++ 按f11 编译
map<c-f11> :call Compilerungcc()<cr>
func! Compilerungcc()
	"自动保存
	exec "w"

	if &filetype == 'c'
		"编译本文件，未制定文件名，将编译到 a.out
		"exec !g++ % "
		set makeprg=gcc\ %
		exec "make"
		exec "cw"

	elseif &filetype == 'cpp'
		set makeprg=g++\ -std=c++11\ -Wall\ \ %
		"make文件, 而且使其支持 c++11
		exec "make"
		exec "cw"

	elseif &filetype == 'java'
		set makeprg=javac\ -g\ -d\ .\ %
		exec "make"
		exec "cw"

	elseif &filetype == 'scm'
		exec "!mit-scheme --quiet < %"

	elseif &filetype == 'html'
		exec "!google-chrome %"

	elseif &filetype == 'jsp'
		exec "!google-chrome %"

	elseif &filetype == 'python'
		exec "!time python3 %"
		"set makeprg=python\ %
		"exec make"
		"exec cw"

	elseif &filetype == 'go'
		set makeprg=go\ run\ %
		exec "make"
		exec "cw"

	elseif &filetype == 'tex'
		exec "LLPStartPreview"
		"exec "VimtexCompile"

	elseif &filetype == 'md'
		exec "MarkdownPreview"

	elseif &filetype == 'gen'
		exec "!./GenComplier %"
	endif
endfunc


"c c++ 按 F12 运行
map<C-F12> :call Operation()<CR>
func! Operation()
	if &filetype == 'java'
		exec "!java  %:r"
	elseif &filetype == 'cpp'
		exec "! ./a.out"
	elseif &filetype == 'c'
		exec "! ./a.out"
	endif
endfunc

"按f8 编译qt
map<c-f8> :call Compilecomplieqt()<cr>
func! Compilecomplieqt()
	"自动保存
	exec "w"
	set makeprg=make
	exec "make"
	exec "cw"
endfunc

"c c++ F6 memory leak调试
map<C-F6> :call RunValgrind()<CR>
func! RunValgrind()
	if &filetype == 'cpp'
		exec "w"
		exec "!g++ % -g -o a.out"
		exec "!valgrind --tool=memcheck --leak-check=full ./a.out"
	elseif &filetype == 'c'
		exec "w"
		exec "!gcc % -g -o a.out"
		exec "!valgrind --tool=memcheck --leak-check=full ./a.out"
	endif
endfunc

"按f7 运行qt
map<c-f7> :call Compilerunqt()<cr>
func! Compilerunqt()
	exec "! ./b.out"
endfunc

"c c++ F10 调试
map<C-F10> :call Rungdb()<CR>
func! Rungdb()
	if &filetype == 'cpp'
		exec "w"
		exec "!g++ % -g -o a.out"
		exec "!gdb ./a.out"
	elseif &filetype == 'c'
		exec "w"
		exec "!gcc % -g -o a.out"
		exec "!gdb ./a.out"
	elseif &filetype == 'py'
		exec "w"
		exec "!pdb %"
	endif
endfunc

map <C-F9> :call Title_copyright()<cr>
function Title_copyright()
	""call append(0,"/*\#!/usr/bin/env bash")
	call append(1,"/***********************************************************")
	call append(2," Author       : Joe_Yang")
	call append(3," Last modified: ".strftime("%Y-%m-%d %H:%M"))
	call append(4," Email        : 1514784049@qq.com || 1514784049yz@gmail.com")
	call append(5," Weblog       : https://blog.csdn.net/pursue_my_life/")
	call append(6," Filename     : ".expand("%:t"))
	call append(7," Description  : ")
	call append(8,"************************************************************/")
	echohl WarningMsg | echo "Successful in adding copyright." | echohl None
endf
function UpdateTitle()
	normal m'
	execute '/# Last modified/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
	normal ''
	normal mk
	execute '/# Filename/s@:.*$@\=":\t".expand("%:t")@'
	execute "noh"
	normal 'k
	echohl WarningMsg | echo "Successful in updating the copyright." | echohl None
endfunction
function TitleDet()
	let n=1
	while n < 10
		let line = getline(n)
		if line =~ '^\#\s*\S*Last\smodified\S*.*$'
			call UpdateTitle()
			return
		endif
		let n = n + 1
	endwhile
	call Title_copyright()
endfunction

map<leader>y :call RangeCopyToClipBoard()<CR>
function RangeCopyToClipBoard() range
	let begin = a:firstline
	let end = a:lastline
	exec "!sed -n '" .begin. "," .end. "p' % | xclip -selection c"
endfunc

"--------------This Is Plugin Setting----------------

"plugin 'luochen1990/rainbow'
"plugin 'vundlevim/vundle.vim'
"plugin 'suan/vim-instant-markdown'
"plugin 'scrooloose/syntastic'
"plugin 'chxuan/change-colorscheme'
"plugin 'git://github.com/scrooloose/nerdtree.git'
"plugin 'davidhalter/jedi'
"plugin 'vim-airline/vim-airline'
"plugin 'tenfyzhong/completeparameter.vim'


"Plugin luochen1990/rainbow
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

"""Plugin youcompleteme
set runtimepath+=/Users/yangzhao/.vim/pack/JoePlugin/start/Ycm


"deepin 里面不用添加这个
let g:ycm_server_python_interpreter='/usr/local/bin/python3'

""Python Semantic Completion
let g:ycm_python_binary_path = '/usr/local/bin/python3'

"let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf='/Users/yangzhao/.vim/.ycm_extra_conf.py'

""let g:syntastic_cpp_compiler = 'g++'
"let g:syntastic_cpp_compiler = 'clang'
""let g:syntastic_cpp_compiler_uptions = '-std=c++11 -stdlib=libc++'
let g:syntastic_cpp_compiler_uptions = '-std=c++11'


let g:ycm_cache_omnifunc=0  " 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_collect_identifiers_from_tags_files=1 " 开启 ycm 基于标签引擎
let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释与字符串中的内容也用于补全
let g:syntastic_ignore_files=[".*\.py$"]
let g:ycm_seed_identifiers_with_syntax = 1                  " 语法关键字补全
let g:ycm_complete_in_comments = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_complete_in_comments = 1                          " 在注释输入中也能补全
let g:ycm_complete_in_strings = 1                           " 在字符串输入中也能补全
let g:ycm_show_diagnostics_ui = 0                           " 禁用语法检查
let g:ycm_collect_identifiers_from_tag_files = 1
"回车即选中当前项
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>|     
" 跳转到定义处

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" |            " 回车即选中当前项
" 跳转到定义处
let g:ycm_min_num_of_chars_for_completion=1                 " 从第2个键入字符就开始罗列匹配项

let g:syntastic_always_populate_loc_list = 1
set completeopt=longest,menu   "让vim的补全菜单行为与一般ide一致(参考vimtip1228)
let  g:ycm_add_preview_to_completeopt = 1
autocmd insertleave * if pumvisible() == 0|pclose|endif    "离开插入模式后自动关闭预览窗口

let g:ycm_semantic_triggers =  {
			\   'c' : ['->', '.', 're!\w{3}'],
			\   'cpp': ['->', '.', 're!\w{3}' ],
			\   'objc' : ['->', '.', 're!\[[_a-za-z]+\w*\s', 're!^\s*[^\w\d]\w*\s',
			\             're!\[.*\]\s'],
			\   'ocaml' : ['.', '#'],
			\   'cpp,objcpp' : ['->', '.', '::'],
			\   'perl' : ['->'],
			\   'php' : ['->', '::'],
			\   'cs,java,javascript,typESCript,d,python,perl6,scala,vb,elixir,go' : ['.'],
			\   'ruby' : ['.', '::'],
			\   'lua' : ['.', ':'],
			\   'erlang' : [':'],
			\   'tex' : [':'],
			\ }

let g:ycm_semantic_triggers = { 'cpp': [ 're!\w{3}' ] }

"语法检查
let g:syntastic_ignore_files=[".*\.py$"]

"0 if you want to enable it later via :rainbowtoggle
let g:rainbow_conf = {
			\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
			\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
			\	'operators': '_,_',
			\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
			\	'separately': {
			\		'*': {},
			\		'tex': {
			\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
			\		},
			\		'lisp': {
			\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
			\		},
			\		'vim': {
			\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
			\		},
			\		'html': {
			\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
			\		},
			\		'css': 0,
			\	}
			\}

" 使用 nerdtree 插件查看工程文件。设置快捷键，速记：file list
nmap <C-e> :NERDTreeToggle <CR>
""窗口位置
let g:NERDTreeWinPos='left'
""窗口尺寸
let g:NERDTreeSize=32
" 显示隐藏文件
let NERDTreeShowHidden=1
" nerdtree 子窗口中不显示冗余帮助信息
let NERDTreeminimalui=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeautodeletebuffer=1
""窗口是否显示行号
let g:NERDTreeShowLineNumbers=1
let NERDChristmasTree=1

"不显示特定格式文件
let NERDTreeIgnore = ['\.pyc$', '.gch', '\.swp', '\.swo', '\.vscode', '__pycache__']

""打开vim时如果没有文件自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif

""当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"let g:autopairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
inoremap <buffer><silent> ) <c-r>=autopairsinsert(')')<cr>

"completeparameter
inoremap <silent><expr> ( complete_parameter#pre_complete("()")

imap nm <plug>(complete_parameter#goto_next_parameter)
imap mn <plug>(complete_parameter#goto_previous_parameter)

"跳转前后重载函数
imap <m-d> <Plug>(complete_parameter#overload_down)
imap <m-u> <Plug>(complete_parameter#overload_up)

"airline 
"打开tabline功能,方便查看Buffer和切换，这个功能比较不错"
"我还省去了minibufexpl插件，因为我习惯在1个Tab下用多个buffer"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" normal 模式下使用 bd 关闭当前 Buffer
nnoremap <silent>bd :bdelete<CR>

"设置切换Buffer快捷键"
nnoremap <C-N> :w<CR>:bn<CR>
nnoremap <C-P> :w<CR>:bp<CR>

"Leader-F
let g:Lf_ReverseOrder = 1
"leader + f 打开文件搜索
let g:Lf_ShortcutF = '<Leader>f'
"leader-p 打开函数列表
noremap <Leader>p :LeaderfFunction<cr>
noremap <Leader>l :LeaderfMru<cr>



"Plug 'w0rp/ale'
" 对应语言需要安装相应的检查工具
" https://github.com/w0rp/ale
let g:ale_linters_explicit = 1 "除g:ale_linters指定，其他不可用
let g:ale_linters = {
			\   'cpp': ['cppcheck','clang', 'gcc'],
			\   'c': ['cppcheck','clang'],
			\   'python': ['pylint'],
			\   'bash': ['shellcheck'],
			\   'go': ['golint'],
			\}
			"\   'cpp': ['cppcheck','clang','gcc'],

let g:ale_sign_column_always = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1
let g:include_path="/usr/local/llvm-9.0.0/include"
""let g:ale_set_quickfix = 1
""let g:ale_open_list = 1"打开quitfix对话框

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++11'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"<Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>

"vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
"which works in most cases, but can be a little slow on large files. Alternatively set
let g:cpp_experimental_simple_template_highlight = 1
"which is a faster implementation but has some corner cases where it doesn't work.
let g:cpp_experimental_template_highlight = 1

let g:cpp_concepts_highlight = 1
""let g:cpp_no_function_highlight = 1

"auto-pair

"IndentLine, 代码块虚线
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_enabled = 1

"elment-vim
let g:user_emmet_install_global = 0
autocmd FileType html,css,jsp EmmetInstall
let g:user_emmet_leader_key='<Leader>a'

hi Normal  ctermfg=252 ctermbg=none
"****************************************The Einding line of my setting*******************

"Plug 'lervag/vimtex'
let g:vimtex_view_method='zathura'
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0    
let g:livepreview_previewer = 'zathura'
let g:livepreview_engine = 'xelatex'

set conceallevel=1
let g:tex_conceal='abdmg'

"autocmd Filetype tex setl updatetime=1"自动刷新频率

let g:vimtex_compiler_latexmk = {
			\ 'options' : [
			\   '-xelatex',
			\   '-verbose',
			\   '-file-line-error',
			\   '-synctex=1',
			\    '--shell-escape',
			\   '-interaction=nonstopmode',
			\ ],
			\}


"Plugin 'SirVer/ultisnips'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger = '<TAB>'
let g:UltiSnipsJumpBackwardTrigger = '<s-TAB>'

"vim -markdown
let g:vim_markdown_folding_disabled = 1

"vim -markdown-preview
let g:mkdp_path_to_chrome = ""
" Path to the chrome or the command to open chrome (or other modern browsers).
" If set, g:mkdp_browserfunc would be ignored.

let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
" Callback Vim function to open browser, the only parameter is the url to open.

let g:mkdp_auto_start = 0
" Set to 1, Vim will open the preview window on entering the Markdown
" buffer.

let g:mkdp_auto_open = 0
" Set to 1, Vim will automatically open the preview window when you edit a
" Markdown file.

let g:mkdp_auto_close = 1
" Set to 1, Vim will automatically close the current preview window when
" switching from one Markdown buffer to another.

let g:mkdp_refresh_slow = 0
" Set to 1, Vim will just refresh Markdown when saving the buffer or
" leaving from insert mode. With default 0, it will automatically refresh
" Markdown as you edit or move the cursor.

let g:mkdp_command_for_global = 0
" Set to 1, the MarkdownPreview command can be used for all files,
" by default it can only be used in Markdown files.

let g:mkdp_open_to_the_world = 0
" Set to 1, the preview server will be available to others in your network.
" By default, the server only listens on localhost (127.0.0.1).
