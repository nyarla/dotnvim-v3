local function nnoremap(key, action)
  vim.api.nvim_set_keymap("n", key, action, { noremap = true, silent = true })
end

local function vnoremap(key, action)
  vim.api.nvim_set_keymap("v", key, action, { noremap = true, silent = true })
end

vnoremap("zs", ":sort<CR>")
vnoremap("zS", ":sort!<CR>")

nnoremap("<C-n>", ":Neotree toggle<CR>")
