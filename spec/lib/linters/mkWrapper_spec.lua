describe("lib.linters", function()
  it("mkWrapper", function()
    local lib = require("lib.linters")
    local args = lib.mkWrapper("coreutils", "ls", function()
      return { "-lah" }
    end)

    assert.are.same(args, {
      vim.env.HOME .. "/.config/nvim/pkgs/bin/nix-run",
      "--package",
      "coreutils",
      "--app",
      "ls",
      "--",
      "-lah",
    })
  end)
end)
