vim.o.scrolloff = 3             -- keep 3 lines when scrolling
vim.o.ai = true                 -- set auto-indenting for programming

vim.o.tabstop = 4               -- number of visual spaces per TAB
vim.o.softtabstop = 4			-- number of spaces in tab when editing
vim.o.shiftwidth = 4			-- number of spaces to use for autoindent
vim.o.expandtab = true			-- tabs are spaces

vim.cmd([[
    set tabstop=4
    set shiftwidth=4
    set expandtab]]
    )

-- vim.cmd('set t_Co=256')

vim.o.showcmd = true			-- display incomplete commands
vim.o.number = true             -- show line numbers
vim.cmd('set number! relativenumber!')
vim.o.ruler = true              -- show the current row and column
vim.o.hlsearch = true			-- highlight searches
vim.o.incsearch = true			-- do incremental searching
vim.o.showmatch = true			-- jump to matches when entering regexp
vim.o.ignorecase = true			-- ignore case when searching
vim.o.smartcase = true			-- no ignorecase if Uppercase char present
vim.o.mouse = 'a'               -- enable the mouse


vim.cmd('let g:monokai_term_italic = 0')
vim.cmd('let g:monokai_gui_italic = 0')
-- vim.cmd('colo monokai_pro')
-- vim.cmd('colo default')
vim.cmd('colo ayu')
vim.cmd('set termguicolors')
vim.cmd('set clipboard+=unnamedplus')
--vim.o.termguicolors = true -- not sure about this

vim.cmd('set timeoutlen=200')
vim.cmd('set ttimeoutlen=5')
vim.cmd('hi Normal guibg=NONE ctermbg=NONE')

vim.cmd('let g:airline_powerline_fonts = 1')

-- Remap keys for gotos
vim.cmd('nmap <silent> gd <Plug>(coc-definition)')
vim.cmd('nmap <silent> gy <Plug>(coc-type-definition)')
vim.cmd('nmap <silent> gi <Plug>(coc-implementation)')
vim.cmd('nmap <silent> gr <Plug>(coc-references)')

vim.cmd('nnoremap <silent> <leader> :WhichKey \'<Space>\'<CR>')
