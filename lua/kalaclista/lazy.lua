local lazyPath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyGitRepo = "https://github.com/folke/lazy.nvim.git"

if not vim.loop.fs_stat(lazyPath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", lazyGitRepo, "--branch=stable", lazyPath})
end

vim.opt.rtp:prepend(lazyPath)
