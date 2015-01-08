" Neobundle  "{{{
if has('vim_starting')
  set nocompatible               " Be iMproved
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" emmet  "{{{
" https://github.com/mattn/emmet-vim

NeoBundleLazy 'mattn/emmet-vim', {
      \ 'autoload' : {
      \   'filetypes' : ['css', 'html', 'php', 'slim', 'haml', 'jade', 'scss', 'sass', 'less', 'stylus']
      \ }
      \}

let s:bundle = neobundle#get('emmet-vim')
function! s:bundle.hooks.on_source(bundle)

  " augroup emmet_stylus
  "   autocmd BufRead,BufNewFile *.stylus set filetype=sass
  " augroup END

  let g:user_emmet_settings = {
    \ 'lang' : 'ja',
    \ 'html' : {
    \ 'filters' : 'html',
    \ 'indentation' : ' '
    \ },
    \ 'perl' : {
    \ 'indentation' : ' ',
    \ 'aliases' : {
    \ 'req' : "require '|'"
    \ },
    \ 'snippets' : {
    \ 'use' : "use strict\nuse warnings\n\n",
    \ 'w' : "warn \"${cursor}\";",
    \ },
    \ },
    \ 'php' : {
    \ 'extends' : 'html',
    \ 'filters' : 'html,c',
    \ },
    \ 'css' : {
    \ 'filters' : 'fc',
    \ },
    \ 'stylus' : {
    \ 'filters' : 'fc',
    \ },
    \ 'slim': {
    \ 'extends' : 'html',
    \ 'filters' : 'c',
    \ },
    \ 'javascript' : {
    \ 'snippets' : {
    \ 'jq' : "$(function() {\n\t${cursor}${child}\n});",
    \ 'jq:each' : "$.each(arr, function(index, item)\n\t${child}\n});",
    \ 'fn' : "(function() {\n\t${cursor}\n})();",
    \ 'tm' : "setTimeout(function() {\n\t${cursor}\n}, 100);",
    \ },
    \ },
    \ 'java' : {
    \ 'indentation' : ' ',
    \ 'snippets' : {
    \ 'main': "public static void main(String[] args) {\n\t|\n}",
    \ 'println': "System.out.println(\"|\");",
    \ 'class': "public class | {\n}\n",
    \ },
    \ },
    \}
endfunction
unlet s:bundle

"}}}

" vimdoc-ja  "{{{
NeoBundleLazy 'vim-jp/vimdoc-ja', {
      \ 'autoload' : {
      \   'commands' : ['help'],
      \ }
      \}
"}}}

" vim-ref  "{{{
" https://github.com/thinca/vim-ref

" https://github.com/mojako/ref-sources.vim
NeoBundle 'mojako/ref-sources.vim'
NeoBundle 'jquery/api.jquery.com'
NeoBundleLazy 'thinca/vim-ref', {
      \ 'autoload' : {
      \   'commands' : ['Ref']
      \ }
      \}
nnoremap [ref] <Nop>
nmap <Space>r [ref]
nnoremap [ref]w :Ref webdict wikipedia
nnoremap [ref]e :Ref webdict weblio
nnoremap [ref]q :Ref webdict jquery
nnoremap [ref]r :Ref webdict ruby

let s:bundle = neobundle#get('vim-ref')
function! s:bundle.hooks.on_source(bundle)
  let g:ref_jquery_doc_path = $HOME.'/.vim/bundle/api.jquery.com'
  " let $PATH = $PATH . '/usr/local/bin/'
  let g:ref_open = ':vsplit'
  let g:ref_source_webdict_sites = {
        \ 'wikipedia': {
        \   'url' : 'http://ja.wikipedia.org/wiki/%s',
        \ },
        \ 'weblio': {
        \   'url' : 'http://ejje.weblio.jp/content/%s',
        \ },
        \ 'jquery': {
        \   'url' : 'http://api.jquery.com/%s/',
        \ },
        \ 'ruby': {
        \   'url': 'http://www.ruby-doc.org/core-2.1.1/%s'
        \ },
        \}

  " 出力に対するフィルタ。最初の数行を削除
  function! g:ref_source_webdict_sites.weblio.filter(output)
    return join(split(a:output, "\n")[60 :], "\n")
  endfunction
  function! g:ref_source_webdict_sites.jquery.filter(output)
    return join(split(a:output, "\n")[43 :], "\n")
  endfunction

endfunction
unlet s:bundle
"}}}

" vim-colors-solarized  "{{{
" https://github.com/altercation/vim-colors-solarized
NeoBundle 'altercation/vim-colors-solarized'
"}}}

" lightline.vim  "{{{
" https://github.com/itchyny/lightline.vim

NeoBundle 'itchyny/lightline.vim'

" http://d.hatena.ne.jp/itchyny/20130828/1377653592
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [
        \     ['mode', 'paste'],
        \     ['readonly', 'fugitive', 'filename']
        \   ],
        \   'right': [
        \     ['lineinfo'],
        \     ['percent'],
        \     ['fileformat', 'fileencoding']
        \   ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \}

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
"}}}

" indentLine  "{{{
" https://github.com/Yggdroot/indentLine
NeoBundle 'Yggdroot/indentLine'
"}}}

" vim-easy-align  "{{{
" https://github.com/junegunn/vim-easy-align

NeoBundleLazy 'junegunn/vim-easy-align', {
      \ 'autoload' : {
      \   'mappings' : ['<Plug>(EasyAlign)']
      \ }
      \}

vmap <Space> <Plug>(EasyAlign)
"}}}

" vim-surround  "{{{
" https://github.com/tpope/vim-surround
NeoBundle 'tpope/vim-surround'
"}}}

" vim-better-whitespace  "{{{
" https://github.com/ntpeters/vim-better-whitespace

NeoBundle 'ntpeters/vim-better-whitespace'

"}}}

" syntax  "{{{
NeoBundle 'scrooloose/syntastic'

" html5.vim  "{{{
" https://github.com/othree/html5.vim
NeoBundleLazy 'othree/html5.vim', {
      \ 'autoload' : {
      \   'filetypes' : ['html']
      \ }
      \}
"}}}

" vim-css3-syntax  "{{{
" https://github.com/hail2u/vim-css3-syntax
NeoBundleLazy 'hail2u/vim-css3-syntax', {
      \ 'autoload' : {
      \   'filetypes' : ['sass', 'scss', 'less', 'styl']
      \ }
      \}
"}}}

" scss-syntax.vim  "{{{
" https://github.com/cakebaker/scss-syntax.vim
NeoBundleLazy 'cakebaker/scss-syntax.vim', {
      \ 'autoload' : {
      \   'filetypes' : ['sass', 'scss']
      \ }
      \}
"}}}

" vim-stylus  "{{{
" https://github.com/wavded/vim-stylus

NeoBundleLazy 'wavded/vim-stylus', {
      \ 'autoload' : {
      \   'filetypes' : ['stylus']
      \ }
      \}
"}}}

" vim-jade  "{{{
" https://github.com/digitaltoad/vim-jade

NeoBundleLazy 'digitaltoad/vim-jade', {
      \ 'autoload' : {
      \   'filetypes' : ['jade']
      \ }
      \}
"}}}

" vim-haml  "{{{
" https://github.com/tpope/vim-haml

NeoBundleLazy 'tpope/vim-haml', {
      \ 'autoload' : {
      \   'filetypes' : ['haml']
      \ }
      \}
"}}}

" vim-slim  "{{{
" https://github.com/slim-template/vim-slim

NeoBundleLazy 'slim-template/vim-slim', {
      \ 'autoload' : {
      \   'filetypes' : ['slim']
      \ }
      \}
"}}}

" vim-coffee-script  "{{{
" https://github.com/kchmck/vim-coffee-script

NeoBundleLazy 'kchmck/vim-coffee-script', {
      \ 'autoload' : {
      \   'filetypes' : ['coffee']
      \ }
      \}

" *.coffeeファイルを保存する度に自動で-cbオプションでコンパイル
" autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!

" Ctrl+Cで右側にコンパイルされたJSのプレビューを表示
nnoremap <silent><C-C> :CoffeeCompile vert <CR><C-w>h

"}}}

" vim-php
NeoBundleLazy 'StanAngeloff/php.vim', {
      \ 'autoload': {
      \   'filetypes': 'php'
      \ }
      \}

" vim-handlebars  "{{{
" https://github.com/nono/vim-handlebars

NeoBundleLazy 'nono/vim-handlebars', {
      \ 'autoload' : {
      \   'filetypes' : ['hbs']
      \ }
      \}
"}}}

" vim-markdown  "{{{
" https://github.com/tpope/vim-markdown

NeoBundleLazy 'tpope/vim-markdown', {
      \ 'autoload' : {
      \   'filetypes' : ['md']
      \ }
      \}
"}}}

" vim-rails  "{{{
" https://github.com/tpope/vim-rails

NeoBundleLazy 'tpope/vim-rails', {
      \ 'autoload' : {
      \   'filetypes' : ['ruby']
      \ }
      \}
"}}}

" vim-ruby"{{{
" https://github.com/vim-ruby/vim-ruby

NeoBundleLazy 'vim-ruby/vim-ruby', {
      \ 'autoload' : {
      \   'filetypes' : ['ruby']
      \ }
      \}
"}}}

" vim-bundler"{{{
" https://github.com/tpope/vim-bundler

NeoBundleLazy 'tpope/vim-bundler', {
      \ 'autoload' : {
      \   'filetypes' : ['ruby']
      \ }
      \}

nnoremap <Space>bo :Bopen<CR>
nnoremap <Space>bs :Bsplit<CR>
nnoremap <Space>bv :Bvsplit<CR>

"}}}

" vroom.vim"{{{
" https://github.com/skalnik/vim-vroom

NeoBundleLazy 'skalnik/vim-vroom', {
      \ 'autoload' : {
      \   'filetypes' : ['ruby']
      \ }
      \}
"}}}

" vim-ruby-refactoring"{{{
" https://github.com/ecomba/vim-ruby-refactoring
" document: https://www.relishapp.com/despo/vim-ruby-refactoring/docs

NeoBundleLazy 'ecomba/vim-ruby-refactoring', {
      \ 'depends' : 'tmhedberg/matchit',
      \ 'autoload' : {
      \   'filetypes' : ['ruby']
      \ }
      \}

" メソッドに引数を追加する
nnoremap <leader>ap  :RAddParameter<cr>

" 一行で書かれた条件文(e.g. "hoge if fuga?" のようなもの)を伝統的な複数行の形式に変換する
nnoremap <leader>cc :RConvertPostConditional<cr>

" 選択部分を RSpec の "let(:hoge) { fuga }" の形式に切り出す
nnoremap <leader>el  :RExtractLet<cr>

" 選択部分を定数として切り出す
vnoremap <leader>ec  :RExtractConstant<cr>

" 選択部分を変数として切り出す
vnoremap <leader>elv :RExtractLocalVariable<cr>

" 一時変数を取り除く
noremap <leader>it  :RInlineTemp<cr>

" ローカル変数をリネームする
vnoremap <leader>rlv :RRenameLocalVariable<cr>

" インスタンス変数をリネームする
vnoremap <leader>riv :RRenameInstanceVariable<cr>

" 選択部分をメソッドに切り出す
vnoremap <leader>em  :RExtractMethod<cr>
"}}}

" vim-json"{{{
" https://github.com/elzr/vim-json

NeoBundleLazy 'elzr/vim-json', {
      \ 'autoload': {
      \   'filetypes': ['json']
      \ }
      \}

let s:bundle = neobundle#get('vim-json')
function! s:bundle.hooks.on_source(bundle)
  let g:vim_json_syntax_conceal = 0
endfunction
unlet s:bundle
"}}}

"}}}

" vim-over  "{{{
" https://github.com/osyo-manga/vim-over

NeoBundleLazy 'osyo-manga/vim-over', {
      \ 'autoload' : {
      \   'commands' : ['OverCommandLine']
      \ }
      \}

" http://qiita.com/syui/items/3a1af1301ee197b32a8a
" vim-overを起動
nnoremap <Space>oc :OverCommandLine<CR>%s/
" カーソル下の単語をハイライト付きで置換
nnoremap <Space>ss :OverCommandLine<CR>%s/<C-r><C-w>//gI<Left><Left><Left>
" コピーした文字列をハイライト付きで置換
nnoremap <Space>sp y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left>

"}}}

" vim-easymotion  "{{{
" https://github.com/Lokaltog/vim-easymotion
" http://blog.remora.cx/2012/08/vim-easymotion.html

NeoBundleLazy 'Lokaltog/vim-easymotion', {
      \ 'autoload' : {
      \   'mappings' : ['<Plug>(easymotion-']
      \ }
      \}

noremap [easymotion] <Nop>
map ; [easymotion]
map [easymotion] <Plug>(easymotion-prefix)

" n-character search motion
map  [easymotion]/ <Plug>(easymotion-sn)
omap [easymotion]/ <Plug>(easymotion-tn)
map  [easymotion]n <Plug>(easymotion-next)
map  [easymotion]N <Plug>(easymotion-prev)

let s:bundle = neobundle#get('vim-easymotion')
function! s:bundle.hooks.on_source(bundle)
  " ホームポジションに近いキーを使う
  let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
  " 「;」 + 何かにマッピング
  let g:EasyMotion_leader_key=";"
  " 1 ストローク選択を優先する
  let g:EasyMotion_grouping=1
  " v will match both v and V, but V will match V only
  let g:EasyMotion_use_smartsign_us = 1 " US layout
  " match multibyte Japanese characters with alphabetical input
  let g:EasyMotion_use_migemo = 1
endfunction
unlet s:bundle

"}}}

" incsearch.vim  "{{{
" https://github.com/haya14busa/incsearch.vim

NeoBundleLazy 'haya14busa/incsearch.vim', {
      \ 'autoload': {
      \   'mappings': ['<Plug>(incsearch-']
      \ }
      \}

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let s:bundle = neobundle#get('incsearch.vim')
function! s:bundle.hooks.on_source(bundle)

  set hlsearch
  let g:incsearch#auto_nohlsearch = 1

  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)

  let g:incsearch#emacs_like_keymap = 1

endfunction
unlet s:bundle

"}}}

" clever-f.vim  "{{{
" https://github.com/rhysd/clever-f.vim
" http://rhysd.hatenablog.com/entry/2013/09/17/220837
NeoBundle 'rhysd/clever-f.vim'

" 行をまたいで検索しない
let g:clever_f_across_no_line = 1
" 大文字を入力した時のみ大文字小文字を区別
let g:clever_f_smart_case = 1
" for Japanese
let g:clever_f_use_migemo = 1
" f と F の検索方向を固定する(f は必ず右方向に移動，F は必ず左方向に移動)
let g:clever_f_fix_key_direction = 1
" f; で任意の記号にマッチ
let g:clever_f_chars_match_any_signs = ';'
"}}}

" neocomplete.vim  "{{{
" https://github.com/Shougo/neocomplete.vim
NeoBundle 'Shougo/neocomplete.vim'

" neocomplete "{{{

let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 4
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Plugin key-mappings.
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>   neocomplete#close_popup()
inoremap <expr><C-e>   neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
augroup omni_filetype
  autocmd!
  autocmd FileType css,scss,sass setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown,slim setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"}}}
"}}}

" neosnippet.vim  "{{{

NeoBundle 'Shougo/neosnippet.vim'

" neosnippet "{{{
 " Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" Open vertical split window to edit snippets file
nnoremap <Space>ns :NeoSnippetEdit -vertical -split<CR>

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" which disables all runtime snippets
let g:neosnippet#disable_runtime_snippets = {
\   '_' : 1,
\ }
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/snippets/'
"}}}
"}}}

" context_filetype.vim"{{{
NeoBundle'Shougo/context_filetype.vim'
"}}}

" unite.vim  "{{{
NeoBundleLazy 'Shougo/unite.vim', {
      \ 'autoload': {
      \   'commands' : ['Unite'],
      \ }
      \}

" The prefix key.
nnoremap [unite] <Nop>
nmap <Space>u [unite]

nnoremap <silent>[unite]/ :<C-u>Unite line<CR>
nnoremap <silent>[unite]c :<C-u>Unite command<CR>
nnoremap <silent>[unite]j :<C-u>Unite jump<CR>
nnoremap <silent>[unite]m :<C-u>Unite mapping<CR>
nnoremap <silent>[unite]s :<C-u>Unite neosnippet/runtime neosnippet/user<CR>

" recursive file search, starting insert automatically
nnoremap <silent>[unite]f :<C-u>Unite file_rec/async:!<CR>

" Similar to unite-source-file_rec, but get files by `git ls-files` command. It is faster than file_rec/async source.
nnoremap <silent>[unite]fg :<C-u>Unite file_rec/git:--cached:--others:--exclude-standard<CR>

" Search through yank history
nnoremap <silent>[unite]y :<C-u>Unite history/yank<CR>

" Nominates opend buffers as candidates
nnoremap <silent>[unite]b :<C-u>Unite buffer<CR>

" grep
" http://blog.monochromegane.com/blog/2013/09/18/ag-and-unite/
nnoremap <silent>[unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" Recoll grep command
nnoremap <silent>[unite]gr :<C-u>UniteResume search-buffer<CR>

let s:bundle = neobundle#get('unite.vim')
function! s:bundle.hooks.on_source(bundle)
  call unite#filters#matcher_default#use(['matcher_fuzzy'])

  let g:unite_enable_start_insert=1
  let g:unite_enable_ignore_case = 1
  let g:unite_enable_smart_case = 1
  let g:unite_source_history_yank_enable = 1
  let g:unite_source_file_mru_limit = 200
  let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup --hidden -g ""'

  " Using ag(The Silver Searcher) with unite grep
  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
  endif
endfunction
unlet s:bundle

"}}}

" vimfiler  "{{{
" https://github.com/Shougo/vimfiler.vim

NeoBundleLazy 'Shougo/vimfiler', {
      \ 'depends' : ['Shougo/unite.vim'],
      \ 'autoload' : {
      \   'commands' : ['VimFiler']
      \ }
      \}

noremap <Space>vf :VimFiler<CR>

let s:bundle = neobundle#get('vimfiler')
function! s:bundle.hooks.on_source(bundle)
  " :e. で起動
  let g:vimfiler_as_default_explorer = 1
  " セーフモードをデフォルトで解除
  let g:vimfiler_safe_mode_by_default = 0

  " To open a vimfiler tree automatically when Vim starts up
  " autocmd VimEnter * VimFiler

  " Edit file by tabedit.
  let g:vimfiler_edit_action = 'open'
  "
  " Like Textmate icons.
  let g:vimfiler_tree_leaf_icon = ' '
  let g:vimfiler_tree_opened_icon = '▾'
  let g:vimfiler_tree_closed_icon = '▸'
  let g:vimfiler_file_icon = '-'
  let g:vimfiler_marked_file_icon = '*'
endfunction
unlet s:bundle

"}}}

" vimshell  "{{{
" https://github.com/Shougo/vimshell.vim
NeoBundleLazy 'Shougo/vimshell', {
      \ 'depends' : ['Shougo/vimproc'],
      \ 'autoload' : {
      \   'commands' : ['vimshell', 'VimShellBufferDir', 'VimShellPop']
      \ }
      \}

nnoremap <Space>vs :VimShell<CR>
nnoremap <Space>vsc :VimShellBufferDir<CR>
nnoremap <Space>vp :VimShellPop<CR>

let s:bundle = neobundle#get('vimshell')
function! s:bundle.hooks.on_source(bundle)
  " Display command history <C-l> in insert mode.
  let g:vimshell_prompt_expr = 'getcwd()." > "'
  let g:vimshell_prompt_pattern = '^\f\+ > '
endfunction
unlet s:bundle

"}}}

" vimproc  "{{{
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \ 'windows' : 'make -f make_mingw32.mak',
  \ 'cygwin' : 'make -f make_cygwin.mak',
  \ 'mac' : 'make -f make_mac.mak',
  \ 'unix' : 'make -f make_unix.mak',
  \ },
\ }
"}}}

" wildfire.vim  "{{{
" https://github.com/gcmt/wildfire.vim
NeoBundle 'gcmt/wildfire.vim'

let g:wildfire_fuel_map = '<Enter>'
let g:wildfire_water_map = '<BS>'

"}}}

" smartpairs.vim  "{{{
" https://github.com/gorkunov/smartpairs.vim
NeoBundle 'gorkunov/smartpairs.vim'

"Key for running smartpairs in all modes (select/delete/change/yank)
"default is 'v'
let g:smartpairs_key = 'v'

"Key for running smartpairs in the selection mode
"(extend current selection to the next pairs)
"default is 'v'
let g:smartpairs_nextpairs_key = 'v'

"Enable 'uber mode' (see above)
"default is 1
let g:smartpairs_uber_mode = 1

"Start selection from word
"If there is no regions then select word
"default is 0
let g:smartpairs_start_from_word = 1

"Key for running smartpairs in the selection mode
"for extending selection with IN-mod (like vi")
"default is 'm'
let g:smartpairs_nextpairs_key_i = 'm'

"Key for running smartpairs in the selection mode
"for extending selection with ABOVE-mod (like va")
"default is 'M'
let g:smartpairs_nextpairs_key_a = 'M'

"Keys combination for canceling last smartpais selection
"default is '<C-V>' Ctrl+Shift+v
"under macvim you can use Cmd key e.g. <D-V> -> Cmd+Shift+v
let g:smartpairs_revert_key = '<C-V>'

"Smartpairs works only with 20 lines before cursor position
"but you can changes this limit:
let g:smartpairs_maxdepth = 20

"}}}

"text-object  "{{{
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-fold'
NeoBundle 'thinca/vim-textobj-between'
NeoBundle 'glts/vim-textobj-comment'
" NeoBundle 'kanavim-textobj-datetime'
NeoBundle 'kana/vim-textobj-function'
NeoBundle 'Julian/vim-textobj-brace'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'saihoooooooo/vim-textobj-space'
NeoBundle 'kana/vim-textobj-syntax'
NeoBundle 'lucapette/vim-textobj-underscore'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'mattn/vim-textobj-url'
NeoBundle 'akiyan/vim-textobj-php'
NeoBundle 'bps/vim-textobj-python'
NeoBundle 'nelstrom/vim-textobj-rubyblock'
NeoBundle 'vimtaku/vim-textobj-sigil'
"}}}

" tcomment_vim  "{{{
" https://github.com/tomtom/tcomment_vim
NeoBundle 'tomtom/tcomment_vim'
"}}}

" vim-submodue "{{{
" https://github.com/kana/vim-submode

NeoBundleLazy 'kana/vim-submode', {
      \ 'autoload': {
      \   'functions': ['submode#enter_with']
      \ }
      \}

"}}}

" vim-auto-save  "{{{
" https://github.com/vim-scripts/vim-auto-save
" NeoBundle 'vim-scripts/vim-auto-save'
" let g:auto_save = 1  " enable AutoSave on Vim startup
"}}}

" auto-pairs  "{{{
" https://github.com/jiangmiao/auto-pairs

NeoBundle 'jiangmiao/auto-pairs'
"}}}

" vim-endwise "{{{
" https://github.com/tpope/vim-endwise

NeoBundle 'tpope/vim-endwise'
"}}}

" vim-fugitive  "{{{
" https://github.com/tpope/vim-fugitive
NeoBundle 'tpope/vim-fugitive'

nnoremap <Space>gs :Gstatus<CR>
nnoremap <Space>ga :Git add .<CR>
nnoremap <Space>gc :Git commit<CR>
nnoremap <Space>gca :Git commit --amend<CR>
nnoremap <Space>gp :Gpush origin master<CR>
nnoremap <Space>gbr :Gbrowse<CR>
"}}}

" commita.vim "{{{
" https://github.com/rhysd/committia.vim

NeoBundle 'rhysd/committia.vim'

let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    end

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)

endfunction
"}}}

" Agit.vim "{{{
" https://github.com/cohama/agit.vim
" http://qiita.com/c0hama/items/05fadf117c605aa8b592
" http://qiita.com/c0hama/items/99a6f92323ca5e6fb730

NeoBundleLazy 'cohama/agit.vim', {
      \ 'autoload': {
      \   'commands': ['Agit-']
      \ }
      \}

"}}}

" open-browser  "{{{
" https://github.com/tyru/open-browser.vim

NeoBundleLazy 'tyru/open-browser.vim', {
      \ 'autoload' : {
      \   'mappings' : ['<Plug>(openbrowser-']
      \ }
      \}

" Open URI under cursor.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" Search word under cursor.
nmap gw <Plug>(openbrowser-search)
vmap gw <Plug>(openbrowser-search)

let s:bundle = neobundle#get('open-browser.vim')
function! s:bundle.hooks.on_source(bundle)
  let g:netrw_nogx = 1 " disable netrw's gx mapping.
endfunction
unlet s:bundle

"}}}

" previm  "{{{
" https://github.com/kannokanno/previm/blob/master/doc/previm.jax
" http://mba-hack.blogspot.jp/2013/11/vimmarkdown.html

" NeoBundleLazy 'kannokanno/previm', {
"       \ 'autoload' : {
"       \   'commands' : ['PrevimOpen'],
"       \ }
"       \}
"
" " <F6>でプレビュー
" nnoremap <silent><F6> :PrevimOpen<CR>
"
" let s:bundle = neobundle#get('previm')
" function! s:bundle.hooks.on_source(bundle)
"   " let g:previm_open_cmd = 'open -a GoogleChrome'
" endfunction
" unlet s:bundle

"}}}

" vim-choosewin  "{{{
" https://github.com/t9md/vim-choosewin

NeoBundleLazy 't9md/vim-choosewin', {
      \ 'autoload' : {
      \   'mappings' : ['<Plug>(choosewin)'],
      \ }
      \}

nmap - <Plug>(choosewin)

let s:bundle = neobundle#get('vim-choosewin')
function! s:bundle.hooks.on_source(bundle)

  " オーバーレイを使う
  let g:choosewin_overlay_enable = 1

  " マルチバイトバッファでオーバーレイフォントを崩さないように
  let g:choosewin_overlay_clear_multibyte = 1

  " tmux の色に雰囲気を合わせる。
  let g:choosewin_color_overlay = {
        \ 'gui': ['DodgerBlue3', 'DodgerBlue3' ],
        \ 'cterm': [ 25, 25 ]
        \ }
  let g:choosewin_color_overlay_current = {
        \ 'gui': ['firebrick1', 'firebrick1' ],
        \ 'cterm': [ 124, 124 ]
        \ }

  " 着地時にカーソル点滅をさせない
  let g:choosewin_blink_on_land = 0
  " ステータスラインに表示させない
  let g:choosewin_statusline_replace = 0

endfunction
unlet s:bundle

"}}}

" switch.vim  "{{{
" https://github.com/AndrewRadev/switch.vim
" http://deris.hatenablog.jp/entry/2013/12/15/235606

NeoBundleLazy 'AndrewRadev/switch.vim', {
      \ 'autoload' : {
      \   'commands' : ['Switch']
      \ }
      \}

nnoremap <Space>s :<C-u>Switch<CR>

let s:bundle = neobundle#get('switch.vim')
function! s:bundle.hooks.on_source(bundle)
  let g:switch_custom_definitions =
      \ [
      \   ['left', 'right'],
      \   ['top', 'bottom'],
      \   ['yes', 'no'],
      \   ['jpg', 'png', 'gif'],
      \   ['on', 'off'],
      \ ]

  autocmd FileType css,scss,sass,less,styl let b:switch_custom_definitions =
      \ [
      \   ['px', 'em', 'rem'],
      \   ['italic', 'oblique'],
      \   ['bold', 'lighter', 'bolder'],
      \   ['block', 'inline', 'inline-block'],
      \   ['static', 'relative', 'absolute', 'fixed'],
      \   ['visible', 'scroll', 'hidden'],
      \   ['solid', 'double', 'ridge', 'inset', 'outset', 'dashed', 'dotted'],
      \   ['outside', 'inside'],
      \   ['disc', 'circle', 'square', 'lower-roman', 'upper-roman', 'lower-greek', 'decimal', 'decimal-deading-zero', 'lower-latin', 'lower-alpha', 'upper-latin', 'upper-aplpha', 'cjk-ideographic', 'hiragana', 'katakana', 'hiragana-iroha', 'katakana-iroha', 'hebrew', 'armenian', 'georgian'],
      \   ['pointer', 'crosshair', 'move', 'text', 'wait', 'help', 'progress'],
      \ ]
endfunction
unlet s:bundle

"}}}

" vim-quickrun  "{{{
" https://github.com/thinca/vim-quickrun
" http://d.hatena.ne.jp/osyo-manga/20130311/1363012363

NeoBundleLazy 'thinca/vim-quickrun', {
      \ 'autoload' : {
      \   'commands' : ['QuickRun'],
      \ }
      \}

let s:bundle = neobundle#get('vim-quickrun')
function! s:bundle.hooks.on_source(bundle)
  let g:quickrun_config = {
      \ '_': {
      \   'runner': 'vimproc',
      \   'runner/vimproc/updatetime': 60,
      \   'outputter/buffer/split': ':vsplit',
      \   'outputter/buffer/close_on_empty': 1
      \ },
      \ 'html': {
      \   'type': 'html/slim'
      \ },
      \ 'html/slim': {
      \   'command': 'html2slim'
      \ },
      \ 'ruby.rspec' : {
      \   'command': 'rspec',
      \   'cmdopt': 'bundle exec',
      \   'args': '--color',
      \   'exec': '%o %c %s %a'
      \ }
      \}
endfunction
unlet s:bundle

augroup RSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END
"}}}

" calender.vim  "{{{
" https://github.com/itchyny/calendar.vim

NeoBundleLazy 'itchyny/calendar.vim', {
      \ 'autoload' : {
      \   'commands' : ['Calendar']
      \ }
      \}

let s:bundle = neobundle#get('calendar.vim')
function! s:bundle.hooks.on_source(bundle)
  let g:calendar_google_calendar = 1
  let g:calendar_google_task = 1
endfunction
unlet s:bundle
"}}}

" neomru  "{{{
NeoBundleLazy 'Shougo/neomru.vim', {
      \ 'depends' : ['Shougo/unite.vim'],
      \ 'autoload' : {
      \   'commands' : ['Unite'],
      \ }
      \}
"}}}

" " unite-codic-vim  "{{{
" " https://github.com/rhysd/unite-codic.vim
" " https://github.com/koron/codic-vim
"
" NeoBundle 'koron/codic-vim'
" NeoBundleLazy 'rhysd/unite-codic.vim', {
"       \ 'depends' : ['Shougo/unite.vim', 'koron/codic-vim'],
"       \ 'autoload' : {
"       \   'commands' : ['Unite'],
"       \ }
"       \}
"
" nnoremap <silent>[unite]c :Unite codic<CR>a
" "}}}

" " unite-choosewin-actions  "{{{
" " http://d.hatena.ne.jp/osyo-manga/20140114/1389711504
"
" NeoBundleLazy 'osyo-manga/unite-choosewin-actions', {
"     \ 'depends' : ['Shougo/unite.vim'],
"     \ 'autoload' : {
"     \ 'commands' : ['Unite'],
"     \ }
"     \}
"
" let s:bundle = neobundle#get('unite-choosewin-actions')
" function! s:bundle.hooks.on_source(bundle)
"   " 選択を行わないウィンドウ番号をフィルタリングする関数
"   function! s:choosewin_is_ignore_window(action, winnr)
"       if a:action ==# "open"
"           return index(["unite", "vimfiler", "vimshell"], getbufvar(winbufnr(a:winnr), "&filetype")) >= 0
"       else
"           return 0
"       endif
"   endfunction
"   let g:Unite_kinds_choosewin_is_ignore_window_func = function("s:choosewin_is_ignore_window")
"
"   " ファイルを開く場合のデフォルトアクションを choosewin にする
"   call unite#custom#default_action('file' , 'choosewin/open')
" endfunction
" unlet s:bundle
"
" "}}}

" vim-unite-giti  "{{{
NeoBundleLazy 'kmnk/vim-unite-giti', {
      \ 'autoload': {
      \ 'unite_sources':[
      \   'giti', 'giti/branch', 'giti/branch/new', 'giti/branch_all',
      \   'giti/config', 'giti/log', 'giti/remote', 'giti/status'
      \   ]
      \ }
      \}

nnoremap <silent>gl :GitiLog<CR>
nnoremap <silent>gll :GitiLogLine<CR>

nnoremap <silent>[unite]gl :Unite giti/log<CR>
nnoremap <silent>[unite]gs :Unite giti/status<CR>
nnoremap <silent>[unite]gb :Unite giti/branch<CR>
" "}}}

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

"}}}

" Color Scheme "{{{
" Solarized
" https://github.com/altercation/vim-colors-solarized

" カラー端末の場合のみ構文強調を有効
if &t_Co > 1
  syntax enable
endif
set background=light
set t_Co=256
let g:solarized_termcolors=16
let g:solarized_termtrans=1
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized
"}}}

"Submode"{{{

" http://d.hatena.ne.jp/thinca/20130131/1359567419
" ウィンドウサイズ変更
call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')
" タブの切り替え
call submode#enter_with('changetab', 'n', '', 'sn', 'gt')
call submode#enter_with('changetab', 'n', '', 'sp', 'gT')
call submode#map('changetab', 'n', '', 'n', 'gt')
call submode#map('changetab', 'n', '', 'p', 'gT')
"}}}

" key mapping "{{{

" NORMAL MODE
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>
nnoremap <Space>. :<C-u>edit $MYVIMRC<Enter>
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
noremap <Space>h  ^
noremap <Space>l  $
nnoremap <Space>/  *
" noremap <Space>m  %
" 誤入力防止
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap <Esc><Esc> :nohlsearch<CR>

" insert breack
nnoremap br Ea<br /><ESC>J
nnoremap ibr Ea<CR><ESC>

" F5でファイルを Chrome で開く
nnoremap <F5> :!open -a Google\ Chrome %<CR><CR>
" watchmedo shell-command -c "osascript ~/bin/creload.scpt" ~/blog/

" ウィンドウ
" http://qiita.com/tekkc/items/98adcadfa4bdc8b5a6ca
nnoremap s <Nop> " sキーを無効
nnoremap sj <C-w>j " 下のウィンドウへ移動
nnoremap sk <C-w>k " 上のウィンドウへ移動
nnoremap sl <C-w>l " 右のウィンドウへ移動
nnoremap sh <C-w>h " 左のウィンドウへ移動
nnoremap sw <C-w>w " 次のウィンドウへ移動
nnoremap sJ <C-w>J " ウィンドウを上へ移動
nnoremap sK <C-w>K " ウィンドウを下へ移動
nnoremap sL <C-w>L " ウィンドウを右へ移動
nnoremap sH <C-w>H " ウィンドウを左へ移動
nnoremap sr <C-w>r " ウィンドウを回転
nnoremap s= <C-w>= " ウィンドウの大きさを揃える
nnoremap so <C-w>_<C-w>|
nnoremap ss :<C-u>sp<CR> " ウィンドウを水平分割
nnoremap sv :<C-u>vs<CR> " ウィンドウを垂直分割
nnoremap sq :<C-u>q<CR> " ウィンドウを閉じる

" バッファ
nnoremap sN :<C-u>bn<CR> " 次のバッファへ移動
nnoremap sP :<C-u>bp<CR> " 前のバッファへ移動
nnoremap sQ :<C-u>bd<CR> " バファを閉じる

" タブ
nnoremap st :<C-u>tabnew<CR> " 新しいタブを開く
nnoremap sx :tabclose<CR> " tx タブを閉じる
nnoremap sT :<C-u>Unite tab<CR> " タブ一覧を表示
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR> " 現在のタブで開いたバッファ一覧を表示
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR> " バッファ一覧を表示

" カーソル下のキーワードをバッファ内全体で置換する
" http://vim-users.jp/2009/08/hack62/
nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'

" Insert Mode
inoremap <C-e> <Esc>$a
inoremap <C-a> <Esc>^i
inoremap <C-w> <Esc>Wi
inoremap <C-b> <Esc>Bi
inoremap <C-l> <Esc>li

" Emmet comment for slim
" inoremap <C-y>, <Esc>yypI/! <Esc>A end<Esc><<O

" insertモードから抜ける
inoremap <silent> jj <ESC>
" inoremap <silent> <C-j> j
inoremap <silent> kk <ESC>
" inoremap <silent> <C-k> k

" 行頭・行末移動方向をキーの相対位置にあわせる
" nnoremap 0 $
" nnoremap 1 0

" 挿入モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" insert semicolon
inoremap ;<CR> <end>;
inoremap ;;<CR> <C-e><down><end>;

" VISUAL MODE
vnoremap <silent> > >gv
vnoremap <silent> < <gv
" 連番を入力
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor
"}}}

" Dectionary  "{{{

augroup my_dictionary
  autocmd!
  autocmd FileType php :set dictionary=~/.vim/dict/vim-dict-wordpress/*.dict
  autocmd FileType javascript :set dictionary=~/.vim/dict/javascript.dict
augroup END

"}}}

" set"{{{

" 画面表示の設定

set number         " 行番号を表示する
" set cursorline     " カーソル行の背景色を変える
" set cursorcolumn   " カーソル位置のカラムの背景色を変える
set laststatus=2   " ステータス行を常に表示
set cmdheight=1    " メッセージ表示欄を2行確保
set showmatch      " 対応する括弧を強調表示
set helpheight=999 " ヘルプを画面いっぱいに開く
" set list           " 不可視文字を表示
" set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮ " 不可視文字の表示記号指定
set foldmethod=marker " {{{}}}でフォールディング（折りたたみ）を有効
set showcmd   " 入力途中のコマンドをウィンドウの右下に表示

" タブ/インデントの設定

set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=2     " 画面上でタブ文字が占める幅
set shiftwidth=2  " 自動インデントでずれる幅
set softtabstop=2 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   "改行時に入力された行の末尾に合わせて次の行のインデントを増減する

" カーソル移動関連の設定

set backspace=indent,eol,start " Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set scrolloff=8                " 上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う

" ファイル処理関連の設定

set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     "保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   "外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない

" 検索/置換の設定

set hlsearch   " 検索文字列をハイライトする
set incsearch  " インクリメンタルサーチを行う
set ignorecase " 大文字と小文字を区別しない
set smartcase  "大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan   " 最後尾まで検索を終えたら次の検索で先頭に移る
"set gdefault   " 置換の時 g オプションをデフォルトで有効にする

" 動作環境との統合関連の設定

" OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする
set clipboard+=unnamed,unnamedplus
" マウスの入力を受け付ける
set mouse=a
" Windows でもパスの区切り文字を / にする
" set shellslash
" インサートモードから抜けると自動的にIMEをオフにする
" set iminsert=2
" ドラッグを有効
set ttymouse=xterm2
" 自動補完を有効
set omnifunc=syntaxcomplete#Complete
" 数値の形式を10進数に設定
set nrformats=

" コマンドラインの設定

" コマンドラインモードでTABキーによるファイル名補完を有効にする
" set wildmenu wildmode=list:longest,full
" コマンドラインの履歴を10000件保存する
" set history=10000

" ビープの設定

set visualbell t_vb= "ビープ音すべてを無効にする
set noerrorbells "エラーメッセージの表示時にビープを鳴らさない

" :help コマンドで日本語の優先順位をあげる
set helplang=ja,en
" 英語ヘルプを読みたい場合は以下のようにします
" :help @en

" 色

"}}}

" language"{{{

" php

" 文字列中でSQL構文ハイライト
let php_sql_query = 1

" Baselibメソッドのハイライト
let php_baselib = 1

" 文字列中でHTML構文ハイライト
let php_htmlInStrings = 1

" ショートタグを無効化したいなら: >
let php_noShortTags = 1

" ] や ) の対応エラーをハイライト
let php_parent_error_close = 1

" 対応する閉じ括弧がない開き括弧 ( や [ が存在する場合、php終了タグをスキップ
let php_parent_error_open = 1

" クラスや関数の折り畳みを有効
let php_folding = 1

"}}}

" autocmd  "{{{

augroup leav_paste_mode
  autocmd!
  autocmd InsertLeave * set nopaste "leave paste mode
augroup END

" 自動的にコメント文字列が挿入されるのをやめる
" https://gist.github.com/rbtnn/8540338
augroup auto_comment_off
	autocmd!
	autocmd BufEnter * setlocal formatoptions-=ro
augroup END

" 行番号の左側に余白を追加する
augroup numberwidth
    autocmd!
    autocmd BufEnter,WinEnter,BufWinEnter * let &l:numberwidth = len(line("$")) + 2
augroup END

" To clean extra whitespace using vim-better-whitespace
augroup claen_extra_whitespace
    autocmd!
    autocmd BufWritePre * :StripWhitespace
augroup END

"}}}

" command"{{{

" Json format by Jq command  "{{{
" http://qiita.com/tekkc/items/324d736f68b0f27680b8

function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq \"" . l:arg . "\""
endfunction
command! -nargs=? Jq call s:Jq(<f-args>)
nnoremap <Space>jq :Jq<Enter>
"}}}

" search dash document  "{{{
" http://qiita.com/yuyuchu3333/items/292e99a521a9653e75fb
function! s:dash(...)
  let ft = &filetype
  if &filetype == 'python'
    let ft = ft.'3'
  endif
  let ft = ft.':'
  let word = len(a:000) == 0 ? input('Dash search: ', ft.expand('<cword>')) : ft.join(a:000, ' ')
  call system(printf("open dash://'%s'", word))
endfunction
command! -nargs=* Dash call <SID>dash(<f-args>)
nnoremap <Space>d :Dash
"}}}

"}}}

