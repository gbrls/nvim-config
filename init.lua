-- Install packer
local execute = vim.api.nvim_command

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

-- vim.api.nvim_exec([[
--   augroup Packer
--     autocmd!
--     autocmd BufWritePost init.lua PackerCompile
--   augroup end
-- ]], false)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'       -- Package manager
  use 'tpope/vim-fugitive'           -- Git commands in nvim
  use 'tpope/vim-rhubarb'            -- Fugitive-companion to interact with github
  use 'tpope/vim-commentary'         -- "gc" to comment visual regions/lines
  use 'tpope/vim-surround'         
  --
  --use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  use 'joshdick/onedark.vim'         -- Theme inspired by Atom
  use 'folke/tokyonight.nvim'
  use 'kyazdani42/blue-moon'
  --use 'itchyny/lightline.vim'        -- Fancier statusline
  -- Add indentation guides even on blank lines
  use { 'lukas-reineke/indent-blankline.nvim' }
  -- Add git related info in the signs columns and popups
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'} }
  use 'neovim/nvim-lspconfig'        -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-compe'           -- Autocompletion plugin
  use {
	'folke/which-key.nvim',
	config = function()
		require("which-key").setup { }
	end
  }

  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'-- tree lua

  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'

  use {'glepnir/dashboard-nvim', 
        config = function()
            vim.cmd[[let g:dashboard_default_executive ='telescope']]
        end
   }

   use 'simrat39/rust-tools.nvim'
   use {
       'folke/trouble.nvim',
       requires = 'kyazdani42/nvim-web-devicons',
       config = function()
           require('trouble').setup { }
          end
  }
   use 'ARM9/arm-syntax-vim'
   use 'nvim-treesitter/nvim-treesitter'
   use {
       'folke/zen-mode.nvim',
       config = function()
           require('zen-mode').setup { }
       end
   }

   -- use {
   --     'folke/twilight.nvim',
   --     config = function()
   --         require('twilight').setup { }
   --     end
   -- }

   use {
       'hoob3rt/lualine.nvim',
       requires = {'kyazdani42/nvim-web-devicons', opt = true}
   }
   use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}
   use 'ggandor/lightspeed.nvim'
   use 'wlangstroth/vim-racket'
   use 'calebsmith/vim-lambdify'
   use 'tikhomirov/vim-glsl'

end)

local rust_cfg = {
    inlay_hints = { only_current_line = true }
}
require('rust-tools').setup(rust_cfg)

-- Mine
vim.g.tokyonight_style = 'night'
vim.g.tokyonight_italic_comments = false
vim.g.tokyonight_italic_keywords = false

vim.cmd[[au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7]]
vim.cmd[[set guifont=Cascadia\ Code\ PL:h10]]
vim.cmd[[set clipboard+=unnamedplus]]
vim.o.scrolloff = 3             -- keep 3 lines when scrolling
vim.o.ai = true                 -- set auto-indenting for programming

vim.o.tabstop = 4               -- number of visual spaces per TAB
vim.o.softtabstop = 4			-- number of spaces in tab when editing
vim.o.shiftwidth = 4			-- number of spaces to use for autoindent
vim.o.expandtab = true			-- tabs are spaces
-- End of mine

--Incremental live completion
vim.o.inccommand = "nosplit"

--Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

--Make line numbers default
vim.wo.number = true

--Do not save when switching buffers
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.cmd[[set undofile]]

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn="yes"

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.g.tokyonight_style = "night"
vim.cmd[[colorscheme tokyonight]]

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap=true, expr = true, silent = true})
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", {noremap= true, expr = true, silent = true})

--Remap escape to leave terminal mode
vim.api.nvim_set_keymap('t', '<Esc>', [[<c-\><c-n>]], {noremap = true})

--Add map to enter paste mode
vim.o.pastetoggle="<F3>"

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile'}
vim.g.indent_blankline_char_highlight = 'LineNr'

-- Toggle to disable mouse mode and indentlines for easier paste
ToggleMouse = function()
  if vim.o.mouse == 'a' then
    vim.cmd[[IndentBlanklineDisable]]
    vim.wo.signcolumn='no'
    vim.o.mouse = 'v'
    vim.wo.number = false
    print("Mouse disabled")
  else
    vim.cmd[[IndentBlanklineEnable]]
    vim.wo.signcolumn='yes'
    vim.o.mouse = 'a'
    vim.wo.number = true
    print("Mouse enabled")
  end
end

vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua ToggleMouse()<cr>', { noremap = true })

-- Telescope
local trouble = require('trouble.providers.telescope')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
        ["<C-t>"] = trouble.open_with_trouble,
      },
      n = {
        ["<C-t>"] = trouble.open_with_trouble,
      },
    },
    -- generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
    -- file_sorter =  require'telescope.sorters'.get_fzy_sorter,
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

-- Trouble commands
-- nnoremap <leader>xx <cmd>TroubleToggle<cr>
-- nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
-- nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
-- nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
-- nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
-- nnoremap gR <cmd>TroubleToggle lsp_references<cr>

local wk = require("which-key")
--Add leader shortcuts
wk.register({
    f = {
        name = "file",
        f = {[[<cmd>lua require('telescope.builtin').find_files()<cr>]], "Find File", noremap = true, silent = true},
        h = {'<cmd>Telescope oldfiles<cr>', "Oldfiles", noremap = true, silent = true},
    },
    g = {
        name = "git",
        c = {[[<cmd>lua require('telescope.builtin').git_commits()<cr>]],  'Commits',  noremap = true, silent = true},
        b = {[[<cmd>lua require('telescope.builtin').git_branches()<cr>]], 'Branches', noremap = true, silent = true},
        s = {[[<cmd>lua require('telescope.builtin').git_status()<cr>]],   'Status',   noremap = true, silent = true},
    },
    l = {
        name = "lsp",
        a = {[[<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>]],  'Actions',  noremap = true, silent = true},
        f = {[[<cmd>Format<cr>]],  'Format',  noremap = true, silent = true},
        t = {[[<cmd>TroubleToggle<cr>]],  'Trouble Toggle',  noremap = true, silent = true},
        r = {[[<cmd>TroubleToggle lsp_references<cr>]],  'References',  noremap = true, silent = true},
    },
    c = {
        name = "Commands",
        h = {[[<cmd>lua require('telescope.builtin').command_history()<cr>]],  'History',  noremap = true, silent = true},
    },

    r = {
        name = "run",
        r = {[[<cmd>lua require('rust-tools.runnables').runnables()<cr>]],  'Rust Runnables',  noremap = true, silent = true},
        
    },
    -- @TODO: Write here multiple pickers, similar to Jetbrains's Shift-Shift
    ['<leader>'] = {[[<cmd>lua require('telescope.builtin').commands()<cr>]],  'All commands',  noremap = true, silent = true},
}, { prefix = '<leader>' })

-- vim.api.nvim_set_keymap('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<leader>l', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>t', [[<cmd>lua require('telescope.builtin').tags()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>o', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]], { noremap = true, silent = true})

-- Change preview window location
vim.g.splitbelow = true

-- Highlight on yank
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true})
--
-- LSP settings
local nvim_lsp = require('lspconfig')
local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

local sumneko_root_path = vim.fn.getenv("HOME").."/.local/bin/sumneko_lua" -- Change to your sumneko root installation
local sumneko_binary_path = "/bin/linux/lua-language-server" -- Change to your OS specific output folder
nvim_lsp.sumneko_lua.setup {
  cmd = {sumneko_root_path .. sumneko_binary_path, "-E", sumneko_root_path.."/main.lua" };
  on_attach = on_attach,
  settings = {
      Lua = {
          runtime = {
              version = 'LuaJIT',
              path = vim.split(package.path, ';'),
          },
          diagnostics = {
              globals = {'vim'},
          },
          workspace = {
              library = {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
              },
          },
      },
  },
}

-- Map :Format to vim.lsp.buf.formatting()
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

-- Set completeopt to have a better completion experience
vim.o.completeopt="menuone,noinsert"

-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end


vim.api.nvim_set_keymap("i", "<F5>", "<cmd>lua run_cmd('./build.sh 0')<cr>", {expr = true})
vim.api.nvim_set_keymap("n", "<F5>", "<cmd>lua run_cmd('./build.sh 0')<cr>", {expr = false})

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  --ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = { "c", "rust", "javascript", "lua", "haskell", "racket"},  -- list of language that will be disabled
  },
}

require'lualine'.setup {
    options = { theme = 'tokyonight' },
    extensions = {'fugitive', 'nvim-tree'},
}
-- It doesn't work well with nvim-qt on windows 
-- require'bufferline'.setup{ }

run_cmd = function(arg)
    print('Running')
    print(arg)
    local handle = io.popen(arg)
    local result = handle:read("*a")
    handle:close()
    --print(result)
end

