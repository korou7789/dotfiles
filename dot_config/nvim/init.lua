vim.loader.enable()

require("lsp")
require("config.dpp")
require("config.keymaps")
require("config.options")

vim.cmd[[
set runtimepath+=~/work/my_jumpcursor
]]
