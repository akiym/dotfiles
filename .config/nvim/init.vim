set backspace=indent,eol,start
set history=100
set directory=~/.vim/tmp
set updatetime=500
set nobackup
set hidden
set completeopt=menu

set ignorecase
set smartcase
set incsearch
set wrapscan

set autoindent
set expandtab
set shiftround
set shiftwidth=4
set tabstop=4

set number
set ruler
set showcmd
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"set ambw=double
set ambw=single
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,utf-8,cp932
set fileformats=unix,dos,mac

"set clipboard+=unnamed
set clipboard=unnamedplus
set showmatch

set synmaxcol=300

"set spell
"set spellfile=~/.vim/spell/my.utf-8.add

"set completefunc=autoprogramming#complete

syntax on

if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

let g:python2_host_prog = expand('~/.anyenv/envs/pyenv/versions/neovim2/bin/python')
let g:python3_host_prog = expand('~/.anyenv/envs/pyenv/versions/neovim3/bin/python')

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/tabpagebuffer.vim'
NeoBundle 'Shougo/neomru.vim'
"NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'Lokaltog/vim-easymotion'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'tsukkee/unite-tag'
NeoBundleLazy 'lambdalisue/unite-grep-vcs', {
    \ 'autoload': {
    \    'unite_sources': ['grep/git', 'grep/hg'],
    \}}

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

" perl
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'c9s/perlomni.vim'
NeoBundle 'motemen/xslate-vim'
"NeoBundle 'vim-perl/vim-perl6'

" python
"NeoBundle 'tmhedberg/SimpylFold' " TODO docstringのみfold
"NeoBundle 'davidhalter/jedi-vim'

" go
"NeoBundleLazy 'fatih/vim-go'

" html/css
"NeoBundle 'alvan/vim-closetag'
NeoBundle 'AtsushiM/search-parent.vim'
NeoBundle 'matchit.zip'

"NeoBundle 'leafgarland/typescript-vim'

NeoBundle 'tyru/caw.vim'
NeoBundle 'bronson/vim-trailing-whitespace'     " :FixWhitespace
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'haya14busa/vim-auto-programming'
NeoBundle 'tyru/current-func-info.vim'
NeoBundle 'vim-scripts/AnsiEsc.vim'

NeoBundle 'gioele/vim-autoswap'
NeoBundle 'djoshea/vim-autoread'

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'kristijanhusak/vim-hybrid-material'

NeoBundle 'editorconfig/editorconfig-vim'
"NeoBundle 'chr4/nginx.vim'

" pすると改行が含まれるのでこれを入れる
" https://github.com/neovim/neovim/issues/1822
" 日本語がこわれる innocent
NeoBundle 'bfredl/nvim-miniyank'
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)

call neobundle#end()

filetype indent on
filetype plugin on
NeoBundleCheck

if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif

let g:autoswap_detect_tmux = 0

" === color ===============================================================
set t_Co=256
set background=dark
colorscheme hybrid

set list
set listchars=tab:>\ ,extends:»,trail:\ ,nbsp:%

highlight default TabSpace cterm=underline ctermfg=cyan
match TabSpace /\t/

let g:special_key_state = 1
function ToggleTab()
    if g:special_key_state
        highlight TabSpace none
        let g:special_key_state = 0
    else
        highlight TabSpace cterm=underline ctermfg=cyan
        let g:special_key_state = 1
    endif
endfunction
command ToggleTab :call ToggleTab()

" === tabs ================================================================
nnoremap <silent> tc :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> tn :<C-u>tabnext<CR>
nnoremap <silent> tp :<C-u>tabprevious<CR>
nnoremap <silent> th :<C-u>-tabmove<CR>
nnoremap <silent> tl :<C-u>+tabmove<CR>
nnoremap <silent> bn :<C-u>bnext<CR>
nnoremap <silent> bp :<C-u>bprevious<CR>
nnoremap <silent> bd :<C-u>bdelete<CR>
for n in range(1,9) | exe "nnoremap <silent> g".n." :buffer ".n."<cr>" | endfor

nmap sj <C-W>j
nmap sk <C-W>k
nmap sh <C-w>h
nmap sl <C-w>l
nmap ss <C-w>q

