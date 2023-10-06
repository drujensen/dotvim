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
" Plug 'Chiel92/vim-autoformat'
" Plug 'scrooloose/syntastic'

" languages
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
Plug 'keith/swift.vim'
Plug 'rhysd/vim-crystal'

" LSP Support
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}
Plug 'neovim/nvim-lspconfig'             " Required
Plug 'williamboman/mason.nvim'           " Optional
Plug 'williamboman/mason-lspconfig.nvim' " Optional

" Autocompletion
Plug 'hrsh7th/nvim-cmp'         " Required
Plug 'hrsh7th/cmp-nvim-lsp'     " Required
Plug 'L3MON4D3/LuaSnip'         " Required

call plug#end()

filetype plugin indent on

syntax on
set background=dark
colorscheme solarized
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
set clipboard=unnamedplus
set textwidth=0 wrapmargin=0
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

map <C-l>  :TagbarToggle<CR>
map <C-b>  :buffers<CR>:buffer<Space>
map <C-n>  :NERDTreeToggle<CR>
map <C-f>  :NERDTreeFind<CR>
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
map <C-\>  <Esc>:sp<Space>\|<Space>term<Space>bash<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Syntastic Settings
" silent! nnoremap <F6> :SyntasticToggleMode<CR>

" Disable Java
" let g:loaded_syntastic_java_javac_checker = 1

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1

"  let g:syntastic_error_symbol = '❌'
"  let g:syntastic_style_error_symbol = '⁉️'
"  let g:syntastic_warning_symbol = '⚠️'
"  let g:syntastic_style_warning_symbol = '💩'

" highlight link SyntasticErrorSign SignColumn
" highlight link SyntasticWarningSign SignColumn
" highlight link SyntasticStyleErrorSign SignColumn
" highlight link SyntasticStyleWarningSign SignColumn
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_ruby_checkers = ['mri', 'rubocop']
" let g:syntastic_python_checkers=['flake8', 'python3']

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
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


let mapleader = "," " Set my leader key to be a comma

" Map all the run test calls provided by vim-test-recall
map <leader>t :call RunCurrentTests()<cr>
map <leader>s :call RunNearestTest()<cr>

let g:vim_test_recall_py = 'execute("sp | term pytest {spec}")'
let g:vim_test_recall_rb = 'execute("sp | term rspec {spec}")'
let g:vim_test_recall_js = 'execute("sp | term npm test --cf {spec}")'
let g:vim_test_recall_cr = 'execute("sp | term crystal spec {spec}")'
let g:vim_test_recall_go = 'execute("sp | term go test {spec}")'
let g:vim_test_recall_rs = 'execute("sp | term cargo test {spec}")'
let g:vim_test_recall_clj = 'execute("sp | term lein test {spec}")'
let g:vim_test_recall_sw = 'execute("sp | term swift test")'
let g:vim_test_recall_ja = 'execute("sp | term gradle test")'
let g:vim_test_recall_kt = 'execute("sp | term gradle test")'

" AI Chat mapping

let g:vim_ai_chat = {
\  "options": {
\    "model": "gpt-4",
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

" F5 will remove all trailing spaces
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

function! ToggleDiagnostics()
    if exists("b:diagnostics_enabled")
        if b:diagnostics_enabled
            lua vim.diagnostic.disable()
            let b:diagnostics_enabled = 0
        else
            lua vim.diagnostic.enable()
            let b:diagnostics_enabled = 1
        endif
    else
        lua vim.diagnostic.disable()
        let b:diagnostics_enabled = 0
    endif
endfunction

" F6 will toggle diagnostics
nnoremap <F6> :call ToggleDiagnostics()<CR>

" Setup LSP
lua <<EOF
  local lsp_zero = require('lsp-zero').preset({})

  lsp_zero.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
  })

  lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    lsp_zero.default_keymaps({buffer = bufnr})
  end)

  require('mason').setup({})
  require('mason-lspconfig').setup({
    ensure_installed = {
      'clangd', 'rust_analyzer', 'gopls',
      'jdtls', 'gradle_ls','clojure_lsp',
      'eslint', 'tsserver', 'pylsp', 'ruby_ls', 'rubocop',
      'yamlls', 'jsonls', 'taplo', 'cssls', 'html', 'sqlls',
      'dockerls', 'terraformls', 'vimls', 'bashls',
    },
    handlers = {
      lsp_zero.default_setup,
    }
  })

  local cmp = require('cmp')
  local cmp_format = lsp_zero.cmp_format()

  cmp.setup({
    formatting = cmp_format,
    mapping = cmp.mapping.preset.insert({
      -- scroll up and down the documentation window
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
    }),
  })
EOF
