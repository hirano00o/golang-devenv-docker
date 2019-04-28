set term=term-256color              " 256色で表示する
set encoding=utf-8                  " エンコーディングをUTF-8にする
set fileencodings=utf-8,sjis,cp932  " 設定の順番の文字コードでファイルを開く
set fileformats=unix,dos,mac        " 設定の順番で改行コードを開く
set nofixendofline                  " EOFを元のファイルと同じ状態にする

set ambiwidth=double                " ○文字や□文字でもカーソル位置を保持する
set nobackup                        " バックアップファイルは作成しない
set noswapfile                      " スワップファイルは作成しない
set autoread                        " 編集中のファイルが変更された場合、自動で読み直し
" set hidden                          " 未保存のファイルがあっても、別ファイルを開く
set showcmd                         " 入力コマンドをステータスに表示する
set cursorline                      " 現行を強調表示する
set cursorcolumn                    " 現列を強調表示する

if !has('gui_running')              " CUI使用時
  set mouse=                        " マウス操作をOFFにする
  set ttimeoutlen=0                 " insertからnormalに戻るときの遅延を解消する
  set t_Co=256
endif

set autoindent                      " 改行時に前行のインデントを保持する
set smartindent                     " 改行時に前行末尾に合わせて、インデントを増減する
set tabstop=4                       " タブは設定文字数分で表示する
set shiftwidth=4                    " 自動インデントは4文字
set expandtab                       " タブを空白文字にする
set showmatch                       " 対応する括弧を強調表示する

set wildmenu                        " TABでファイル名を補完する
set wildmode=full                   " TABを押すごとに次のファイル名を補完する
set ignorecase                      " 検索に大文字小文字を区別しない
set smartcase                       " 検索に大文字を使うと、大文字小文字を区別する
set incsearch                       " リアルタイム検索する
set wrapscan                        " 最後まで検索すると、最初に戻る
set hlsearch                        " 検索結果をハイライト表示する

set nowrap                          " テキストの折返しをしない
set ruler                           " ルーラーを表示する
" カラムラインを120列目に引く
let &colorcolumn=join(range(121,999),",")
hi ColorColumn ctermbg=235 guibg=#2c2d27
" Esc2回でハイライトを消す
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" Hで行頭へ移動する
map H ^
" Lで行末へ移動する
map L $

" undoを保存する
if has('persistent_undo')
    set undodir=~/.vim/undo
    set undofile
endif

" grepした結果をquickfixに表示する
augroup grepwindow
    autocmd!
    au QuickFixCmdPost *grep* cwindow
augroup END

if filereadable($HOME.'/.vim/autoload/plug.vim')  " vim-plugを利用する
  " curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  "     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  " :PlugInstallでインストール
  call plug#begin()
    Plug 'fatih/vim-go'                         " goの機能拡張
    Plug 'SirVer/ultisnips'                     " スニペット
    " goのスニペット -> https://github.com/fatih/vim-go/blob/master/gosnippets/UltiSnips/go.snippets
    Plug 'bronson/vim-trailing-whitespace'      " 行末のスペースをハイライト
    Plug 'Yggdroot/indentLine'                  " インデントを見やすくする
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }   " あいまい検索
    Plug 'junegunn/fzf.vim'
    Plug 'cohama/lexima.vim'                    " 括弧の補完
    Plug 'itchyny/lightline.vim'                " ステータスライン拡張
    Plug 'morhetz/gruvbox'                      " カラースキーム
  call plug#end()
endif

syntax enable                       " シンタックスをONにする
set background=dark                 " 背景をダークモードにする
if filereadable($HOME.'/.vim/plugged/gruvbox/autoload/gruvbox.vim')
    colorscheme gruvbox
endif

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste'  ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified'  ] ]
      \ },
      \ 'component_function': {
      \   'linetotal': 'LightLineTotal',
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
let g:lightline.component = {
    \ 'lineinfo': '[%3l/%3L]:%-2v'
    \ }
set noshowmode                      " vimのモードを非表示にする
set laststatus=2                    " ステータスラインを常に表示する
set cmdheight=2                     " ステータスライン下のメッセージ表示行数

" ペースト時に自動インデントを無効化する
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"
    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" vim-go設定
let mapleader = "\<Space>"            " <leader>を<Space>にする
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <leader>s <Plug>(go-def-split)
au FileType go nmap <leader>v <Plug>(go-def-vertical)

au FileType go :highlight goErr cterm=bold ctermfg=214
au FileType go :match goErr /\<err\>/

" ハイライト表示
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_metalinter_autosave = 1    " 保存時にvet, lint errcheckを実行する
let g:go_fmt_autosave = 1           " 保存時にfmtを実行する
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"  " 不要なimportを削除する
let g:go_def_mode = 'gopls'

