local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  'overcache/NeoSolarized',
  'folke/tokyonight.nvim',
  'catppuccin/nvim',
  'morhetz/gruvbox',

  'rking/ag.vim',
  'bling/vim-airline',
  'kien/ctrlp.vim',
  'scrooloose/nerdtree',
  'Xuyuanp/nerdtree-git-plugin',
  'ddollar/nerdcommenter',
  'airblade/vim-gitgutter',
  'majutsushi/tagbar',
  'kien/rainbow_parentheses.vim',
  'tpope/vim-fugitive',
  'drujensen/vim-test-recall',
  'github/copilot.vim',
  'madox2/vim-ai',
  'nicwest/vim-http',
  'vim-ruby/vim-ruby',
  'pangloss/vim-javascript',
  'rust-lang/rust.vim',
  'fatih/vim-go',
  'keith/swift.vim',
  'czheo/mojo.vim',
  'rhysd/vim-crystal',

  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'L3MON4D3/LuaSnip',
  'VonHeikemen/lsp-zero.nvim',

  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
})

local function is_plugins_installed()
  local plugin_path = vim.fn.stdpath("data") .. '/lazy'
  return vim.fn.isdirectory(plugin_path) == 1
end

if is_plugins_installed() then
  vim.o.background = 'dark'
  vim.o.guifont = 'Monaco:h14'

  vim.cmd [[
    filetype plugin indent on
    syntax on
    colorscheme NeoSolarized
    highlight! link SignColumn LineNr
  ]]

  vim.o.vb = true
  vim.o.hidden = true
  vim.o.expandtab = true
  vim.o.autoindent = true
  vim.o.showmatch = true
  vim.o.incsearch = true
  vim.o.hlsearch = true
  vim.o.clipboard = "unnamedplus"
  vim.o.textwidth = 0
  vim.o.wrapmargin = 0
  vim.o.history = 10000
  vim.o.laststatus = 2
  vim.o.mouse = "ar"
  vim.o.mousemodel = "extend"
  vim.o.exrc = true
  vim.o.secure = true
  vim.o.splitright = true
  vim.o.splitbelow = true
  vim.o.cmdheight = 2
  vim.o.updatetime = 300
  vim.o.shortmess = vim.o.shortmess .. "c"
  vim.o.tags = ".git/tags,tags;"

  vim.o.tabstop = 2
  vim.o.shiftwidth = 2
  vim.o.softtabstop = 2

  -- Window-scoped settings
  vim.wo.number = true

  -- Autoformat crystal files on save
  vim.g.crystal_auto_format = 1

  -- AutoFormat rust files on save
  vim.g.rustfmt_autosave = 2

  -- enable copilot for all files
  vim.g.copilot_filetypes = { ['*'] = true }

  vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"ruby", "eruby"},
    callback = function()
      vim.g.rubycomplete_buffer_loading = 1
      vim.g.rubycomplete_classes_in_global = 1
      vim.g.rubycomplete_rails = 1
    end,
  })

  -- c# indenting to 4 spaces
  vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = "cs",
    callback = function()
      vim.bo.shiftwidth = 4
      vim.bo.tabstop = 4
      vim.bo.fileformat = "unix"
    end,
  })

  -- Toggle paste mode with Alt-p
  vim.api.nvim_set_keymap('n', 'π', ':set invpaste paste?<CR>', { noremap = true, silent = true })

  -- Paste in visual mode without copying
  vim.api.nvim_set_keymap('x', 'p', 'pgvy', { noremap = true, silent = true })

  -- This unsets the "last search pattern" register by hitting return
  vim.api.nvim_set_keymap('n', '<CR>', ':noh<CR><CR>', { noremap = true, silent = true })

  -- Tab/Shift Tab in Visual mode to indent text
  vim.api.nvim_set_keymap('v', '<Tab>', '>gv', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', { noremap = true, silent = true })

  -- Tab between splits
  vim.api.nvim_set_keymap('n', '<Tab>', '<C-w><C-w>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<S-Tab>', '<C-w><S-w>', { noremap = true, silent = true })

  -- Custom mappings for various actions
  vim.api.nvim_set_keymap('', '<C-a>', '<esc>ggVG<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('', '<C-b>', ':buffers<CR>:buffer ', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('', '<C-l>', ':TagbarToggle<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('', '<C-f>', ':NERDTreeFind<CR>', { noremap = true, silent = true })

  -- NERDCommenter mappings
  vim.api.nvim_set_keymap('n', '<C-_>', '<Plug>NERDCommenterToggle', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', '<C-_>', '<Plug>NERDCommenterToggle<CR>gv', { noremap = true, silent = true })

  -- Open a terminal in a new split
  local os_name = vim.loop.os_uname().sysname
  local term_cmd = os_name == "Windows_NT" and "pwsh" or "bash"
  vim.api.nvim_set_keymap('', '<C-\\>', '<Esc>:sp | term ' .. term_cmd .. '<CR>', { noremap = true, silent = true })

  -- vim-airline settings
  vim.cmd [[
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
  ]]

  -- Rainbow Parentheses
  vim.cmd [[
    au VimEnter * RainbowParenthesesToggle
    au Syntax *  RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
  ]]

  -- The Silver Searcher - brew install the_silver_searcher
  -- Use ag over grep
  vim.o.grepprg = 'ag --nogroup --nocolor'

  -- Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  vim.g.ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  -- ag is fast enough that CtrlP doesn't need to cache
  vim.g.ctrlp_use_caching = 0
  vim.g.ag_working_path_mode = "r"

  -- NERDTree settings
  vim.g.nerdtree_tabs_focus_on_files = 1
  vim.g.NERDTreeCascadeSingleChildDir = 0

  vim.cmd [[
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  ]]
  -- let g:NERDTreeIgnore = ['\v(obj|bin)$']

  vim.g.mapleader = ","

  -- Map all the run test calls provided by vim-test-recall
  vim.api.nvim_set_keymap('n', '<leader>t', ':call RunCurrentTests()<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>s', ':call RunNearestTest()<CR>', { noremap = true, silent = true })

  -- Test commands for different languages
  vim.g.vim_test_recall_py = 'execute("sp | term pytest {spec}")'
  vim.g.vim_test_recall_rb = 'execute("sp | term rspec {spec}")'
  vim.g.vim_test_recall_js = 'execute("sp | term yarn run test {spec}")'
  vim.g.vim_test_recall_cr = 'execute("sp | term crystal spec {spec}")'
  vim.g.vim_test_recall_go = 'execute("sp | term go test -v")'
  vim.g.vim_test_recall_rs = 'execute("sp | term cargo test {spec}")'
  vim.g.vim_test_recall_clj = 'execute("sp | term lein test {spec}")'
  vim.g.vim_test_recall_sw = 'execute("sp | term swift test")'
  vim.g.vim_test_recall_ja = 'execute("sp | term gradle test")'
  vim.g.vim_test_recall_kt = 'execute("sp | term gradle test")'
  vim.g.vim_test_recall_cs = 'execute("sp | term dotnet test")'


  vim.api.nvim_set_keymap('n', '<leader>a', ':AIChat', { noremap = true })
  vim.api.nvim_set_keymap('n', '<leader>c', ':AIChat<CR>', { noremap = true })
  vim.api.nvim_set_keymap('x', '<leader>a', ':AIChat', { noremap = true })
  vim.api.nvim_set_keymap('x', '<leader>c', ':AIChat<CR>', { noremap = true })

  -- formatting
  vim.api.nvim_set_keymap('n', '<leader>d6', ':% !base64 -d <CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>b6', ':% !base64 <CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>x', ':% !xmllint --format - <CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>j', ':% !jq . <CR>', { noremap = true, silent = true })

  -- Git settings
  vim.api.nvim_set_keymap('n', '<leader>g', ':Git<Space>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ga', ':Git add %<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>gr', ':Git checkout -- %<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit -v -q<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>gp', ':Git push<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>gd', ':Git diff %<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>gs', ':Git status<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>gg', ':Git log<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>gl', ':Git lg<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>gs', ':Git ls<CR>', { noremap = true, silent = true })

  -- GlobalFind function
  function GlobalFind()
    local word = vim.fn.input('Search: ', vim.fn.expand('<cword>'))
    if word ~= '' then
      vim.cmd('Ag ' .. word .. ' --ignore obj --ignore bin')
    end
  end

  -- Mapping for GlobalFind
  vim.api.nvim_set_keymap('n', '<leader>f', ':lua GlobalFind()<CR>', { noremap = true, silent = true })

  -- SearchAndReplace function equivalent in Lua
  function SearchAndReplace()
    local search = vim.fn.input('Search: ', vim.fn.expand('<cword>'))
    if search ~= '' then
      local replace = vim.fn.input('Replace: ', '')
      if replace ~= '' then
        if vim.bo.buftype == 'quickfix' then
          vim.cmd('cdo %s/' .. search .. '/' .. replace .. '/gc | cwindow')
        else
          vim.cmd(':%s/' .. search .. '/' .. replace .. '/gc')
        end
      end
    end
  end

  -- Mapping for SearchAndReplace
  vim.api.nvim_set_keymap('n', '<leader>r', ':lua SearchAndReplace()<CR>', { noremap = true, silent = true })

  -- F5 will remove all trailing spaces
  vim.api.nvim_set_keymap('n', '<F5>', [[<cmd>lua vim.cmd('%s/\\s\\+$//e')<CR>]], { noremap = true, silent = true })

  -- ToggleDiagnostics function equivalent in Lua
  function ToggleDiagnostics()
  if vim.b.diagnostics_enabled == nil or vim.b.diagnostics_enabled == 0 then
    vim.diagnostic.disable()
    vim.b.diagnostics_enabled = 1
  else
    vim.diagnostic.enable()
    vim.b.diagnostics_enabled = 0
  end
  end

  -- F6 will toggle diagnostics
  vim.api.nvim_set_keymap('n', '<F6>', '<cmd>lua ToggleDiagnostics()<CR>', { noremap = true, silent = true })

  -- LSP settings
  local lspconfig = require('lspconfig')
  local lsp_zero = require('lsp-zero')

  -- need to install crystalline manually for arm chip
  lspconfig.crystalline.setup({
    on_attach = lsp_zero.on_attach,
  })

  -- mojo not supported by mason yet
  --
  lspconfig.mojo.setup({
    on_attach = lsp_zero.on_attach,
  })

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
      'rust_analyzer', 'gopls', 'jdtls', 'gradle_ls','clojure_lsp',
      'eslint', 'ts_ls', 'pylsp', 'ruby_lsp', 'rubocop',
      'yamlls', 'jsonls', 'taplo', 'cssls', 'html', 'sqlls',
      'dockerls', 'terraformls', 'vimls', 'bashls', 'omnisharp',
    },
    handlers = {
      lsp_zero.default_setup,
    }
  })

  local cmp = require('cmp')
  local cmp_format = lsp_zero.cmp_format()

  cmp.setup({
    sources = {
      {name = 'path'},
      {name = 'nvim_lsp'},
      {name = 'nvim_lua'},
    },
    formatting = cmp_format,
    mapping = cmp.mapping.preset.insert({
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
  })
end
