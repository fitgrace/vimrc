" File          : .vimrc
" Author        : FitGracw<fitingrace@gmail.com>
" Description   : fitgrace's personal vim config file
" Last Modified : 2015-11-02 20:27:49
" Website       : http://www.fitgrace.com/
" Since         : 2015-10-30
"


" 是否兼容vi，compatible为兼容，nocompatible为不完全兼容
" 如设置为compatible，则tab将不会变成空格
" 由于这个选项是最最基础的选项，会连带其它选项发生变动，所以它必需是第一个设定项
set nocompatible

" 检测文件类型
filetype off

" =======================================================
" Vundle
" https://github.com/VundleVim/Vundle.vim 
"
" 常用命令
" :PluginList        列举出列表中(.vimrc中)配置的所有插件
" :PluginInstall     安装列表中全部插件
" :PluginInstall!    更新列表中全部插件
" :PluginSearch foo  查找foo插件
" :PluginSearch! foo 刷新foo插件缓存
" :PluginClean       清除列表中没有的插件
" :PluginClean!      清除列表中没有的插件
" ========================================================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" 必不可少，在VIM的编辑窗口树状显示文件目录
Plugin 'scrooloose/nerdtree'

" NERD出品的快速给代码加注释插件，选中 ctrl+h 即可注释多种语言代码
Plugin 'scrooloose/nerdcommenter'

" 迄今为止最好的VIM自动补全插件了吧
" Vundle的这个写法，是直接取该插件在Github上的repo
"Plugin 'Valloric/YouCompleteMe'

" 解放生产力的神器，简单配置，就可以按照自己的风格快速输入大段代码
"Plugin 'UltiSnips'

" HTML、CSS 快速编码（原zencoding）
Plugin 'mattn/emmet-vim'

" 快速给词加环绕符号
Plugin 'tpope/vim-surround'

" 快速插入自定义的代码片段
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
" Plugin 'honza/vim-snippets'

" 快速跳转到配对的符号或标签
Plugin 'matchit.zip'

" 跳转到光标后任意位置，高效的移动光标，革命性的突破
Plugin 'easymotion/vim-easymotion'

" 括号高亮
Plugin 'kien/rainbow_parentheses.vim'

" JS 美化
Plugin 'maksimr/vim-jsbeautify'
Plugin 'einars/js-beautify'

" JS语法着色组件及代码缩进组件
Plugin 'jelera/vim-javascript-syntax'

" 代码格式化
" ,a=  按等号切分格式化
" ,a:  按逗号切分格式化
Plugin 'godlygeek/tabular'

" 语法检查，支持多语言
Plugin 'scrooloose/syntastic'

" Json 语法高亮
" Plugin 'elzr/vim-json'

" Nodejs 支持
" Plugin 'moll/vim-node'

" CSS3高亮
" Plugin 'hail2u/vim-css3-syntax'

" Markdown 语法高亮
Plugin 'plasticboy/vim-markdown'

" Color
" http://slinky.imukuppi.org/zenburnpage/
Plugin 'jnurmine/Zenburn'
Plugin 'tomasr/molokai'

" 放置在Bundle的设置后，防止意外BUG
call vundle#end()            " required（ 必须的设置 ）

""启动自动补全
filetype plugin indent on



" =======================
" 函数
" =======================
" 获取当前目录
func! GetPWD()
    return substitute(getcwd(), "", "", "g")
endf

" 返回当前时期
func! GetDateStamp()
    return strftime('%Y-%m-%d %H:%M:%S')
endf
   
" 跳过页头注释，到首行实际代码
func! GotoFirstEffectiveLine()
    let l:c = 0
    while l:c<line("$") && (
                \ getline(l:c) =~ '^\s*$'
                \ || synIDattr(synID(l:c, 1, 0), "name") =~ ".*Comment.*"
                \ || synIDattr(synID(l:c, 1, 0), "name") =~ ".*PreProc$"
                \ )
        let l:c = l:c+1
    endwhile
    exe "normal ".l:c."Gz\<CR>"
