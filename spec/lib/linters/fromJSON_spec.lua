describe("lib.linters", function()
  it("fromJSON", function()
    local lib = require("lib.linters")
    local src = '{"foo": "bar"}'

    local decoded = lib.fromJSON(src)
    assert.are.same(decoded, { foo = "bar" })
  end)
end)
