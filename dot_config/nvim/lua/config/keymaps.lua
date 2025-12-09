local opts = { noremap = true, silent = true }

vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
