call plug#begin()
Plug 'rking/ag.vim'
Plug 'bling/vim-airline'
Plug 'Chiel92/vim-autoformat'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'ddollar/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'kien/rainbow_parentheses.vim'
Plug 'github/copilot.vim'
Plug 'tpope/vim-fugitive'
Plug 'drujensen/vim-test-recall'

Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'xavierchow/vim-sequence-diagram'

" languages
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'keith/swift.vim'
Plug 'rhysd/vim-crystal'
Plug 'mxw/vim-jsx'
call plug#end()

syntax on
filetype plugin indent on

set background=dark
colorscheme solarized
let g:solarized_hitrail=1
set gfn=Monaco:h14
set history=10000

set vb
set nocp
set hidden
set expandtab
set autoindent
set nocompatible
set noswapfile
set showmatch
set incsearch
set number
set hlsearch
set tabstop=2
set shiftwidth=2
set softtabstop=2
set clipboard=unnamed
set textwidth=0 wrapmargin=0
set laststatus=2 " In order for airline to show with NerdTree, need to set the laststatus=2
set mouse=ar mousemodel=extend
set exrc
set secure
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set splitright
set splitbelow
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c

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
"if has("gui_macvim")
"  let macvim_hig_shift_movement = 1
"endif

" Tab/Shift Tab in Visual mode to indent text
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Tab between splits
nmap <Tab> <c-w><c-w>
nmap <s-Tab> <c-w><s-w>

map <C-b> :buffers<CR>:buffer<Space>
map <C-v> :TagbarToggle<CR>

" Mappings for multi-cursor
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-o>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

map <C-n> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>
map <C-_> <plug>NERDCommenterToggle<CR>
map <C-\> :term<Space>bash<CR>

" Autoformat crystal files on save
let g:crystal_auto_format=1

" AutoFormat rust files on save
let g:rustfmt_autosave = 1

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

" The Silver Searcher - brew install the_silver_searcher
" Use ag over grep
set grepprg=ag\ --nogroup\ --nocolor

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0
let g:ag_working_path_mode="r"

let mapleader = "," " Set my leader key to be a comma

" Map all the run test calls provided by vim-test-recall
map <leader>t :call RunAllTestsInCurrentTestFile()<cr>
map <leader>s :call RunNearestTest()<cr>
map <leader>a :call RunAllRSpecTests()<cr>
map <leader>c :call RunAllCucumberFeatures()<cr>

" Base64 Decode Selection
noremap <leader>d6 :% !base64 -d <cr>
noremap <leader>b6 :% !base64 <cr>

let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_github=1
nmap <leader>m <Plug>GenerateDiagram

" NERDTree settings
let g:nerdtree_tabs_focus_on_files=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Git settings
nnoremap <leader>g  :Git<Space>
nnoremap <leader>ga :Git add %<CR>
nnoremap <leader>gr :Git restore --staged %<CR>
nnoremap <leader>gc :Git commit -v -q<CR>
nnoremap <leader>gd :Git diff<CR>
nnoremap <leader>gp :Git pull<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>gv :Git lg<CR>
nnoremap <Leader>gn :cnext<CR>
nnoremap <Leader>gp :cprev<CR>

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

" Run tests in ConqueTermSplit
let g:vim_test_recall_cucumber_command = 'execute("term cucumber {feature}")'
let g:vim_test_recall_rspec_command = 'execute("term rspec {spec}")'
let g:vim_test_recall_crystal_command = 'execute("term crystal spec {spec}")'
let g:vim_test_recall_javascript_command = 'execute("term npm test --cf {spec}")'

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
