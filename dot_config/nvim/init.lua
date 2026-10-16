vim.g.mapleader = " "

vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
})

require("mini.pick").setup()
require("mini.pairs").setup()
require('mini.extra').setup({})
require("mini.icons").setup()
require("mini.completion").setup()

vim.keymap.set("n", "<leader>f", MiniPick.builtin.files)
vim.keymap.set("n", "<leader>b", MiniPick.builtin.buffers)
vim.keymap.set("n", "<leader>g", MiniPick.builtin.grep_live)
vim.keymap.set("n", "<leader>d", MiniExtra.pickers.diagnostic)

vim.lsp.enable({
    "zls",
    "ts_ls",
})