let mapleader = "\<Space>"

let g:lightline = {
      \ 'active': {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'filename', 'modified' ] ],
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'fugitive' ],
      \            [ 'fileformat', 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component_function': {
      \   'readonly': 'LightlineReadonly',
      \   'modified': 'LightlineModified',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename'
      \ },
      \ 'component_expand': {
      \   'tabs': 'LightlineTabs',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightlineModified()
  if &filetype == 'help'
    return ''
  elseif &modified
    return '+'
  elseif &modifiable
    return ''
  else
    return '-'
  endif
endfunction

function! LightlineReadonly()
  if &filetype == 'help'
    return ''
  elseif &readonly
    return 'x'
  else
    return ''
  endif
endfunction

function! LightlineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != expand('%') ? expand('%') : '[No Name]')
endfunction

function! LightlineTabs()
  let [x, y, z] = [[], [], []]
  let nr = tabpagenr()
  let cnt = tabpagenr('$')
  for i in range(1, cnt)
    call add(i < nr ? x : i == nr ? y : z, '%'. i . 'T%{lightline#onetab(' . i . ',' . (i == nr) . ')}' . (i == cnt ? '%T' : ''))
  endfor
  let abbr = '...'
  let n = min([max([winwidth(0) / 18, 2]), 16])
  if len(x) > n && len(z) > n
    let x = extend(add(x[:n/2-1], abbr), x[-(n+1)/2:])
    let z = extend(add(z[:(n+1)/2-1], abbr), z[-n/2:])
  elseif len(x) + len(z) > 2 * n
    if len(x) > n
      let x = extend(add(x[:(2*n-len(z))/2-1], abbr), x[-(2*n-len(z)+1)/2:])
    elseif len(z) > n
      let z = extend(add(z[:(2*n-len(x)+1)/2-1], abbr), z[-(2*n-len(x))/2:])
    endif
  endif
  return [x, y, z]
endfunction

let g:lightline.tab = {
      \ 'active': [ 'filename', 'modified' ],
      \ 'inactive': [ 'filename', 'modified' ]
      \ }

let g:lightline.tab_component_function = {
      \ 'filename': 'LightlineTabFilename',
      \ 'modified': 'lightline#tab#modified',
      \ 'readonly': 'lightline#tab#readonly',
      \ 'tabnum': 'lightline#tab#tabnum' }

function! LightlineTabFilename(n) abort
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let filename = expand('#'.buflist[winnr - 1].':p:.')
  let filename = substitute(filename, '\.\%(pm\)$', '', '') " .t は省略したくないので .pm だけ消す
  let filename = substitute(filename, '^.*\%(lib\|local/lib/perl5\|t\)/', '', '')
  " プロジェクト固有のディレクトリを消す
  let filename = substitute(filename, '^.*\%(Giga\|Tokyo/Dome\)/', '', '')
  let filename = substitute(filename, '^.*\%(App/Api/V1\)/', 'A/', '')
  let _ = pathshorten(filename)
  return _ !=# '' ? _ : '[No Name]'
endfunction

" === unite ===============================================================
let g:unite_enable_start_insert = 1
let g:unite_enable_smart_case = 1
let g:unite_source_grep_command = 'pt'
let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_tag_max_fname_length = 50
let s:file_rec_ignore_pattern = '\%(^\|/\)\%(local\|node_modules\|cover_db\|blib\|tmp\|vendor\)/'
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file', 'ignore_pattern', s:file_rec_ignore_pattern)
call unite#custom#source('file_rec', 'ignore_pattern', s:file_rec_ignore_pattern)
call unite#custom#source('file_rec/async', 'ignore_pattern', s:file_rec_ignore_pattern)
call unite#custom#source('grep', 'ignore_pattern', s:file_rec_ignore_pattern)

call unite#custom#default_action('file', 'tabopen')
call unite#custom#default_action('file_rec/async', 'tabopen')

