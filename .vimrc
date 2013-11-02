
map <F9> :call SaveInputData()<CR>
func! SaveInputData()
	exec "tabnew"
	exec 'normal "+gP'
	exec "w! /tmp/input_data"
endfunc


colorscheme ron

set ai " 自动缩进
set si " 智能缩进
set expandtab " 输入的 tab(\t) 均不保持为 tab 而转换为空格
"set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,sjis,euc-kr,ucs-2le,latin1
"set fileencodings=cp936,gb18030,gbk,gb2312,utf-8,ucs-bom,latin-1
"字符编码
set fileencoding=gb2312
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] " 状态栏格式


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.py,*.java exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
	
	"如果文件类型为.sh文件 
	if &filetype == 'sh' 
		call setline(1, "\#!/bin/bash") 
        call append(line("."),"# -*- coding: GB2312 -*-")
		call append(line(".")+1, "") 
		call append(line(".")+2,"\###----------------------------------------------------------------------") 
		call append(line(".")+3, "\# File Name: ".expand("%")) 
		call append(line(".")+4, "\# Author: wangdejian") 
		call append(line(".")+5, "\# mail: wangdejian@sogou-inc.com") 
		call append(line(".")+6, "\# Brief : None") 
		call append(line(".")+7, "\# Created Time: ".strftime("%c")) 
		call append(line(".")+8, "\###---------------------------------------------------------------------") 
		call append(line(".")+9, "") 
	elseif &filetype == 'python'
        call setline(1,"#! /usr/bin/env python")
        call append(line("."),"# -*- coding: GB2312 -*-")
        call append(line(".")+1,"")
        call append(line(".")+2,"\###----------------------------------------------------------------------") 
		call append(line(".")+3, "\# File Name: ".expand("%")) 
		call append(line(".")+4, "\# Author: wangdejian") 
		call append(line(".")+5, "\# mail: wangdejian@sogou-inc.com") 
		call append(line(".")+6, "\# Brief : None") 
		call append(line(".")+7, "\# Created Time: ".strftime("%c")) 
		call append(line(".")+8, "\###---------------------------------------------------------------------") 
		call append(line(".")+9, "import sys") 
		call append(line(".")+10, "") 
	else
		call setline(1, "/*************************************************************************") 
		call append(line("."),   "   > File Name: ".expand("%")) 
		call append(line(".")+1, "   > Author: wangdejian") 
		call append(line(".")+2, "   > Mail: wangdejian@sogou-inc.com ") 
		call append(line(".")+3, "   > Brief : None") 
		call append(line(".")+4, "   > Created Time: ".strftime("%c")) 
		call append(line(".")+5, " ************************************************************************/") 
		call append(line(".")+6, "")
	endif
	
	if &filetype == 'cpp'
		call append(line(".")+7, "#include<iostream>")
		call append(line(".")+8, "using namespace std;")
		call append(line(".")+9, "")
	endif
	
	if &filetype == 'c'
		call append(line(".")+7, "#include<stdio.h>")
		call append(line(".")+8, "")
	endif
	
	if &filetype == 'java'
		call append(line(".")+7,"public class ".expand("%"))
		call append(line(".")+8,"")
	endif
	
	"新建文件后，自动定位到文件末尾
	autocmd BufNewFile * normal G
endfunc 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

" 映射全选+复制 ctrl+a
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y
"去空行  
nnoremap <F2> :g/^\s*$/d<CR> 
"比较文件  
nnoremap <C-F2> :vert diffsplit 
"新建标签  
map <M-F2> :tabnew<CR>  
"列出当前目录文件  
map <F3> :tabnew .<CR>  
"打开树状文件目录  
map <C-F3> \be  
"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!java %<"
	elseif &filetype == 'sh'
		:!./%
	elseif &filetype == 'python'
		exec "!python %"
	endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""实用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置当文件被改动时自动载入
set autoread
" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
"代码补全 
set completeopt=preview,menu 
"允许插件  
filetype plugin on
"共享剪贴板  
set clipboard+=unnamed 
"make 运行
:set makeprg=g++\ -Wall\ \ %
"自动保存
set autowrite
set ruler                   " 打开状态栏标尺
set cursorline              " 突出显示当前行
set magic                   " 设置魔术
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏
" 设置在状态行显示的信息
""set foldcolumn=0
""set foldmethod=indent 
""set foldlevel=3 
""set foldenable              " 开始折叠
" 不要使用vi的键盘模式，而是vim自己的
set nocompatible
" 语法高亮
set syntax=on
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 自动缩进
set autoindent
" c stype indent
set cindent
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 显示行号
set number
" 历史记录数
set history=1000
"禁止生成临时文件
set nobackup
set noswapfile
"搜索忽略大小写
set ignorecase
"搜索逐字符高亮
set hlsearch
set incsearch
"行内替换
set gdefault
"编码设置
" 总是显示状态行
set laststatus=2
" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2
" 侦测文件类型
filetype on
" 载入文件类型插件
filetype plugin on
" 为特定文件类型载入相关缩进文件
filetype indent on
" 保存全局变量
set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 字符间插入的像素行数目
set linespace=0
" 增强模式中的命令行自动完成操作
set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
"set mouse=v
set selection=exclusive
set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
" 为C程序提供自动缩进
set smartindent
" 高亮显示普通txt文件（需要txt.vim脚本）
au BufRead,BufNewFile *  setfiletype txt
"自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {<CR>}<ESC>O
":inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endfunction
filetype plugin indent on 
"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 自动生成注释头
function MakeDefCheck()
call setline(line("."), "#ifndef _" . expand("%") . "_")
call append(line("."), "#define _" . expand("%") . "_")
call append(line(".") + 1, "#endif")
endf
map <C-g> <Esc>:call MakeDefCheck()<CR>:retab<CR><Esc>:.,+1s/\./_/g<CR>

" 自动生成类及注释
function MakeClass()
call setline(line("."), "/**")
call append(line("."), " * @Class:\t" . expand("%:t:r"))
call append(line(".") + 1, " * @Brief:\t")
call append(line(".") + 2, " */")
call append(line(".") + 3, "class " . expand("%:t:r"))
call append(line(".") + 4, "{")
call append(line(".") + 5, " };")
endf
map <C-c> <Esc>:call MakeClass()<CR>:retab<CR>=6+5+o

" 自动生成函数注释
function MakeFunc()
call setline(line("."), "/**")
call append(line("."), " *      ")
call append(line(".") + 1, " *\t\t@param")
call append(line(".") + 2, " *\t\t@return\t\t0\t\t正常退出")
call append(line(".") + 3, " *\t\t\t\t\t-1\t\t失败退出")
call append(line(".") + 4, " *\t\t@note\t\t")
call append(line(".") + 5, " */")
endf
map <C-f> <Esc>:call MakeFunc()<CR>:retab<CR>=5+5+o

" ctags
set tags=/search/wangdejian/dev/add/Code/tags;
" 自动切换当前路径
" set autochdir

" taglist
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Auto_Open = 1             "设置打开vim时自动打开taglist

"映射F9为打开或者关闭taglist
map <silent> <F4> :TlistToggle<cr>


