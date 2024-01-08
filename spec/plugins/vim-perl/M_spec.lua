describe("plugins.vim-perl", function()
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

  it("M", function()
    local plugin = require("plugins.vim-perl")

    assert.are.equal(plugin.name, "vim-perl")
    assert.are.equal(plugin.url, "https://github.com/vim-perl/vim-perl.git")

    assert.True(plugin.lazy)
    assert.are.equal(plugin.ft, "perl")

    assert.are.equal(plugin.build, "make clean " .. table.concat(features, " "))
  end)
end)