nmap bg :Unite -buffer-name=files tab file_rec/async file/new<CR>
nmap bo :Unite outline<CR>
nmap bf :Unite grep:. -buffer-name=search-buffer -default-action=tabopen<CR>
nmap bc :<C-u>UniteWithCursorWord -buffer-name=files tab file_rec/async<CR>
nmap bt :Unite -buffer-name=tags tag<CR>
nmap bv :Unite -buffer-name=tags tag -default-action=tabopen<CR>
nmap br :UniteWithCursorWord -default-action=right tag<CR>
nmap bb :<C-u>UniteWithCursorWord grep:. -buffer-name=search-buffer -default-action=tabopen<CR>

autocmd BufEnter *
\   if empty(&buftype)
\|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord tag<CR>
\|      nnoremap <buffer> <C-\> :<C-u>UniteWithCursorWord -default-action=tabopen tag<CR>
\|      nnoremap <buffer> <C-j> :<C-u>Unite jump<CR>
\|  endif

" === deoplete =======================================================
let g:deoplete#enable_at_startup = 1
"let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
call deoplete#custom#option({'smart_case': v:true})

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" === neosnippet =======================================================
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/snippets'

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB> neocomplcache#plugin#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<TAB>"
"smap <TAB> <Plug>(neocomplcache_snippets_expand)

" === neocomplcache =======================================================
" let g:neocomplcache_enable_at_startup = 1
" let g:neocomplcache_enable_smart_case = 1
" let g:neocomplcache_enable_camel_case_completion = 1
" let g:neocomplcache_enable_underbar_completion = 1
" let g:neocomplcache_min_syntax_length = 2
" let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"
" let g:neocomplcache_enable_fuzzy_completion=1
" let g:neocomplache_fuzzy_completion_start_length=2
"
" let g:neocomplcache_dictionary_filetype_lists = {
"     \ 'default' : '',
"     \ 'perl' : '~/.vim/completions/perl',
"     \ 'xs' : '~/.vim/completions/xs',
"     \ }
" let g:neocomplcache_ctags_arguments_list = {
"     \ 'perl' : '-R -h ".pm"'
"     \ }
" let g:neocomplcache_include_patterns = {
"   \ 'perl' : '^\s*use',
"   \ }
"
" if !exists('g:neocomplcache_keyword_patterns')
"     let g:neocomplcache_keyword_patterns = {}
" endif
" let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" autocmd FileType perl6 let g:neocomplcache_keyword_patterns['default'] = '\h[\w-]*'
"
" " if !exists('g:neocomplcache_force_omni_patterns')
" "     let g:neocomplcache_force_omni_patterns = {}
" " endif
" " let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" " " let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*'
"
" "if !exists('g:neocomplcache_delimiter_patterns')
" "    let g:neocomplcache_delimiter_patterns = {}
" "endif
" "let g:neocomplcache_delimiter_patterns.perl = ['::']
"
" "if !exists('g:neocomplcache_filename_include_exprs')
" "    let g:neocomplcache_filename_include_exprs = {}
" "endif
" "let g:neocomplcache_filename_include_exprs.perl = 'fnamemofidy(substitute(v:fname, "/", "::", "g"), ":r")'
"
" inoremap <expr><C-g> neocomplcache#undo_completion()
" inoremap <expr><C-l> neocomplcache#complete_common_string()
"
" inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
" inoremap <expr><BS>  neocomplcache#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y> neocomplcache#close_popup()
" inoremap <expr><C-e> neocomplcache#cancel_popup()
"
" autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python        setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags

" === tagbar ==============================================================
let g:tagbar_iconchars = ['>', 'v']
let g:tagbar_type_perl = {
    \ 'ctagstype'   : 'Perl',
    \ 'kinds' : [
        \ 'p:packages:1:0',
        \ 'u:uses:1:0',
        \ 'r:requires:1:0',
        \ 'e:extends',
        \ 'w:roles',
        \ 'o:ours:1:0',
        \ 'c:constants:1:0',
        \ 'f:formats:1:0',
        \ 'a:attributes',
        \ 's:subroutines',
        \ 'x:around:1:0',
        \ 'l:aliases',
        \ 'd:pod:1:0',
    \ ],
\ }
nmap <F8> :TagbarToggle<CR>

" === quickrun ============================================================

augroup quickrun
    autocmd!
    autocmd FileType quickrun AnsiEsc
augroup END

