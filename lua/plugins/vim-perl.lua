local features = {
  "carp",
  "dancer",
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

local lib = require("lib.plugins")
local M = lib.mkPlugin({
  pname = "vim-perl",
  src = lib.fetchFromGitHub({
    owner = "vim-perl",
    repo = "vim-perl",
    rev = "25ecb0061a3558d242a471b162aad20e4308815d",
  }),

  activatePhase = function()
    return {
      lazy = true,
      ft = "perl",
    }
  end,

  buildPhase = function()
    return {
      build = "make clean " .. table.concat(features, " "),
    }
  end,
})

return M
