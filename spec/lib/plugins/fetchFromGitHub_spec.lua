describe("lib.plugins", function()
  it("fetchFromGitHub", function()
    local lib = require("lib.plugins")
    local src = lib.fetchFromGitHub({
      owner = "gpanders",
      repo = "editorconfig.nvim",
      rev = "5b9e303e1d6f7abfe616ce4cc8d3fffc554790bf",
    })

    assert.are.same(src, {
      url = "https://github.com/gpanders/editorconfig.nvim.git",
      commit = "5b9e303e1d6f7abfe616ce4cc8d3fffc554790bf",
      pin = true,
    })
  end)
end)
