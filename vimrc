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

" In order for airline to show with NerdTree, need to set the laststatus=2
set laststatus=2

filetype plugin indent on
colorscheme SlateDark

" Set the font
set gfn=Monaco:h14

" Auto Complete
" set omnifunc=syntaxcomplete#Complete

" treat all .md files as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

set showmatch
set incsearch
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

" Toggle Buffers
map <C-b> :buffers<CR>:buffer<Space>

" Toggle Tag Bar
map <C-m> :TagbarToggle<CR>

" Alternate between test files and paired code files
nnoremap <leader>. :OpenAlternate<cr>

" Map all the run test calls provided by vim-test-recall
map <leader>t :call RunAllTestsInCurrentTestFile()<cr>
map <leader>s :call RunNearestTest()<cr>
map <leader>a :call RunAllRSpecTests()<cr>
map <leader>c :call RunAllCucumberFeatures()<cr>

" Screen settings
let g:ScreenImpl = 'Tmux'
let g:ScreenShellTmuxInitArgs = '-2'
let g:ScreenShellHeight = 10


nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>

" Custom Global Find
function! GlobalFind()
  let word = inputdialog('Search: ', expand('<cword>'), '')
  if word != ''
    exec ':Ack ' . word 
  endif
endfunction
map <leader>f :call GlobalFind()<CR>

" Custom Find and Replace
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
map <C-n> :NERDTreeMirrorToggle<CR>
map <C-f> :NERDTreeFind<CR>

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

" Run tests in ConqueTermSplit
" let g:vim_test_recall_cucumber_command = 'call MyConqueTermSplit("bundle exec cucumber {feature}")'
" let g:vim_test_recall_rspec_command = 'call MyConqueTermSplit("bundle exec rspec {spec}")'

function MyScreenShellSplit(command)
 :ScreenShell
 call g:ScreenShellSend(a:command)
endfunction

" Run tests in Screen Shell
let g:vim_test_recall_cucumber_command = 'call MyScreenShellSplit("bundle exec cucumber {feature}")'
let g:vim_test_recall_rspec_command = 'call MyScreenShellSplit("bundle exec rspec {spec}")'


