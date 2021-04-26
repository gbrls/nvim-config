function _G.present()
    print('Hello PRESENT!')
end
vim.cmd([[
    autocmd BufNewFile,BufRead *.vpm echo "Hello tehre!"
]])

-- vim.cmd([[
--     autocmd BufNewFile,BufRead *.vpm call luaeval('require("plugin.present").fn()')
-- ]])
