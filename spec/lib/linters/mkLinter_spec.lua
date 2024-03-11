describe("lib.linters", function()
  it("mkLinter", function()
    local lib = require("lib.linters")
    local parser = function()
      return { { foo = "bar" } }
    end

    local linter = lib.mkLinter({
      pname = "coreutils",
      executable = "ls",
      buildArgs = function()
        return { "-lah" }
      end,
      parsePhase = parser,
      configurePhase = function()
        return { append_fname = true }
      end,
    })

    assert.are.same(linter, {
      cmd = "bash",
      append_fname = true,
      args = {
        vim.env.HOME .. "/.config/nvim/pkgs/bin/nix-run",
        "--package",
        "coreutils",
        "--app",
        "ls",
        "--",
        "-lah",
      },
      parser = parser,
    })
  end)
end)
