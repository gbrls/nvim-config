require('plugin') 
require('plugin.treesitter') -- you have to configure it from toplevel
require('editor') -- basic vim settings


function _G.hello() 
    vim.api.nvim_set_keymap('n','<Right>',':n<CR>',{})
    vim.api.nvim_set_keymap('n','<Left>',':N<CR>',{})
    vim.cmd('set t_vi=1')
    if (vim.api.nvim_eval('exists(\'#goyo\')')) then
        vim.cmd('Goyo')
        print('is goyo')
    end
end

-- TODO: move this to a better place
function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup '..group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            -- if type(def) == 'table' and type(def[#def]) == 'function' then
            --          --  def[#def] = lua_callback(def[#def])
            --                      -- end
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end

nvim_create_augroups({present = {'BufRead *.vpm call v:lua.hello()', 'BufRead,BufNewFile *.gf.vpm setfiletype gf'}})