let g:quickrun_config = {'*': {'split': ''}}
let g:quickrun_config._ = {
    \ 'runner': 'vimproc',
    \ 'runner/vimproc/updatetime': 10,
    \ 'outputter/buffer/close_on_empty': 1,
    \ }
let g:quickrun_config.perl = {'command' : 'perl', 'cmdopt': '-Ilib -It/lib -Ilocal/lib/perl5'}
let g:quickrun_config['prove/carton'] = {
    \ 'exec'    : 'ce %c %o -I. -Ilib -It/lib -v --rc=/Users/akiym/.vim/proverc --norc %s',
    \ 'command' : 'prove',
    \ }
let g:quickrun_config['prove/carton/failonly'] = {
    \ 'exec'    : 'ce %c %o -I. -Ilib -It/lib --failures --rc=/Users/akiym/.vim/proverc --norc %s',
    \ 'command' : 'prove',
    \ }

" === easymotion ==========================================================
let g:EasyMotion_do_mapping = 0

nmap s <Plug>(easymotion-s2)
map f <Plug>(easymotion-bd-fl2)
noremap W b

" === perl ================================================================
"set iskeyword+=$
"set iskeyword+=%
"set iskeyword+=@-@
set iskeyword+=: " 本当はC-wで消すときに全部消えて困る．UniteWithCursorWordのときだけ有効にしたい
set iskeyword-=,

" 本当はheredocと__END__は展開しておいて，途中にあるpodだけをfoldしたい
let perl_fold = 1
let perl_nofold_packages = 1
let perl_nofold_subs = 1

let g:perlomni_export_functions = 1

augroup filetypedetect
    autocmd! BufNewFile,BufRead *.t,*.psgi,cpanfile setf perl
    autocmd! BufNewFile,BufRead *.tt                setf tt2html
    autocmd! BufNewFile,BufRead *.tx                setf xslate
    autocmd BufNewFile,BufRead *.html,*.tt,*.xhtml,*.opf,*.ncx setlocal tabstop=2 shiftwidth=2
augroup END

command! ProveThis call s:prove_this()
function! s:prove_this()
  let func_name = cfi#format('%s', '')
  let $TEST_METHOD = func_name
  QuickRun prove/carton
endfunction

command! ProveThisFailonly call s:prove_this_failonly()
function! s:prove_this_failonly()
  let func_name = cfi#format('%s', '')
  let $TEST_METHOD = func_name
  QuickRun prove/carton/failonly
endfunction

au FileType perl nnoremap <Leader>t :ProveThis<CR>
au FileType perl nnoremap <Leader>T :ProveThisFailonly<CR>

function! s:get_package_name()
    let mx = '^\s*package\s\+\([^ ;]\+\)'
    for line in getline(1, 5)
    if line =~ mx
    return substitute(matchstr(line, mx), mx, '\1', '')
    endif
    endfor
    return ""
endfunction

function! s:check_package_name()
    let path = substitute(expand('%:p'), '\\', '/', 'g')
    let name = substitute(s:get_package_name(), '::', '/', 'g') . '.pm'
    if path[-len(name):] != name
        echohl WarningMsg
        echomsg "ファイル名とパッケージ名が整合していません"
        echohl None
    endif
endfunction
au! BufWritePost *.pm call s:check_package_name()

function! s:pm_template()
    let path = substitute(expand('%'), '.*lib/', '', 'g')
    let path = substitute(path, '[\\/]', '::', 'g')
    let path = substitute(path, '\.pm$', '', 'g')

    execute ':normal a' . 'package ' . path . ';'
    call append(1, 'use strict;')
    call append(2, 'use warnings;')
    call append(3, 'use utf8;')
    call append(4, '')
    call append(5, '')
    call append(6, '')
    call append(7, '1;')
    call cursor(6, 0)
    echomsg path
endfunction

function! s:pl_template()
    execute ':normal a' . 'use v5.20;'
    call append(1, "use warnings;")
    call append(2, 'use utf8;')
    call append(3, '')
    call cursor(5, 0)
endfunction

function! s:t_template()
    execute ':normal a' . 'use strict;'
    call append(1, 'use warnings;')
    call append(2, 'use utf8;')
    call append(3, 'use Test::More;')
    call append(4, '')
    call append(5, '')
    call append(6, '')
    call append(7, 'done_testing;')
    call cursor(6, 0)
