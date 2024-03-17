describe("lib.linters", function()
  it("mkLinter", function()
    local lib = require("lib.linters")
    local parser = function()
      return { { foo = "bar" } }
    end

    local buildArgs = function()
      return { "-lah" }
    end

    local linter = lib.mkLinter({
      executable = "ls",
      buildArgs = buildArgs,
      parsePhase = parser,
      configurePhase = function()
        return { append_fname = true }
      end,
    })

    assert.are.same(linter, {
      cmd = "ls",
      append_fname = true,
      args = { "-lah" },
      parser = parser,
    })
  end)
end)
