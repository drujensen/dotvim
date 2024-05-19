call plug#begin()
" colors
Plug 'altercation/vim-colors-solarized'

" features
Plug 'rking/ag.vim'
Plug 'bling/vim-airline'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ddollar/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-fugitive'
Plug 'drujensen/vim-test-recall'
Plug 'github/copilot.vim'
Plug 'madox2/vim-ai'
Plug 'nicwest/vim-http'

" languages
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
Plug 'keith/swift.vim'
Plug 'rhysd/vim-crystal'
call plug#end()

filetype plugin indent on

syntax on
set background=dark
colorscheme solarized
set gfn=Monaco:h14

" fix for vim-gitgutter and solarized
highlight! link SignColumn LineNr
autocmd ColorScheme * highlight! link SignColumn LineNr

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
set clipboard=unnamedplus
set textwidth=0 wrapmargin=0
set history=10000
set laststatus=2 " In order for airline to show with NerdTree, need to set the laststatus=2
set mouse=ar mousemodel=extend
set exrc
set secure
set splitright
set splitbelow
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set tags=.git/tags,tags;

" vim-ruby / vim-rails
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" treat all .md files as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" treat ejs as html
autocmd BufNewFile,BufReadPost *.ejs set filetype=html

" c# indenting to 4 spaces
autocmd FileType cs setlocal shiftwidth=4 tabstop=4

"" Autoformat crystal files on save
let g:crystal_auto_format=1

" AutoFormat rust files on save
let g:rustfmt_autosave = 1

" enable copilot for all files
let g:copilot_filetypes = { '*': v:true, }

" Toggle paste mode with Alt-p
nnoremap π :set invpaste paste?<CR>
set pastetoggle=π

"Paste in visual mode without copying
xnoremap p pgvy

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Tab/Shift Tab in Visual mode to indent text
vnoremap <Tab> >gv
vnoremap <s-Tab> <gv

" Tab between splits
nmap <Tab> <c-w><c-w>
nmap <s-Tab> <c-w><s-w>

map <C-a> <esc>ggVG<CR>
map <C-b>  :buffers<CR>:buffer<Space>
map <C-l>  :TagbarToggle<CR>
map <C-n>  :NERDTreeToggle<CR>
map <C-f>  :NERDTreeFind<CR>
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
map <C-\>  <Esc>:sp<Space>\|<Space>term<Space>bash<CR>

" vim-airline settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Rainbow Parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax *  RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" The Silver Searcher - brew install the_silver_searcher
" Use ag over grep
set grepprg=ag\ --nogroup\ --nocolor

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0
let g:ag_working_path_mode="r"

" Binary Editor
augroup Binary
  au!
  au BufReadPre  *.bin,*.out let &bin=1
  au BufReadPost *.bin,*.out if &bin | %!xxd
  au BufReadPost *.bin,*.out set ft=xxd | endif
  au BufWritePre *.bin,*.out if &bin | %!xxd -r
  au BufWritePre *.bin,*.out endif
  au BufWritePost *.bin,*.out if &bin | %!xxd
  au BufWritePost *.bin,*.out set nomod | endif
augroup END

" NERDTree settings
let g:nerdtree_tabs_focus_on_files=1
let NERDTreeIgnore = ['\obj$', '\bin$']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


let mapleader = "," " Set my leader key to be a comma

" Map all the run test calls provided by vim-test-recall
map <leader>t :call RunCurrentTests()<cr>
map <leader>s :call RunNearestTest()<cr>

let g:vim_test_recall_py = 'execute("sp | term pytest {spec}")'
let g:vim_test_recall_rb = 'execute("sp | term rspec {spec}")'
let g:vim_test_recall_js = 'execute("sp | term yarn run test {spec}")'
let g:vim_test_recall_cr = 'execute("sp | term crystal spec {spec}")'
let g:vim_test_recall_go = 'execute("sp | term go test {spec}")'
let g:vim_test_recall_rs = 'execute("sp | term cargo test {spec}")'
let g:vim_test_recall_clj = 'execute("sp | term lein test {spec}")'
let g:vim_test_recall_sw = 'execute("sp | term swift test")'
let g:vim_test_recall_ja = 'execute("sp | term gradle test")'
let g:vim_test_recall_kt = 'execute("sp | term gradle test")'
let g:vim_test_recall_cs = 'execute("sp | term dotnet test")'

" AI Chat mapping

let g:vim_ai_chat = {
\  "options": {
\    "model": "gpt-4-1106-preview",
\    "temperature": 0.2,
\  },
\}

noremap <leader>a :AIChat
noremap <leader>c :AIChat<cr>

" Base64 Decode Selection
noremap <leader>d6 :% !base64 -d <cr>
noremap <leader>b6 :% !base64 <cr>

" Git settings
nnoremap <leader>g  :Git<Space>
nnoremap <leader>ga :Git add %<CR>
nnoremap <leader>gr :Git checkout -- %<CR>
nnoremap <leader>gc :Git commit -v -q<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gd :Git diff %<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>gg :Git log<CR>
nnoremap <leader>gl :Git lg<CR>
nnoremap <leader>gs :Git ls<CR>

" Custom Global Find
function! GlobalFind()
  let word = inputdialog('Search: ', expand('<cword>'), '')
  if word != ''
    exec ':Ag ' . word . ' --ignore obj --ignore bin'
  endif
endfunction
map <leader>f :call GlobalFind()<CR>

function! SearchAndReplace()
  let search = inputdialog('Search: ', expand('<cword>'), '')
  if search != ''
    let replace = inputdialog('Replace: ', '', '')
    if replace != ''
      if &buftype ==# 'quickfix'
        exec 'cdo %s/' . search . '/' . replace . '/gc | cwindow'
      else
        exec ':%s/' . search . '/' . replace . '/gc'
      endif
    endif
  endif
endfunction
map <leader>r :call SearchAndReplace()<CR>

" F5 will remove all trailing spaces
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
