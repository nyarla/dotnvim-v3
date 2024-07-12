local stdenv = require("lib.linter")

describe("lib.linter", function()
  it("mkLinter", function()
    local linter = stdenv.mkLinter({
      pname = "test",
      configurePhase = function()
        return {}
      end,
      parsePhase = function()
        return {}
      end,

      buildArgs = function()
        return { "echo", "test" }
      end,
    })

    assert.are.equal(linter.name, "test")
    assert.are.equal(type(linter.config.args), "function")
    assert.are.equal(type(linter.config.parser), "function")
  end)
end)
