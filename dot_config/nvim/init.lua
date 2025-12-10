vim.loader.enable()

require("config.options")
require("lsp")
require("config.dpp")
require("config.keymaps")

vim.cmd[[
set runtimepath+=~/work/my_jumpcursor
]]