endf

" 保存文件时自动去除无效空白：行尾空白、文件最后空行
func! RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endf

" =======================
" 环境
" =======================
" 保留历史记录
set history=500

" 控制台响铃，不让vim发出讨厌的滴滴声
set title                " change the terminal's title
set novisualbell         " don't beep
set noerrorbells         " don't beep
set t_vb=

" 当正在编辑的文件被外部的其它程序所修改后自动在Vim加载
set autoread

" 行控制
set linebreak     " 使英文单词在换行时不被截断
set textwidth=500 " 每行的字符数，光标超过 500 列的时候折行
set linespace=6   " 行间距
set wrap          " 自动换行

" 标签页
set tabpagemax=9  " 可打开的标签数
set showtabline=2 " 是否显示标签栏，0: 不显示，1: 默认设置，在创建标签页后才显示，2: 总是显示

" 行号和标尺
set number  " 显示行号
set ruler   " 状态栏标尺
set rulerformat=%15(%c%V\ %p%%%) " 在状态行上显示光标所在位置的行号和列号

" 命令行于状态行
set ch=1  " 设定命令行的行数为 1
set statusline=\ [File]\ %F%m%r%h%y[%{&fileformat},%{&fileencoding}]\ %w\ \ [PWD]\ %r%{GetPWD()}%h\ %=\ [Line]%l/%L\ %=\[%P]  " 设置在状态行显示的信息
set laststatus=2 " 始终显示状态行，1为关闭，2为开启
set wildmenu " 在命令模式下使用 Tab 自动补全时，补全内容使用单行菜单形式显示

" 状态栏显示目前所执行的指令
set showcmd

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=5

" 搜索
set hlsearch  " 打开搜索高亮
set magic     " 设置魔术匹配控制，可以通过:h magic查看更详细的帮助信息
" set mat=2     " How many tenths of a second to blink when matching brackets
set matchtime=2 " 匹配括号高亮的时间（单位是十分之一秒）
set noincsearch " 搜索时一边输入一边显示效果
set ignorecase " 设置大小写敏感和聪明感知(小写全搜，大写完全匹配)
set incsearch  " 在查找过程中就高亮
set smartcase  " 有一个或以上大写字母时仍大小写敏感

" 制表符
set tabstop=4       " 设定 tab 长度为 4
set expandtab       " 按tab键插入空格
set smarttab        " 根据文件中其他地方的缩进空格个数来确定一个 tab 是多少个空格
set shiftwidth=4    " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4   " 按退格键一次删掉 4 个空格

" 缩进
set autoindent " 继承前一行的缩进方式，特别适用于多行注释
set smartindent " 比autoindent稍智能的自动缩进

" 插入模式下使用 <BS>、<Del> <C-W> <C-U>
set backspace=indent,eol,start

" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l

" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
"   "n" 普通模式  
"   "v" 可视模式  
"   "i" 插入模式  
"   "c" 命令行模式  
"   "h" 编辑帮助文件时,所有前面的模式  
"   "a" 所有前面的模式  
"   "r" hit-enter 和 more-prompt 提示时
if has('mouse')
    set mouse-=a
endif

"在执行宏命令时，不进行显示重绘；在宏命令执行完成后，一次性重绘，以便提高性能
set lazyredraw

" 自动切换当前目录为当前文件所在的目录
if has('netbeans_intg')
    set autochdir
endif

" =======================
" 文件备份和还原
" =======================
set nobackup   " 不备份文件（根据自己需要取舍）
set nowb
set noswapfile " 不生成swap文件，当buffer被丢弃的时候隐藏它

" 自动完成
set complete=.,w,b,k,t,i
set completeopt=longest,menu " 关掉智能补全时的预览窗口

" 代码折叠
set foldmethod=marker

" 在左侧显示折叠的层次 
set foldcolumn=1

" 高亮显示匹配的括号，插入括号时，短暂地跳转到匹配的对应括号
set showmatch