endfunction
j
function! s:t_template_giga()
    let path = substitute(expand('%'), '^.\{-}t/', '', 'g')
    let path = substitute(path, '[\\/]', '::', 'g')
    let path = substitute(path, '\.t$', '', 'g')

    "execute ':normal a' . 'package t::Giga::' . path . ';'
    execute ':normal a' . 'package t::Test::' . path . ';'
    call append(1, 'use t::test -2;')
    call append(2, '')
    "call append(3, 'use Giga::' . path . ';')
    call append(3, '')
    call append(4, '')
    call cursor(5, 0)
endfunction

function! s:t_template_tokyo()
    let path = substitute(expand('%'), '^.\{-}t/\(.\)', '\u\1', 'g')
    let path = substitute(path, '[\\/]\(.\)', '::\u\1', 'g')
    let path = substitute(path, '\.t$', '', 'g')
    let path = substitute(path, '-\(.\)', '\u\1', 'g') " camelcase
    let path = substitute(path, 'AppApi', 'App::Api', 'g')
    let path = substitute(path, 'App::Api', 'Web::Core::App::Api::V1', 'g')

    execute ':normal a' . 'package t::Tokyo::Dome::' . path . ';'
    call append(1, 'use t::test -2;')
    call append(2, 'use parent qw(Test::Class);')
    call append(3, '')
    call append(4, '')
    call append(5, '')
    call append(6, '__PACKAGE__->runtests;')
    call cursor(5, 0)
endfunction

autocmd BufNewFile *.pm call s:pm_template()
autocmd BufNewFile *.pl call s:pl_template()
"autocmd BufNewFile *.t  call s:t_template()
"autocmd BufNewFile *.t  call s:t_template_giga()
autocmd BufNewFile *.t  call s:t_template_tokyo()

"autocmd BufWritePre *.pm,*.pl,*.t :Postfixderef
command! -buffer Postfixderef call s:PerlLegacyPostfixDeref()
function! s:PerlLegacyPostfixDeref()
    let view = winsaveview()
    silent execute '%!legacy_postfixderef'
    call winrestview(view)
endfunction

" === python ==============================================================

" === golang ==============================================================
au BufRead,BufNewFile *.go setf go
autocmd BufWritePost *.go :GoBuild
let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
let g:go_snippet_engine = "neosnippet"
let g:gocomplete#system_function = 'vimproc#system'
let g:go_term_mode = "split"
let g:go_term_height = 15
let g:go_term_enabled = 1

au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>e <Plug>(go-rename)

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1

autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/

autocmd FileType go highlight SpecialKey cterm=none ctermfg=none

" === misc ================================================================
noremap <C-p> <C-o>
noremap <C-n> <C-i>

inoremap <BS> <Del>
inoremap <C-f> <C-x><C-o>

vnoremap <silent> <Enter> :EasyAlign<cr>

vmap s !sort<CR>
vmap t :EasyAlign =<CR>
vmap w :s/\(..\)/\\x\1/g<CR>
vmap <Leader>c <Plug>(caw:zeropos:toggle)

nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>

augroup fileindent
    autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
    "autocmd FileType javascript setlocal sw=4 sts=4 ts=4 et
    autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
    autocmd FileType go setlocal sw=4 ts=4 sts=4 noet
augroup END

augroup filetypedetect
    autocmd! BufNewFile,BufRead *.md setf markdown
augroup END

autocmd FileType * setlocal formatoptions-=ro
autocmd BufRead,BufNewFile Makefile set noexpandtab

augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'))
    function! s:auto_mkdir(dir)
    if !isdirectory(a:dir)
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
    endfunction
augroup END

function! s:exploit_py_template()
    call append(0, "# -*- coding: utf-8 -*-")
    call cursor(2, 0)
endfunction
autocmd BufNewFile *.py call s:exploit_py_template()

function! s:exploit_sh_template()
    call append(0, "#!/bin/bash")
    call cursor(2, 0)
endfunction
autocmd BufNewFile *.sh call s:exploit_sh_template()
