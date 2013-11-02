
map <F9> :call SaveInputData()<CR>
func! SaveInputData()
	exec "tabnew"
	exec 'normal "+gP'
	exec "w! /tmp/input_data"
endfunc


colorscheme ron

set ai " �Զ�����
set si " ��������
set expandtab " ����� tab(\t) ��������Ϊ tab ��ת��Ϊ�ո�
"set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,sjis,euc-kr,ucs-2le,latin1
"set fileencodings=cp936,gb18030,gbk,gb2312,utf-8,ucs-bom,latin-1
"�ַ�����
set fileencoding=gb2312
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] " ״̬����ʽ


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"�½�.c,.h,.sh,.java�ļ����Զ������ļ�ͷ 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.py,*.java exec ":call SetTitle()" 
""���庯��SetTitle���Զ������ļ�ͷ 
func SetTitle() 
	
	"����ļ�����Ϊ.sh�ļ� 
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
	
	"�½��ļ����Զ���λ���ļ�ĩβ
	autocmd BufNewFile * normal G
endfunc 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"��������
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

" ӳ��ȫѡ+���� ctrl+a
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G
" ѡ��״̬�� Ctrl+c ����
vmap <C-c> "+y
"ȥ����  
nnoremap <F2> :g/^\s*$/d<CR> 
"�Ƚ��ļ�  
nnoremap <C-F2> :vert diffsplit 
"�½���ǩ  
map <M-F2> :tabnew<CR>  
"�г���ǰĿ¼�ļ�  
map <F3> :tabnew .<CR>  
"����״�ļ�Ŀ¼  
map <C-F3> \be  
"C��C++ ��F5��������
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
"C,C++�ĵ���
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""ʵ������
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ���õ��ļ����Ķ�ʱ�Զ�����
set autoread
" quickfixģʽ
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
"���벹ȫ 
set completeopt=preview,menu 
"������  
filetype plugin on
"���������  
set clipboard+=unnamed 
"make ����
:set makeprg=g++\ -Wall\ \ %
"�Զ�����
set autowrite
set ruler                   " ��״̬�����
set cursorline              " ͻ����ʾ��ǰ��
set magic                   " ����ħ��
set guioptions-=T           " ���ع�����
set guioptions-=m           " ���ز˵���
" ������״̬����ʾ����Ϣ
""set foldcolumn=0
""set foldmethod=indent 
""set foldlevel=3 
""set foldenable              " ��ʼ�۵�
" ��Ҫʹ��vi�ļ���ģʽ������vim�Լ���
set nocompatible
" �﷨����
set syntax=on
" ȥ������������ʾ����
set noeb
" �ڴ���δ�����ֻ���ļ���ʱ�򣬵���ȷ��
set confirm
" �Զ�����
set autoindent
" c stype indent
set cindent
" Tab���Ŀ��
set tabstop=4
" ͳһ����Ϊ4
set softtabstop=4
set shiftwidth=4
" ��ʾ�к�
set number
" ��ʷ��¼��
set history=1000
"��ֹ������ʱ�ļ�
set nobackup
set noswapfile
"�������Դ�Сд
set ignorecase
"�������ַ�����
set hlsearch
set incsearch
"�����滻
set gdefault
"��������
" ������ʾ״̬��
set laststatus=2
" �����У���״̬���£��ĸ߶ȣ�Ĭ��Ϊ1��������2
set cmdheight=2
" ����ļ�����
filetype on
" �����ļ����Ͳ��
filetype plugin on
" Ϊ�ض��ļ�����������������ļ�
filetype indent on
" ����ȫ�ֱ���
set viminfo+=!
" �������·��ŵĵ��ʲ�Ҫ�����зָ�
set iskeyword+=_,$,@,%,#,-
" �ַ���������������Ŀ
set linespace=0
" ��ǿģʽ�е��������Զ���ɲ���
set wildmenu
" ʹ�ظ����backspace����������indent, eol, start��
set backspace=2
" ����backspace�͹�����Խ�б߽�
set whichwrap+=<,>,h,l
" ������buffer���κεط�ʹ����꣨����office���ڹ�����˫����궨λ��
"set mouse=v
set selection=exclusive
set selectmode=mouse,key
" ͨ��ʹ��: commands������������ļ�����һ�б��ı��
set report=0
" �ڱ��ָ�Ĵ��ڼ���ʾ�հף������Ķ�
set fillchars=vert:\ ,stl:\ ,stlnc:\
" ������ʾƥ�������
set showmatch
" ƥ�����Ÿ�����ʱ�䣨��λ��ʮ��֮һ�룩
set matchtime=1
" ����ƶ���buffer�Ķ����͵ײ�ʱ����3�о���
set scrolloff=3
" ΪC�����ṩ�Զ�����
set smartindent
" ������ʾ��ͨtxt�ļ�����Ҫtxt.vim�ű���
au BufRead,BufNewFile *  setfiletype txt
"�Զ���ȫ
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
"���ļ����ͼ��, �������ſ��������ܲ�ȫ
set completeopt=longest,menu
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" �Զ�����ע��ͷ
function MakeDefCheck()
call setline(line("."), "#ifndef _" . expand("%") . "_")
call append(line("."), "#define _" . expand("%") . "_")
call append(line(".") + 1, "#endif")
endf
map <C-g> <Esc>:call MakeDefCheck()<CR>:retab<CR><Esc>:.,+1s/\./_/g<CR>

" �Զ������༰ע��
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

" �Զ����ɺ���ע��
function MakeFunc()
call setline(line("."), "/**")
call append(line("."), " *      ")
call append(line(".") + 1, " *\t\t@param")
call append(line(".") + 2, " *\t\t@return\t\t0\t\t�����˳�")
call append(line(".") + 3, " *\t\t\t\t\t-1\t\tʧ���˳�")
call append(line(".") + 4, " *\t\t@note\t\t")
call append(line(".") + 5, " */")
endf
map <C-f> <Esc>:call MakeFunc()<CR>:retab<CR>=5+5+o

" ctags
set tags=/search/wangdejian/dev/add/Code/tags;
" �Զ��л���ǰ·��
" set autochdir

" taglist
let Tlist_Show_One_File = 1            "��ͬʱ��ʾ����ļ���tag��ֻ��ʾ��ǰ�ļ���
let Tlist_Exit_OnlyWindow = 1          "���taglist���������һ�����ڣ����˳�vim
"let Tlist_Auto_Open = 1             "���ô�vimʱ�Զ���taglist

"ӳ��F9Ϊ�򿪻��߹ر�taglist
map <silent> <F4> :TlistToggle<cr>


