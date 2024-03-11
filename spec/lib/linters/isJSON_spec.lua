describe("lib.linters", function()
  it("isJSON", function()
    local lib = require("lib.linters")

    assert.is.True(lib.isJSON("{}"))
    assert.is.True(lib.isJSON("[]"))
    assert.is.False(lib.isJSON("()"))
  end)
end)
