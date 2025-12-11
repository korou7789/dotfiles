vim.loader.enable()

require("config.options")
require("config.dpp")
require("lsp")
require("config.keymaps")
require("config.colorscheme")

vim.cmd[[
set runtimepath+=~/work/my_jumpcursor
]]
