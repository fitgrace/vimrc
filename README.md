# vimrc
MacVim 运行环境


插入模式下的上、下、左、右移动
control + h
control + j
control + j
control + l


插入模式下删除光标后字符
inoremap <C-d> <Delete>

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

" 取消搜索高亮
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

" CTRL-C are Copy  
vmap <C-c> y  

" CTRL-V are Paste  
inoremap <C-v> gP  

nmap <Leader>nt :NERDTree<cr>

<Leader>cc 注释当前行
<Leader>cs sexily注释，C语言注释效果如上，不过我没看出哪里性感了
<Leader>cA 行尾注释，切换成输入模式
<Leader>cu 撤销注释行

更高效的移动
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)

自动对齐
nmap <Leader>a= :Tabularize /=<cr>
vmap <Leader>a= :Tabularize /=<cr>
nmap <Leader>a: :Tabularize /:\zs<cr>
vmap <Leader>a: :Tabularize /:\zs<cr>

打开验证错误窗口
nnoremap <Leader>s :call ToggleErrors()<cr>

JS、HTML美化
nmap <leader>xfh :call HtmlBeautify()<cr>
nmap <leader>xfj :call JsBeautify()<cr>
