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
    rev = "f59a1610b928bd349c4a471804e38960e001a1af",
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
