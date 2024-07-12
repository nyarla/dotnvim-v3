local json = require("lib.json")

describe("lib/json.lua", function()
  it("parse", function()
    assert.are.same(json.parse('{"foo": "bar"}'), { foo = "bar" })
    assert.are.same(json.parse("{"), nil)
  end)

  it("stringify", function()
    assert.are.equal(json.stringify({ foo = "bar" }), '{"foo":"bar"}')
  end)
end)
