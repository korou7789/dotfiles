local opts = { noremap = true, silent = true }

vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)

vim.keymap.set("n", "x", [["_x]], opts)
vim.keymap.set("n", "X", [["_D]], opts)
vim.keymap.set("x", "x", [["_x]], opts)

vim.keymap.set("n", "-", [["_]])
vim.keymap.set("n", "+", [["+]])

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
