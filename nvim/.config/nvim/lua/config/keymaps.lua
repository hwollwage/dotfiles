-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-M-Left>", ":bprev<CR>", { silent = true, desc = "switch left tab w/ ctrl+arrowLeft" })
vim.keymap.set("n", "<C-M-Right>", ":bnext<CR>", { silent = true, desc = "switch right tab w/ ctrl+arrowRight" })
vim.keymap.set("n", "<C-M-h>", ":bprev<CR>", { silent = true, desc = "switch left tab with L" })
vim.keymap.set("n", "<C-M-l>", ":bnext<CR>", { silent = true, desc = "switch right tab with L" })