" 使用tab键来代替%进行匹配跳转
" nmap <tab> %
" vmap <tab> %

" 定义 <Leader> 为逗号
let mapleader = ","
let maplocalleader = ","


" =======================
" 多语言环境
"    默认为 UTF-8 编码
" =======================
if has("multi_byte")
    set encoding=utf-8
    " English messages only
    " language messages zh_CN.utf-8

    set fencs=utf-8,gbk,chinese,latin1
    set formatoptions+=mM
    set nobomb " 不使用 Unicode 签名

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

" 永久撤销，Vim7.3 新特性
if has('persistent_undo')
    set undofile

    " 设置撤销文件的存放的目录
    if has("unix")
        set undodir=/tmp/,~/tmp,~/Temp
    else
        set undodir=d:/temp/
    endif
    set undolevels=1000
    set undoreload=10000
endif

" Diff 模式的时候鼠标同步滚动 for Vim7.3
if has('cursorbind')
    set cursorbind
end

" =======================
" AutoCmd
" =======================
if has("autocmd")

    " 括号自动补全
    func! AutoClose()
        :inoremap " ""<ESC>i
        :inoremap ' ''<ESC>i
        :inoremap ( ()<ESC>i
        :inoremap { {}<ESC>i
        :inoremap [ []<ESC>i
        :inoremap ) <c-r>=ClosePair(')')<CR>
        :inoremap } <c-r>=ClosePair('}')<CR>
        :inoremap ] <c-r>=ClosePair(']')<CR>
    endf

    " 匹配配对的字符
    func! MatchingQuotes()
        inoremap " ""<left>
        inoremap ' ''<left>
        inoremap ( ()<left>
        inoremap { {}<left>
        inoremap [ []<left>
    endf

    func! ClosePair(char)
        if getline('.')[col('.') - 1] == a:char
            return "\<Right>"
        else
            return a:char
        endif
    endf

    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=80
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif
    augroup END

    " Auto close quotation marks for PHP, Javascript, etc, file
    au FileType html,css,sass,scss,less,php,javascript,shtml exe AutoClose()
    au FileType html,css,sass,scss,less,php,javascript,shtml exe MatchingQuotes()

    " Auto Check Syntax
    " au BufWritePost,FileWritePost *.js,*.php call CheckSyntax(1)

    " JavaScript 语法高亮
    au FileType html,javascript let g:javascript_enable_domhtmlcss = 1
    " au BufRead,BufNewFile *.js setf jquery

    " 给各语言文件添加 Dict
    if has('win32')
        let s:dict_dir = $VIM.'\vimfiles\dict\'
    else
        let s:dict_dir = $HOME."/.vim/dict/"
    endif
    let s:dict_dir = "setlocal dict+=".s:dict_dir

    au FileType php exec s:dict_dir."php_funclist.dict"
    au FileType css exec s:dict_dir."css.dict"
    au FileType javascript exec s:dict_dir."javascript.dict"

    " 格式化 JavaScript 文件
    "au FileType javascript map <f12> :call g:Jsbeautify()<cr>
    "au FileType javascript set omnifunc=javascriptcomplete#CompleteJS

    " CSS3 语法支持
    au BufRead,BufNewFile *.css set ft=css syntax=css3

    " 将指定文件的换行符转换成 UNIX 格式
    au FileType php,javascript,html,css,sass,scss,vim,vimwiki set ff=unix

    " 保存编辑状态
    au BufWinLeave * if expand('%') != '' && &buftype == '' | mkview | endif
    au BufRead     * if expand('%') != '' && &buftype == '' | silent loadview | syntax on | endif

    " 保存指定文件时自动去除无效空白
    " autocmd BufWritePre * call RemoveTrailingWhitespace()
    au BufWritePost,FileWritePost *.txt,*.html,*.css,*.sass,*.scss,*.less,*.php,*.js call RemoveTrailingWhitespace()

    " plasticboy/vim-markdown 插件配置
    let g:vim_markdown_folding_disabled=1

    " godlygeek/tabular
    " let g:tabular_loaded = 1

endif

" =======================
" 图形界面
" =======================
if has('gui_running')
    " 只显示菜单
    set guioptions=mcr
    " set guioptions-=m "删除菜单栏
    " set guioptions-=T "删除工具栏
    " set guioptions-=r "删除右边的滚动条
    " set guioptions-=R "如有垂直分割的窗口，删除右边的滚动条
    " set guioptions-=l "删除左边的滚动条
    " set guioptions-=L "如有垂直分割的窗口，删除左边的滚动条
    "set guioptions+=e

    " 在每个tab上显示编号
    set guitablabel=%M\ %t

    " 高亮光标所在的行
    set cursorline

    " 高亮光标所在的列
    set cursorcolumn

    if has("gui_macvim")
        set anti " Mac OS X 用平滑反锯齿的字体

        " MacVim 下的字体配置
        set guifont=Monaco:h14
        set guifontwide=Lantinghei\ SC\ Extralight:h14

        " 半透明和窗口大小
        set transparency=10 " 数值是百分比，10就是10%也就是0.1的透明度。
        set lines=50 columns=160

        " 使用 MacVim 原生的全屏幕功能
        let s:lines=&lines
        let s:columns=&columns

        func! FullScreenEnter()
            set lines=999 columns=999
            set fu
        endf

        func! FullScreenLeave()
            let &lines=s:lines
            let &columns=s:columns
            set nofu
        endf

        func! FullScreenToggle()
            if &fullscreen
                call FullScreenLeave()
            else
                call FullScreenEnter()
            endif
        endf

        " Mac 下，按 <Leader>ff 切换全屏
        nmap <f11> :call FullScreenToggle()<cr>
        nmap <Leader>ff  :call FullScreenToggle()<cr>

        " 设置默认shell
        " set shell=/bin/tcsh

        " Set input method off
        set imdisable

        " Set QuickTemplatePath
        let g:QuickTemplatePath = $HOME.'/.vim/templates/'

        " 如果为空文件，则自动设置当前目录为桌面
        lcd ~/Desktop/
    endif

endif

" =======================
" 快捷键
" =======================
" 插入模式下的上、下、左、右移动
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-d> <Delete>

" 插入模式按 F4 插入当前时间
inoremap <f4> <C-r>=GetDateStamp()<cr>

" Tab操作
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt
nmap <leader>0  :tablast<cr>
nmap <leader>tp :tabprevious<cr>
nmap <leader>tn :tabnext<cr>
nmap <leader>tc :tabclose<cr>
nmap <leader>tt :tabnew<cr>


" 新建 XHTML 、PHP、Javascript 文件的快捷键
nmap <Leader>html :NewQuickTemplateTab html<cr>
nmap <Leader>php  :NewQuickTemplateTab php<cr>
nmap <Leader>css  :NewQuickTemplateTab css<cr>
nmap <Leader>js   :NewQuickTemplateTab javascript<cr>
nmap <Leader>md   :NewQuickTemplateTab markdown<cr>
nmap <Leader>blog :NewQuickTemplateTab blog<cr>

"取消搜索高亮
nmap <leader>n :noh<cr>

" 直接查看第一行生效的代码
nmap <Leader>gff :call GotoFirstEffectiveLine()<cr>

"快速保存
nmap <leader>w :w!<cr>

"快速退出
nmap <leader>q :q!<cr>

" 普通模式、可视模式和选择模式下使用 <Tab> 和 <Shift-Tab> 键来缩进文本
nmap <Tab> v>
nmap <S-Tab> v<
vmap <Tab> >gv
vmap <S-Tab> <gv

" 插件快捷键
nmap <Leader>mr :MRU<cr>


" =============================
" Nerd Tree
" =============================
nmap <Leader>nt :NERDTree<cr>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end
" s/v 分屏打开文件
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'


" =============================
" scrooloose/nerdcommenter
" 插件设置
" =============================
let NERDSpaceDelims=1     " 让注释符与语句之间留一个空格
let NERDCompactSexyComs=1 " 多行注释时样子更好看


" =======================================
" 高亮括号
" 依赖: kien/rainbow_parentheses.vim
" 不加入这行, 防止黑色括号出现, 很难识别
" \ ['black',       'SeaGreen3'],
" ======================================
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" ======================================
" 更高效的移动 [,, + w/fx]
" 依赖: easymotion/vim-easymotion
" ======================================
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)


" ======================================
" 自动对齐
" 依赖: godlygeek/tabular
" ======================================
nmap <Leader>a= :Tabularize /=<cr>
vmap <Leader>a= :Tabularize /=<cr>
nmap <Leader>a: :Tabularize /:\zs<cr>
vmap <Leader>a: :Tabularize /:\zs<cr>


" ======================================
" 多语言语法检查
" Bundle 'scrooloose/syntastic
" ======================================
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_highlighting=1

" 最轻量
" let g:syntastic_python_checkers=['pyflakes'] " 使用pyflakes

" 中等
" error code: http://pep8.readthedocs.org/en/latest/intro.html#error-codes
let g:syntastic_python_checkers=['pyflakes', 'pep8'] " 使用pyflakes,速度比pylint快
let g:syntastic_python_pep8_args='--ignore=E501,E225,E124,E712'

" 重量级, 但是足够强大, 定制完成后相当个性化
" pylint codes: http://pylint-messages.wikidot.com/all-codes
" let g:syntastic_python_checkers=['pyflakes', 'pylint'] " 使用pyflakes,速度比pylint快
" let g:syntastic_python_checkers=['pylint'] " 使用pyflakes,速度比pylint快
" let g:syntastic_python_pylint_args='--disable=C0111,R0903,C0301'


let g:syntastic_javascript_checkers = ['jsl', 'jshint']
let g:syntastic_html_checkers=['tidy', 'jshint']
" 修改高亮的背景色, 适应主题
highlight SyntasticErrorSign guifg=white guibg=black

" to see error location list
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5

function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location
        panel
        Errors
    endif
endfunction
nnoremap <Leader>s :call ToggleErrors()<cr>
" nnoremap <Leader>sn :lnext<cr>
" nnoremap <Leader>sp :lprevious<cr>


" ======================================
" html，json，js，css 美化
" maksimr/vim-jsbeautify
" ======================================
" autocmd FileType javascript noremap <Leader>js :call JsBeautify()<cr>
" autocmd FileType html noremap <Leader>js :call HtmlBeautify()<cr>
" autocmd FileType css,less noremap <Leader>js :call CSSBeautify()<cr>
nmap <leader>xfh :call HtmlBeautify()<cr>
nmap <leader>xfj :call JsBeautify()<cr>
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>


" ======================================
" 快速插入自定义的代码片段
" SirVer/ultisnips
" ======================================
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" 定义存放代码片段的文件夹，使用自定义和默认的，将会的到全局，有冲突的会提示
let g:UltiSnipsSnippetDirectories  = ['UltiSnips']
let g:UltiSnipsSnippetsDir = '~/.vim/snippets'
" 定义存放代码片段的文件夹 .vim/UltiSnips下，使用自定义和默认的，将会的到全局，有冲突的会提示


" =======================
" Color Scheme
" =======================
if has('syntax')
    if has('gui_running')
        " 开启256色
        set t_Co=256
        let &t_AB="\e[48;5;%dm"
        let &t_AF="\e[38;5;%dm"

        " 编辑器配色
        colorscheme zenburn

        " 默认编辑器配色
        au BufNewFile,BufRead,BufEnter,WinEnter * colo zenburn

        " 各不同类型的文件配色不同
	    au BufNewFile,BufRead,BufEnter,WinEnter *.js,*.php colo zenburn
		" au BufNewFile,BufRead,BufEnter,WinEnter *.js,*.php colo molokai
    else
        colorscheme slate
    endif

    " 保证语法高亮
    syntax on
endif
