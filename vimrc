execute pathogen#infect()
syntax on
filetype plugin indent on
set background=dark
colorscheme solarized
let g:solarized_hitrail=1

set vb
set nocp
set hidden
set expandtab
set autoindent
set nocompatible
set noswapfile
set showmatch
set incsearch
set hlsearch
set tabstop=2
set shiftwidth=2
set softtabstop=2
set clipboard=unnamed
set textwidth=0 wrapmargin=0
set history=10000
set t_Co=256
set gfn=Monaco:h14 " Set the font
set laststatus=2 " In order for airline to show with NerdTree, need to set the laststatus=2
set mouse=ar mousemodel=extend
set exrc
set secure
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set splitright
set splitbelow

" autocomplete
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" vim-ruby / vim-rails
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" treat all .md files as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Toggle paste mode with Alt-p
nnoremap π :set invpaste paste?<CR>
set pastetoggle=π

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" F3 will AutoFormat Settings
noremap <F3> :Autoformat<CR>

" F5 will remove all trailing spaces
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" F6 will toggle syntastic
silent! nnoremap <F6> :SyntasticToggleMode<CR>

" Shift+Direction selects text
if has("gui_macvim")
  let macvim_hig_shift_movement = 1
endif

" Tab/Shift Tab in Visual mode
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Tab between splits
nmap <Tab> <c-w><c-w>
nmap <s-Tab> <c-w><s-w>
imap <c-Tab> <Esc>:tabnext<Cr>
imap <c-S-Tab> <Esc>:tabprev<Cr>
nmap <c-Tab> :tabnext<Cr>
nmap <c-S-Tab> :tabprev<Cr>


map <C-b> :buffers<CR>:buffer<Space>
map <C-v> :TagbarToggle<CR>

" always do a global tag jump
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>

map <C-n> :NERDTreeMirrorToggle<CR>
map <C-f> :NERDTreeFind<CR>

map <C-\> :ConqueTermSplit

map <C-_> <plug>NERDCommenterToggle<CR>

" Mappings for multi-cursor
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-o>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

" Ignore warnings of Global CursorHoldI
let g:ConqueTerm_StartMessages = 0

" The Silver Searcher - brew install the_silver_searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let mapleader = "," " Set my leader key to be a comma

" Alternate between test files and paired code files
nnoremap <leader>. :OpenAlternate<cr>

" Map all the run test calls provided by vim-test-recall
map <leader>t :call RunAllTestsInCurrentTestFile()<cr>
map <leader>s :call RunNearestTest()<cr>
map <leader>a :call RunAllRSpecTests()<cr>
map <leader>c :call RunAllCucumberFeatures()<cr>

" Base64 Decode Selection
vnoremap <leader>64 y:echo system('base64 --decode', @")<cr>

" Screen settings
let g:ScreenImpl = 'Tmux'
let g:ScreenShellTmuxInitArgs = '-2'
let g:ScreenShellHeight = 10

" NERDTree settings
let g:nerdtree_tabs_focus_on_files=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Git settings
nnoremap <leader>g  :Git<Space>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gl :Glog<Space>
nnoremap <leader>gg :Gitv<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gn :cnext<CR>
nnoremap <Leader>gp :cprev<CR>

" Run a given vim command on the results of alt from a given path.
" See usage below.
" requires alt.
" brew tap "codebreakdown/homebrew-oss"
" brew install codebreakdown/oss/alt
function! AltCommand(path, vim_command)
  let l:alternate = system("alt " . a:path)
  if empty(l:alternate)
    echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction

" Find the alternate file for the current path and open it
nnoremap <leader>. :w<cr>:call AltCommand(expand('%'), ':e')<cr>

" Custom Global Find
function! GlobalFind()
  let word = inputdialog('Search: ', expand('<cword>'), '')
  if word != ''
    exec ':Ag --ignore-dir=log --ignore-dir=generated ' . word
  endif
endfunction
map <leader>f :call GlobalFind()<CR>

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

" Run tests in a shell - two alternatives being used
function MyConqueTermSplit(command)
  if exists("g:conque_window")
    execute 'bunload ' . g:conque_window.buffer_name
  end
  let g:conque_window = conque_term#open(a:command, ['below split', 'resize 10'], 0)
endfunction

" Run tests in ConqueTermSplit
let g:vim_test_recall_cucumber_command = 'call MyConqueTermSplit("cucumber {feature}")'
let g:vim_test_recall_rspec_command = 'call MyConqueTermSplit("rspec {spec}")'
let g:vim_test_recall_crystal_command = 'call MyConqueTermSplit("crystal spec {spec}")'
let g:vim_test_recall_javascript_command = 'call MyConqueTermSplit("jasmine {spec}")'

function MyScreenShellSplit(command)
 :ScreenShell
 call g:ScreenShellSend(a:command)
endfunction

" Run tests in Screen Shell
"let g:vim_test_recall_cucumber_command = 'call MyScreenShellSplit("be cucumber {feature}")'
"let g:vim_test_recall_rspec_command = 'call MyScreenShellSplit("be rspec {spec}")'
"let g:vim_test_recall_crystal_command = 'call MyScreenShellSplit("crystal spec {spec}")'

let g:ScreenShellTmuxInitArgs = 'new-session -c "$PWD"'


