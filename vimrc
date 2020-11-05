execute pathogen#infect()
syntax on
filetype plugin indent on

set background=dark
colorscheme solarized
let g:solarized_hitrail=1
set gfn=Monaco:h14

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
set history=10000
set t_Co=256
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

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


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
" imap <c-Tab> <Esc>:tabnext<Cr>
" imap <c-S-Tab> <Esc>:tabprev<Cr>
" nmap <c-Tab> :tabnext<Cr>
" nmap <c-S-Tab> :tabprev<Cr>


map <C-b> :buffers<CR>:buffer<Space>
map <C-v> :TagbarToggle<CR>

" always do a global tag jump
" nnoremap <c-]> g<c-]>
" vnoremap <c-]> g<c-]>

map <C-n> :NERDTreeMirrorToggle<CR>
map <C-f> :NERDTreeFind<CR>

map <C-\> :term<Space>bash<CR>

map <C-_> <plug>NERDCommenterToggle<CR>

" Mappings for multi-cursor
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-o>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Autoformat crystal files on save
let g:crystal_auto_format=1

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

" Alternate between test files and paired code files
" nnoremap <leader>. :OpenAlternate<cr>

" Map all the run test calls provided by vim-test-recall
map <leader>t :call RunAllTestsInCurrentTestFile()<cr>
map <leader>s :call RunNearestTest()<cr>
map <leader>a :call RunAllRSpecTests()<cr>
map <leader>c :call RunAllCucumberFeatures()<cr>

" Base64 Decode Selection
noremap <leader>64 y:echo system('base64 --decode', @%)<cr>

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

let g:ScreenShellTmuxInitArgs = 'new-session -c "$PWD"'

call pathogen#helptags()

" COC's auto complete
call plug#begin()
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
call plug#end()

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
" nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
" nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
" inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
