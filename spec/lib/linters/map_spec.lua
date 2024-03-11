describe("lib.linters", function()
  it("map", function()
    local lib = require("lib.linters")
    local src = { { foo = 1 }, { foo = 2 } }

    local results = lib.map(src, function(msg)
      return { foo = msg.foo + 1 }
    end)

    assert.are.same(results, { { foo = 2 }, { foo = 3 } })
  end)
end)
