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

  'bling/vim-airline',
  'kien/ctrlp.vim',
  {
   "nvim-neo-tree/neo-tree.nvim",
   branch = "v3.x",
   dependencies = {
     "nvim-lua/plenary.nvim",
     "nvim-tree/nvim-web-devicons",
     "MunifTanjim/nui.nvim",
   },
  },
  {
      's1n7ax/nvim-window-picker',
      name = 'window-picker',
      event = 'VeryLazy',
      version = '2.*',
      config = function()
          require'window-picker'.setup()
      end,
  },
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
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-lua/plenary.nvim',
      'leoluz/nvim-dap-go',
      'nvim-neotest/nvim-nio',
    }
  },
  {
     'nvim-telescope/telescope.nvim', tag = '0.1.5',
     dependencies = {
       'nvim-lua/plenary.nvim'
     }
  },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' }
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
   vim.keymap.set("n", "<C-b>", function()
     require("neo-tree.command").execute({
       source = "buffers",
       position = "left",
     })
   end, { desc = "Open Neo-tree buffers (left)" })

   vim.keymap.set("n", "<C-n>", function()
     require("neo-tree.command").execute({
       source = "filesystem",
       position = "left",
       toggle = true,
     })
   end, { desc = "Toggle Neo-tree filesystem (left)" })

   vim.keymap.set("n", "<C-g>", function()
     require("neo-tree.command").execute({
       source = "git_status",
       position = "left",
       toggle = true,
     })
    end, { desc = "Toggle Neo-tree git_status (left)" })

    vim.keymap.set('n', '<C-f>', function()
        local current_file = vim.api.nvim_buf_get_name(0)
        if current_file == '' then
            return
        end
        require("neo-tree.command").execute({
            action = "focus",
            source = "filesystem",
            position = "left",
            reveal = true,
            reveal_file = current_file,
        })
    end, { desc = "Reveal current file in Neo-tree" })

  -- NERDCommenter mappings
  vim.api.nvim_set_keymap('n', '<C-_>', '<Plug>NERDCommenterToggle', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', '<C-_>', '<Plug>NERDCommenterToggle<CR>gv', { noremap = true, silent = true })

  -- Open a terminal in a new split
  local os_name = vim.loop.os_uname().sysname
  local term_cmd = os_name == "Windows_NT" and "pwsh" or "bash"
  vim.api.nvim_set_keymap('', '<C-\\>', '<Esc>:sp | resize 10 | term ' .. term_cmd .. '<CR>', { noremap = true, silent = true })

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

   require("neo-tree").setup({
     sources = { "filesystem", "buffers", "git_status" },
     source_selector = {
       winbar = true,
       sources = {
         { source = "filesystem" },
         { source = "buffers" },
         { source = "git_status" },
       },
     },
     window = {
       mappings = {
         ["<Tab>"] = false,
         ["<S-Tab>"] = false,
         ["I"] = "toggle_hidden",
       },
     },
   })

  -- Rip Grep - brew install ripgrep
  -- Use ag over grep
  vim.o.grepprg = 'rg --vimgrep'

  -- Use rg in CtrlP for listing files. Lightning fast and respects .gitignore
  vim.g.ctrlp_user_command = 'rg %s -l -g ""'

  -- rg is fast enough that CtrlP doesn't need to cache
  vim.g.ctrlp_use_caching = 0

  -- Set leader key to comma
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


  vim.api.nvim_set_keymap('n', '<leader>a', ':AIChat ', { noremap = true })
  vim.api.nvim_set_keymap('n', '<leader>c', ':AIChat<CR>', { noremap = true })
  vim.api.nvim_set_keymap('x', '<leader>a', ':AIChat ', { noremap = true })
  vim.api.nvim_set_keymap('x', '<leader>c', ':AIChat<CR>', { noremap = true })

  -- formatting
  vim.api.nvim_set_keymap('n', '<leader>6d', ':% !base64 -d <CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>6e', ':% !base64 <CR>', { noremap = true, silent = true })
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
      local command = { 'rg', '--vimgrep', word, '--glob', '!obj/*', '--glob', '!bin/*', '.' }
      local results = vim.fn.systemlist(command)
      if vim.v.shell_error ~= 0 and #results == 0 then
        vim.notify('GlobalFind failed (is ripgrep available in PATH?)', vim.log.levels.ERROR)
        return
      end
      local qflist = {}
      for _, line in ipairs(results) do
        local filename, lnum, col, message = string.match(line, "^([^:]+):(%d+):(%d+):(.*)")
        if filename then
          table.insert(qflist, {
            filename = vim.fn.fnamemodify(filename, ":p"), -- Get absolute path
            lnum = tonumber(lnum),
            col = tonumber(col),
            text = message
          })
        end
      end
      vim.fn.setqflist({}, ' ', { title = 'Global Find: ' .. word, items = qflist })
      vim.cmd('copen') -- Open the quickfix list
    end
  end

  -- Mapping for GlobalFind
  vim.api.nvim_set_keymap('n', '<leader>f', ':lua GlobalFind()<CR>', { noremap = true, silent = true })

  local telescope = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = '[F]ind [F]iles' })
  vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = '[F]ind [G]rep' })
  vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = '[F]ind [B]uffers' })
  vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = '[F]ind [H]elp' })

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

  -- remove all trailing spaces
  vim.api.nvim_set_keymap('n', '<F3>', [[<cmd>lua vim.cmd('%s/\\s\\+$//e')<CR>]], { noremap = true, silent = true })

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

  vim.diagnostic.config({
    virtual_text = {
      prefix = '●',
      source = 'always',
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  lsp_zero.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
  })

  lsp_zero.on_attach(function(client, bufnr)
    -- Default lsp-zero keybindings
    lsp_zero.default_keymaps({ buffer = bufnr })
    -- Explicit F4 keybinding for code actions
    vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP: Code Action' })
    -- Additional useful keybindings
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP: Hover' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'LSP: Go to Definition' })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP: Rename' })
  end)

  require('mason').setup({})
  require('mason-lspconfig').setup({
    ensure_installed = {
      'rust_analyzer', 'gopls', 'jdtls', 'gradle_ls','clojure_lsp',
      'eslint', 'ts_ls', 'pylsp', 'yamlls', 'jsonls', 'taplo', 'cssls', 'html', 'sqlls',
      'dockerls', 'terraformls', 'vimls', 'bashls', 'omnisharp',
    },
    handlers = {
      lsp_zero.default_setup,

      gopls = function()
        require('lspconfig').gopls.setup({
          on_attach = lsp_zero.on_attach,
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
              completeUnimported = true,
              usePlaceholders = true,
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                parameterNames = true,
              },
            },
          },
        })
      end,

      crystalline = function()
        require('lspconfig').crystalline.setup({
          on_attach = lsp_zero.on_attach,
        })
      end,
    }
  })

  local cmp = require('cmp')
  local cmp_format = lsp_zero.cmp_format()

  cmp.setup({
    sources = {
      { name = 'path' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'buffer', keyword_length = 3 },
      { name = 'luasnip', keyword_length = 2 },
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

  --vim.o.timeoutlen = 1000

  -- DAP (Debug Adapter Protocol)
  require("dapui").setup()

  -- Open the UI automatically when debugging starts
  local dap, dapui = require("dap"), require("dapui")
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end

  -- Close the UI when debugging terminates
  dap.listeners.after.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.after.event_exited["dapui_config"] = function()
    dapui.close()
  end

  -- Optional: keybindings for debugging
  vim.api.nvim_set_keymap('n', '<Leader>b', ":lua require'dap'.toggle_breakpoint()<CR>", { noremap=true })
  vim.api.nvim_set_keymap('n', '<F5>', ":lua require'dap'.continue()<CR>", { noremap=true })
  vim.api.nvim_set_keymap('n', '<F7>', ":lua require'dap'.step_out()<CR>", { noremap=true })
  vim.api.nvim_set_keymap('n', '<F8>', ":lua require'dap'.step_over()<CR>", { noremap=true })
  vim.api.nvim_set_keymap('n', '<F9>', ":lua require'dap'.step_into()<CR>", { noremap=true })

  -- Configure Delve debugger for Go
  require('dap-go').setup({
    dap_configurations = {
      {
        type = 'go',
        name = 'Debug Terminal',
        request = 'launch',
        program = 'main.go',
        dlvToolPath = vim.fn.exepath('dlv'),
        console = 'integratedTerminal'
      },
    }
  })

  -- vim ai settings
  vim.g.vim_ai_chat = {
    options = {
      endpoint_url = "https://ai.drujensen.com/v1/chat/completions",
      model = "qwen3-coder:30b",
      token_file_path = "/home/drujensen/.config/drujensen.token"
    }
  }
end
