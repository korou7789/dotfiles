vim.loader.enable()

require("config.options")
require("config.dpp")
require("lsp")
require("config.keymaps")

vim.cmd[[
set runtimepath+=~/work/my_jumpcursor
]]
