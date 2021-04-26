require('plugin.fzf')

local plug = {
    -- Fuzzy search magic
    {'junegunn/fzf',  '{\'do\': { -> fzf#install() }}'},
    'junegunn/fzf.vim',
    -- Semantical highlighting
    {'nvim-treesitter/nvim-treesitter', '{\'do\': \':TSUpdate\'}'},
    -- LSP  Support
    {'neoclide/coc.nvim', '{\'branch\': \'release\'}'},
    
    'tpope/vim-surround', -- Surround, basic commands like ds( or ysiw]
    'junegunn/goyo.vim',  -- Zen-mode


    'tpope/vim-fugitive', -- Git wrapper

    -- Fancy statusline
    'vim-airline/vim-airline',
    'vim-airline/vim-airline-themes',

    -- Colorschemes
    'Erichain/vim-monokai-pro',
    'junegunn/seoul256.vim',
    'w0ng/vim-hybrid',
    'sjl/badwolf',
    'nanotech/jellybeans.vim',
    'ayu-theme/ayu-vim',
    'gdetrez/vim-gf'
}


return plug
