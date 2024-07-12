local M = {}

function M.setup()
  vim.cmd.filetype({ "plugin", "indent", "on" })
  vim.cmd.syntax("enable")
  vim.cmd.colorscheme("vim")
  vim.cmd.colorscheme("kalaclista")
end

return M
