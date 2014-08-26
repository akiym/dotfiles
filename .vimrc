set nocompatible

set expandtab
set shiftround
set autoindent
set backspace=indent,eol,start
set hidden
set history=50
set ignorecase
set incsearch
set laststatus=2
set nobackup
set ruler
set shiftwidth=4
set showcmd
set showmatch
set smartcase
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set tabstop=4
set wrapscan
set updatetime=500
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,utf-8,cp932
set ambw=double

set directory=~/.vim/tmp

set nocompatible

nnoremap <Space>t t
nnoremap <Space>T T
nnoremap t <Nop>
nnoremap <silent> tc :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> tk :<C-u>tabclose<CR>
nnoremap <silent> tn :<C-u>tabnext<CR>
nnoremap <silent> tp :<C-u>tabprevious<CR>
nnoremap <silent> bn :<C-u>bnext<CR>
nnoremap <silent> bp :<C-u>bprevious<CR>
nnoremap <silent> bd :<C-u>bdelete<CR>
for n in range(1,9) | exe "nnoremap <silent> g".n." :buffer ".n."<cr>" | endfor

nmap sj <C-W>j<C-w>
nmap sk <C-W>k<C-w>
nmap sh <C-w>h<C-w>
nmap sl <C-w>l<C-w>

set t_Co=256

highlight SpecialKey cterm=underline ctermfg=cyan
highlight ZenkakuSpace cterm=underline ctermfg=white
match ZenkakuSpace /　/
set list
set listchars=tab:>\ ,extends:»,trail:\ ,nbsp:%

set clipboard=unnamed
set fileformats=unix,dos,mac

inoremap <BS> <Del>

vmap s !sort<CR>

autocmd FileType * setlocal formatoptions-=ro

hi MatchParen term=standout ctermbg=LightGrey ctermfg=Black guibg=LightGrey guifg=Black

augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'))
    function! s:auto_mkdir(dir)
    if !isdirectory(a:dir)
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
    endfunction
augroup END

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/vimproc'
NeoBundle 'thinca/vim-quickrun'

NeoBundle 'vim-scripts/vim-auto-save'

filetype plugin indent on
filetype indent on
syntax on

let g:auto_save = 1

set completeopt=menuone

let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache_force_omni_patterns.c =
            \ '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.objc =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.objcpp =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

imap <expr><TAB> neocomplcache#plugin#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<TAB>"
smap <TAB> <Plug>(neocomplcache_snippets_expand)

inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
