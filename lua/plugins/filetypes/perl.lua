local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

local features = {
  "carp",
  -- "dancer",
  "heredoc-sql",
  -- "heredoc-sql-mason",
  "highlight-all-pragmas",
  -- "js-css-in-mason",
  "method-signatures",
  "moose",
  "object-pad",
  "test-more",
  "try-tiny",
}

return mkPlugin({
  pname = "vim-perl",
  src = fetchFromGitHub({
    owner = "vim-perl",
    repo = "vim-perl",
    rev = "25ecb0061a3558d242a471b162aad20e4308815d",
  }),

  activators = {
    filetype = "perl",
  },

  buildHook = function(plugin)
    local cwd = vim.fn.stdpath("data") .. "/lazy/vim-perl"
    local cmd = "make clean " .. table.concat(features, " ")

    vim.print("vim-perl: " .. cmd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
      vim.api.nvim_echo({
        "failed to run vim-perl buildHook command:\n",
        result.stderr,
      })
    end
  end,
})
