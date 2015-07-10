execute pathogen#infect()
syntax on

set vb
set nocp
set hidden
set expandtab
set autoindent
set nocompatible

set mouse=a
set tabstop=2
set shiftwidth=2
set softtabstop=2
set clipboard=unnamed
set textwidth=78
set history=10000


" Do not clear the screen when exiting or executing a command
" set t_ti= t_te=

" In order for airline to show with NerdTree, need to set the laststatus=2
set laststatus=2

" Set color scheme
colorscheme SlateDark

" Set the font
set gfn=Monaco:h14

" NerdCommentor
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

" treat all .md files as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Show matching bracket when a bracket is inserted
set showmatch

" Show matching pattern as typing search pattern 
set incsearch

" Highlight searches matching the search pattern
set hlsearch

" Toggle paste mode with Alt-p
nnoremap π :set invpaste paste?<CR>
set pastetoggle=π


" Shift+Direction selects text
nmap <S-Up> V
nmap <S-Down> V
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
imap <S-Up> <Esc>V
imap <S-Down> <Esc>V
imap <S-Left> <Esc>lv<Left>
imap <S-Right> <Esc>lv<Right>

" Set my leader key to be a comma
let mapleader = ","

" Easily switch between buffers
map <leader>b :buffers<CR>:buffer<Space>
nnoremap <silent> <Leader>z :TagbarToggle<CR>

" Alternate between test files and paired code files
nnoremap <leader>. :OpenAlternate<cr>

" Map all the run test calls provided by vim-test-recall
map <leader>t :call RunAllTestsInCurrentTestFile()<cr>
map <leader>s :call RunNearestTest()<cr>
map <leader>a :call RunAllRSpecTests()<cr>
map <leader>c :call RunAllCucumberFeatures()<cr>
map <leader>w :call RunWipCucumberFeatures()<cr>

function! GlobalFind()
  let word = inputdialog('Search: ', expand('<cword>'), '')
  if word != ''
    exec ':Ack ' . word 
  endif
endfunction
map <leader>g :call GlobalFind()<CR>

function! SearchAndReplace()
  let search = inputdialog('Search: ', expand('<cword>'), '')
  if search != ''
    let replace = inputdialog('Replace: ', '', '')
    if replace != ''
      exec ':%s/' . search . '/' . replace . '/gc'
    endif
  endif
endfunction
map <leader>r :call SearchAndReplace()<CR>

" NERDTree
map <leader>n :NERDTreeMirrorToggle<CR>
map <leader>f :NERDTreeFind<CR>

" Keep focus on files
let g:nerdtree_tabs_focus_on_files=1

" quit NERDTree if all buffers are quit
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

function MyConqueTermSplit(command)
  if exists("g:conque_window")
    execute 'bunload ' . g:conque_window.buffer_name 
  end
  let g:conque_window = conque_term#open(a:command, ['below split', 'resize 10'], 0)
endfunction

let g:vim_test_recall_cucumber_command = 'call MyConqueTermSplit("zeus cucumber {feature}")'
let g:vim_test_recall_rspec_command = 'call MyConqueTermSplit("zeus rspec {spec}")'

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

