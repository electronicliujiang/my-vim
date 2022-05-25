syntax on
set nu
set hlsearch
set ruler
set cursorline
set encoding=utf-8

call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/taglist.vim'
Plug 'Shougo/neocomplcache'
Plug 'majutsushi/tagbar'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rhysd/vim-clang-format'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'powerline/fonts'
Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim'}
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
call plug#end()

nmap lh ^
nmap le $
"save and quit
nmap <leader>w :w<CR>
nmap <leader>aa : NERDTree<CR>
nmap <leader>wq :wq<CR>
nmap <leader>n :tabn<CR>


"taglist setting start
let Tlist_Show_One_File = 1 " 只显示当前文件的tags
let Tlist_GainFocus_On_ToggleOpen = 1 " 打开 Tlist 窗口时，光标跳到 Tlist 窗口

let Tlist_Exit_OnlyWindow = 1 " 如果 Tlist 窗口是最后一个窗口则退出 Vi
let Tlist_Use_Left_Window = 1 " 在左侧窗口中显示


let Tlist_File_Fold_Auto_Close = 1 " 自动折叠
let Tlist_Auto_Update = 1 " 自动更新


" <leader>tl 打开 Tlist 窗口，在左侧栏显示
map <leader>tl :TlistToggle<CR>
nmap <leader>tt :TagbarToggle<CR>
nmap <leader>lk :LookupFile<CR>
"taglist setting end 

set tags=tags
set tags+=./tags

augroup filetype
    autocmd! BufRead,BufNewFile BUILD set filetype=blade
augroup end

" 基于缩进进行代码折叠
set foldmethod=syntax
" 启动 Vim 时关闭折叠
set nofoldenable
"prefer color
"colorscheme elflord
"colorscheme ron
colorscheme torte
"colorscheme murphy
"colorscheme desert
set background=dark
let g:molokai_original = 1
let g:coc_disable_startup_warning = 1

let g:clang_format#auto_format_on_insert_leave=1

"status line setting start
" @airline
set t_Co=256      "在windows中用xshell连接打开vim可以显示色彩
let g:airline#extensions#tabline#enabled = 1   " 是否打开tabline
"这个是安装字体后 必须设置此项"
"let g:airline_powerline_fonts = 1
set laststatus=2  "永远显示状态栏
"let g:airline_theme='bubblegum' "选择主题
"let g:airline_theme='dark_minimal' "选择主题
let g:airline_theme='angr'
let g:airline#extensions#tabline#enabled=1    "Smarter tab line: 显示窗口tab和buffer
"let g:airline#extensions#tabline#left_sep = ' '  "separater
"let g:airline#extensions#tabline#left_alt_sep = '|'  "separater
"let g:airline#extensions#tabline#formatter = 'default'  "formater
let g:airline_left_sep = '▶'
"let g:airline_left_sep = '|'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
"status line setting ends

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"将键盘上的F4功能键映射为添加作者信息的快捷键
nmap <leader>nn ms:call TitleDet()<cr>'s
function AddTitle()
        call append(0,"/*")
        call append(1," * Author         : jovanyliu")
        call append(2," *")
        call append(3," * Last modified  : ".strftime("%Y-%m-%d %H:%M"))
        call append(4," *")
        call append(5," * Filename       : ".expand("%:t"))
        call append(6," */")
        echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endf

"更新最近修改时间和文件名
function UpdateTitle()
        normal m'
        execute '/ * Last modified  :/s@:.*$@\=strftime(": %Y-%m-%d %H:%M")@'
        normal "
        normal mk
        execute '/ * Filename       :/s@:.*$@\=": ".expand("%:t")@'
        execute "noh"
        normal 'k
        echohl WarningMsg | echo "Successful in updating the copy right."| echohl None
endfunction

"判断前10行代码里面，是否有Last modified这个单词，
"如果没有的话，代表没有添加过作者信息，需要新添加；
"如果有的话，那么只需要更新即可
function TitleDet()
        let n=1
        while n < 10
                let line = getline(n)
                if line =~'^\s\*\sLast\smodified\s\s:\s\S*.*$'
                        call UpdateTitle()
			echo 'updatetitle'
                        return
                endif
                let n = n + 1
        endwhile
        call AddTitle()
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""Vim-markdown Plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_math = 1     					"#LaTeX语法
let g:vim_markdown_auto_extension_ext ='txt' 				"#更改默认文件扩展名
let g:vim_markdown_no_default_key_mappings = 1     			"#禁用默认键映射，此时下面的指令不可用
let g:vim_markdown_folding_disabled = 1     				"#禁用折叠，取消则打开时默认白折叠所有标题

let g:vim_markdown_folding_style_pythonic = 1  				"#更改折叠样式-类似python-mode的样式折叠
let g:vim_markdown_override_foldtext = 0 				"#为了防止设置折叠文本

let g:vim_markdown_folding_level = 6   					"#设置折叠级别-标题折叠级别是1到6之间的数字
let g:vim_markdown_toc_autofit = 1   					"#启用TOC窗口自动调整
let g:vim_markdown_emphasis_multiline = 0  				"#限制单行文本
let g:vim_markdown_fenced_languages = ['csharp=cs']    	 	        "#代码块语言-默认值为['c++ = cpp','viml = vim','bash = sh','ini = dosini']
let g:vim_markdown_strikethrough = 1    				"#使用删除线


