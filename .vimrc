" Neobundle  "{{{
if has('vim_starting')
   set nocompatible               " Be iMproved
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundle 'Shougo/neobundle.vim'

" emmet  "{{{
" https://github.com/mattn/emmet-vim

NeoBundleLazy 'mattn/emmet-vim', {
      \ 'autoload' : {
      \   'filetypes' : ['html', 'css', 'slim', 'haml', 'jade', 'scss', 'sass', 'less', 'styl']
      \ }
      \}

let s:bundle = neobundle#get('emmet-vim')
function! s:bundle.hooks.on_source(bundle)

  augroup emmet_stylus
    autocmd BufRead,BufNewFile *.styl set filetype=sass
  augroup END

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
    \ 'styl' : {
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

NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Yggdroot/indentLine'
" NeoBundle 'Align'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'tpope/vim-surround'

" syntax  "{{{
NeoBundle 'scrooloose/syntastic.git'

" html5.vim  "{{{
" https://github.com/othree/html5.vim
NeoBundleLazy 'othree/html5.vim', {
      \ 'autoload' : {
      \   'filetypes' : 'html' 
      \ }
      \}
"}}}

" vim-css3-syntax  "{{{
" https://github.com/hail2u/vim-css3-syntax
NeoBundleLazy 'hail2u/vim-css3-syntax', {
      \ 'autoload' : {
      \   'filetypes' : ['css', 'sass', 'scss', 'less', 'styl']
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
      \   'filetypes' : 'styl'
      \ }
      \}
"}}}

" vim-jade  "{{{
" https://github.com/digitaltoad/vim-jade

NeoBundleLazy 'digitaltoad/vim-jade', {
      \ 'autoload' : {
      \   'filetypes' : 'jade'
      \ }
      \}
"}}}

" vim-haml  "{{{
" https://github.com/tpope/vim-haml

NeoBundleLazy 'tpope/vim-haml', {
      \ 'autoload' : {
      \   'filetypes' : 'haml'
      \ }
      \}
"}}}

" vim-slim  "{{{
" https://github.com/slim-template/vim-slim

NeoBundleLazy 'slim-template/vim-slim', {
      \ 'autoload' : {
      \   'filetypes' : 'slim'
      \ }
      \}
"}}}

" vim-coffee-script  "{{{
" https://github.com/kchmck/vim-coffee-script

NeoBundleLazy 'kchmck/vim-coffee-script', {
      \ 'autoload' : {
      \   'filetypes' : 'coffee'
      \ }
      \}

" *.coffeeファイルを保存する度に自動で-cbオプションでコンパイル
" autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!

" Ctrl+Cで右側にコンパイルされたJSのプレビューを表示
nnoremap <silent><C-C> :CoffeeCompile vert <CR><C-w>h

"}}}

" vim-handlebars  "{{{
" https://github.com/nono/vim-handlebars

NeoBundleLazy 'nono/vim-handlebars', {
      \ 'autoload' : {
      \   'filetypes' : 'hbs'
      \ }
      \}
"}}}

" vim-markdown  "{{{
" https://github.com/tpope/vim-markdown

NeoBundleLazy 'tpope/vim-markdown', {
      \ 'autoload' : {
      \   'filetypes' : 'md'
      \ }
      \}
"}}}

" vim-rails  "{{{
" https://github.com/tpope/vim-rails

NeoBundle 'tpope/vim-rails'
"}}}

" vim-ruby"{{{
" https://github.com/vim-ruby/vim-ruby

NeoBundleLazy 'vim-ruby/vim-ruby', {
      \ 'autoload' : {
      \   'filetypes' : 'rb'
      \ }
      \}
"}}}
"}}}

" NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'troydm/easybuffer.vim'

" vim-easymotion  "{{{
" https://github.com/Lokaltog/vim-easymotion
" http://blog.remora.cx/2012/08/vim-easymotion.html

NeoBundleLazy 'Lokaltog/vim-easymotion', {
      \ 'autoload' : {
      \   'mappings' : [
      \     '<Plug>(easymotion-prefix)',
      \     '<Plug>(easymotion-s2)',
      \     '<Plug>(easymotion-t2)',
      \     '<Plug>(easymotion-tn)',
      \     '<Plug>(easymotion-sn)',
      \     '<Plug>(easymotion-next)',
      \     '<Plug>(easymotion-prev)'
      \   ]
      \ }
      \}

map [easymotion] <Nop>
map <Space>m [easymotion]
map [easymotion] <Plug>(easymotion-prefix)

" 2-character search motion
nmap [easymotion]s <Plug>(easymotion-s2)
nmap [easymotion]t <Plug>(easymotion-t2)

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

NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'

" unite  "{{{
NeoBundleLazy 'Shougo/unite.vim', {
      \ 'autoload': {
      \   'commands' : ['Unite']
      \ }
      \}

" unite  "{{{
" start in insert mode so any typing will filter the candidate list
nnoremap <leader>f :<C-u>Unite -start-insert file<CR>

nnoremap <leader>r :<C-u>Unite -start-insert file_rec<CR>
" nnoremap <leader>r :<C-u>Unite -start-insert file_rec/async:!<CR>

" Most recently used files
noremap <leader>m :<C-u>Unite file_mru<CR>

" Search through yank history. First, this must be enabled to track yank history, then the mapping set.
nnoremap <leader>y :<C-u>Unite history/yank<CR>

" The prefix key.
nnoremap    [unite]   <Nop>
nmap    <Space> [unite]

nnoremap <silent> [unite]c  :<C-u>UniteWithCurrentDir
      \ -buffer-name=files buffer file_mru bookmark file<CR>
" nnoremap <silent> [unite]b  :<C-u>UniteWithBufferDir
"       \ -buffer-name=files -prompt=%\  buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]b  :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]r  :<C-u>Unite
      \ -buffer-name=register register<CR>
nnoremap <silent> [unite]o  :<C-u>Unite outline<CR>
nnoremap <silent> [unite]f
      \ :<C-u>Unite -buffer-name=resume resume<CR>
nnoremap <silent> [unite]d
      \ :<C-u>Unite -buffer-name=files -default-action=lcd directory_mru<CR>
nnoremap <silent> [unite]ma
      \ :<C-u>Unite mapping<CR>
nnoremap <silent> [unite]me
      \ :<C-u>Unite output:message<CR>
nnoremap  [unite]f  :<C-u>Unite source<CR>

nnoremap <silent> [unite]s
      \ :<C-u>Unite -buffer-name=files -no-split
      \ jump_point file_point buffer_tab
      \ file_rec:! file file/new file_mru<CR>

function! s:unite_my_settings()"{{{
  " Overwrite settings.

  nmap <buffer> <ESC>      <Plug>(unite_exit)
  imap <buffer> jj      <Plug>(unite_insert_leave)
  "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

  imap <buffer><expr> j unite#smart_map('j', '')
  imap <buffer> <TAB>   <Plug>(unite_select_next_line)
  imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
  imap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> '     <Plug>(unite_quick_match_default_action)
  imap <buffer><expr> x
        \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
  nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
  nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
  nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
  nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
  nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
  imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
  nnoremap <silent><buffer><expr> l
        \ unite#smart_map('l', unite#do_action('default'))

  let unite = unite#get_current_unite()
  if unite.profile_name ==# 'search'
    nnoremap <silent><buffer><expr> r     unite#do_action('replace')
  else
    nnoremap <silent><buffer><expr> r     unite#do_action('rename')
  endif

  nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
  nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
        \ empty(unite#mappings#get_current_filters()) ?
        \ ['sorter_reverse'] : [])

  " Runs "split" action by <C-s>.
  imap <silent><buffer><expr> <C-s>     unite#do_action('split')
endfunction
"}}}
"}}}

let s:bundle = neobundle#get('unite.vim')
function! s:bundle.hooks.on_source(bundle)
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  let g:unite_source_history_yank_enable = 1
endfunction
unlet s:bundle

"}}}

" Vimfiler  "{{{
" https://github.com/Shougo/vimfiler.vim

NeoBundleLazy 'Shougo/vimfiler', {
      \ 'depends' : ['Shougo/unite.vim'],
      \ 'autoload' : {
      \   'commands' : ['VimFiler']
      \ }
      \}

noremap <Space>vf :VimFiler <CR>

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

NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'vim-scripts/vim-auto-save'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'tpope/vim-fugitive'

" open-browser  "{{{
" https://github.com/tyru/open-browser.vim/blob/master/doc/openbrowser.txt

NeoBundleLazy 'tyru/open-browser.vim', {
      \ 'autoload' : {
      \   'mappings' : ['<Plug>(openbrowser-smart-search)', '<Plug>(openbrowser-search)']
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

NeoBundle 'kannokanno/previm'

" vim-choosewin  "{{{
" https://github.com/t9md/vim-choosewin

NeoBundleLazy 't9md/vim-choosewin', {
      \ 'autoload' : {
      \   'commands' : '<Plug>(choosewin)'
      \ }}

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

NeoBundle 't9md/vim-choosewin'

" switch.vim  "{{{
" https://github.com/AndrewRadev/switch.vim
" http://deris.hatenablog.jp/entry/2013/12/15/235606

NeoBundleLazy 'AndrewRadev/switch.vim', {
      \ 'autoload' : {
      \   'mappings' : '<C-u>Switch<CR>' 
      \ }
      \}

nnoremap <Space>c :<C-u>Switch<CR>
let s:bundle = neobundle#get('switch.vim')
function! s:bundle.hooks.on_source(bundle)
  let g:switch_custom_definitions =
      \ [
      \   ['left', 'right'],
      \   ['top', 'bottom'],
      \   ['yes', 'no'],
      \   ['jpg', 'png', 'gif'],
      \   ['off', 'off'],
      \ ]
endfunction
unlet s:bundle

"}}}

NeoBundle 'thinca/vim-quickrun'

" calender.vim  "{{{
" https://github.com/itchyny/calendar.vim

NeoBundleLazy 'itchyny/calendar.vim', {
      \ 'autoload' : {
      \   'commands' : 'Calendar'
      \ }
      \}

let s:bundle = neobundle#get('calendar.vim')
function! s:bundle.hooks.on_source(bundle)
  let g:calendar_google_calendar = 1
  let g:calendar_google_task = 1
endfunction
unlet s:bundle
"}}}

NeoBundle 'koron/codic-vim'
NeoBundle 'rhysd/unite-codic.vim'
NeoBundle 'kmnk/vim-unite-giti'

filetype plugin indent on
NeoBundleCheck

"}}}

" source "{{{
source $VIMRUNTIME/macros/matchit.vim
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
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" insert breack
nnoremap br Ea<br /><ESC>J
nnoremap ibr Ea<CR><ESC>

" CSS comment
noremap ct I/* <Esc>50a=<Esc>o<CR><Esc>a <Esc>50a=<Esc>a */<Esc>ka 
noremap <Space>cs I/*<CR><Esc>a <Esc>50a=<Esc>a */<Esc>ka 
noremap cc I/**<CR>/<Esc>O 

" Sass
nnoremap <Space>e A<CR>@extend %

" F5でファイルを Chrome で開く
nnoremap <F5> :!open -a Google\ Chrome %<CR><CR>
" watchmedo shell-command -c "osascript ~/bin/creload.scpt" ~/blog/

" タブ
nnoremap <silent> tc :tablast <bar> tabnew<CR> " tc 新しいタブを一番右に作る
nnoremap <silent> tx :tabclose<CR> " tx タブを閉じる

" Insert Mode
inoremap <C-e> <Esc>$a
inoremap <C-a> <Esc>^i
inoremap <C-w> <Esc>Wi
inoremap <C-b> <Esc>Bi

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

" 引用符, 括弧の設定
" inoremap { {}<Left>
" inoremap [ []<Left>
" inoremap ( ()<Left>
" inoremap " ""<Left>
" inoremap ' ''<Left>
" inoremap <> <><Left>

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

" syntax highlighting"{{{
au BufNewFile,BufRead *.emblem set filetype=slim
"}}}

" Color Scheme {{{

" カラー端末の場合のみ構文強調を有効
if &t_Co > 1
   syntax enable
endif

set t_Co=256

" Solarized
set background=light
" let g:solarized_termcolors=256
" let g:solarized_degrade=0
" let g:solarized_bold=0
" let g:solarized_underline=1
" let g:solarized_italic=1
" let g:solarized_termtrans=0
 let g:solarized_contrast="high"
 let g:solarized_visibility="high"
colorscheme solarized
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

"}}}

" ステータスバー "{{{
" ステータス行を表示
set laststatus=2

" http://d.hatena.ne.jp/itchyny/20130828/1377653592
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
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
        \ }

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

" taglist "{{{
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
" }}}

" YankRing.vim "{{{
" , y でヤンク履歴
" YankRing.vim
" http://nanasi.jp/articles/vim/yankring_vim.html
" https://github.com/yuroyoro/dotfiles/blob/master/.vimrc.plugins_setting
" https://github.com/yuroyoro/dotfiles/blob/master/.vimrc.plugins_setting
" nnoremap ,y :YRShow<CR>
""}}}

" yankround {{{
" <Leader>g<C-p> で実行
nmap p <Plug>(yankround-p) 
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 50
nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>
" }}}

" neocomplete "{{{
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g]] >     neocomplete#undo_completion()
inoremap <expr><C-l]] >     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent]] > <CR]] > <C-r>=<SID]] > my_cr_function()<CR]] >
function! s:my_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB]] >   pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h]] > neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS]] > neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y]] >   neocomplete#close_popup()
inoremap <expr><C-e]] >   neocomplete#cancel_popup()
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

" neosnippet "{{{
 " Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
"}}}

" vim-auto-save"{{{

" let g:auto_save = 1  " enable AutoSave on Vim startup
"}}}

" vim-easy-script"{{{

vnoremap <silent> <Enter> :EasyAlign<Enter>"}}}

" vim-over"{{{

nnoremap <silent><Leader>m :OverCommandLine<CR>%s/
"}}}

" previm"{{{
" https://github.com/kannokanno/previm/blob/master/doc/previm.jax
"
" http://mba-hack.blogspot.jp/2013/11/vimmarkdown.html
" <F6>でプレビュー
nnoremap <silent> <F6> :PrevimOpen<CR>
"}}}

" unite-codic-vim"{{{
nnoremap <silent> [unite]co :Unite codic<CR>
"}}}

" vim-unite-giti"{{{
nnoremap <silent>gl :Unite giti/log -no-start-insert -horizontal<CR>
nnoremap <silent>gs :Unite giti/status -no-start-insert -horizontal<CR>
"}}}

" vim-easy-align"{{{
" https://github.com/junegunn/vim-easy-align

vmap <Enter> <Plug>(EasyAlign)
"}}}

" quickrun"{{{
let g:quickrun_config = {
\ 'html': {
\  "type": "html/slim"
\ },
\ 'html/slim': {
\   "command": "html2slim"
\ },
\}"}}}
