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

return {
  "vim-perl/vim-perl",
  lazy = true,
  ft = "perl",
  build = "make clean " .. table.concat(features, " "),
}
