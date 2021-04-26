local plugs = require('plugin.plug')
require('plugin.present')

vim.fn['plug#begin']()

    for i in pairs(plugs) do
        if type(plugs[i]) == "table" then
            vim.cmd(string.format('Plug \'%s\', %s', plugs[i][1], plugs[i][2]))
        else
            vim.cmd(string.format('Plug \'%s\'', plugs[i]))
        end
    end

vim.fn['plug#end']()
