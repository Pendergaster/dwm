
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

    " Make sure you use single quotes

    " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
    Plug 'junegunn/vim-easy-align'

    " Multiple Plug commands can be written in a single line using | separators
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

    " Plugin outside ~/.vim/plugged with post-update hook
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

    " Plug 'vim-syntastic/syntastic'
    Plug 'vim-airline/vim-airline'

    Plug 'vim-airline/vim-airline-themes'

    Plug 'kien/ctrlp.vim'
    " Plug 'Valloric/YouCompleteMe'

    Plug 'flazz/vim-colorschemes'
    Plug 'kovisoft/slimv'
    Plug 'Yggdroot/indentLine'

    " Plug 'xolox/vim-easytags'
    Plug 'craigemery/vim-autotag'
    Plug 'vim-scripts/TagHighlight'
    " Initialize plugin system
call plug#end()

" colorscheme apprentice
colorscheme dracula

runtime ftplugin/man.vim

set tabstop=4
set softtabstop=4
set shiftwidth=4
set list
set listchars=tab:»\ ,trail:·
let g:indentLine_char = '»'
set expandtab
autocmd FileType cpp,c,h,hpp setlocal shiftwidth=4 tabstop=4

set encoding=utf8
set number
" cursor definitions
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

"Tags
" set tags=./.tags;/
nmap <C-G> :CtrlPTag
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
source /home/pate/ctags/set_tags.vim
let g:autotagTagsFile="tags"
autocmd BufWritePre *.{c,cpp,h,hpp} :UpdateTypesFileOnly
hi Member guifg=white

" Tabs
map <leader>nt :tabnew % <CR>
nmap <C-j> :tabp <CR>
nmap <C-k> :tabn <CR>

nmap <C-n> :cnext <CR>
nmap <C-m> :cprev <CR>

" Completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Newtr
map <C-f> :Vex <CR>
let g:netrw_liststyle = 3
let g:netrw_banner = 0
" let g:netrw_browse_split = 2
" let g:netrw_winsize = 25

" Display all files
set wildmenu

let g:ctrlp_show_hidden = 1
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_list = 1
" let g:syntastic_check_on_wq = 0
" let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'


" :set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
" :set guioptions-=r  "remove right-hand scroll bar
" :set guioptions-=L  "remove left-hand scroll bar
" g:airline#extensions#tabline#buffer_nr_show

map <F7> mzgg=G`z

map <Space> <leader>
noremap <leader>b :w<CR> :make<CR>
set makeprg=./build.sh

" nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "<CR>" : ':w<CR> m9 | :make<CR> `9h'
nmap <F8> :TagbarToggle<CR>
:map  <Leader>er :%s/\<<C-r><C-w>\>//g<Left><Left>
:map  <Leader>ec :%s/<<C-r><C-w>>//gc<Left><Left><Left>
:map  <Leader>ff /<C-r><C-w><CR>
noremap <leader>fm mzgg=G`z
" :map  <Leader>er :%s/<<C-r><C-w>>//g<Left><Left>
:vmap <Leader>er :s///g<Left><Left>
map <F7> mzgg=G`z


inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

inoremap        { {}<Left>
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

inoremap        [  []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

inoremap /*          /**/<Left><Left>
inoremap /*<Space>   /*<Space><Space>*/<Left><Left><Left>
inoremap /*<CR>      /*<CR>*/<Esc>O
inoremap <Leader>/*  /*

let g:lisp_rainbow=1

set hlsearch

let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

nnoremap <leader>nu :set nu!<CR>
set nonu

nnoremap <leader>n :cnext<CR>
nnoremap <leader>m :cprev<cr>
nnoremap <leader>q :call QuickfixToggle()<cr>
nnoremap <leader>g :YcmCompleter GoTo  <cr>


hi def cCustomFunc  gui=bold guifg=#7ec0ee
hi def cCustomClass gui=reverse guifg=#00FF00
set hlsearch
hi Search guibg=LightBlue

" license to cpp and c files
autocmd BufNewFile *.{cpp,c,h,hpp,frag,vert}
\ 0r ~/mit_license.txt
augroup END

" licence and header guards to header files
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! Go#ifndef " . gatename
  execute "normal! o#define " . gatename 
  execute "normal! Go#endif /* " . gatename . " */"
  execute "normal! GO"
endfunction

" \ 0r ~/mit_license.txt
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()
autocmd BufWritePre *.{c,cpp,h,hpp,vert,frag} :%s/\s\+$//e

autocmd BufNewFile,BufRead *.{vert,frag} set syntax=c

set clipboard=unnamedplus

set cino+=t0

set mouse=a
