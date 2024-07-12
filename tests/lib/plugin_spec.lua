local plugin = require("lib.plugin")
local src = require("lib.src")

describe("lib.plugin", function()
  it("minial", function()
    local path = plugin.mkPlugin({
      pname = "test",
      src = src.localFrom("~/.config/nvim/internal/test"),
    })

    assert.are.equal(path.name, "test")
    assert.are.equal(path.dir, "~/.config/nvim/internal/test")

    local git = plugin.mkPlugin({
      pname = "test",
      src = src.fetchgit({
        url = "https://github.com/nyarla/dotnvim-v3.git",
        rev = "HEAD",
      }),
    })

    assert.are.equal(git.url, "https://github.com/nyarla/dotnvim-v3.git")
    assert.are.equal(git.commit, "HEAD")
    assert.are.equal(git.pin, true)
    assert.are.equal(git.submodules, false)
  end)

  it("with dont options", function()
    local path = plugin.mkPlugin({
      pname = "test",
      src = src.localFrom("~/.config/nvim/internal/test"),
      dontLazy = true,
      dontEnabled = false,
      dontLoad = false,
    })

    assert.are.equal(path.lazy, false)
    assert.are.equal(path.enabled, true)
    assert.are.equal(path.load, true)
  end)

  it("with properties", function()
    local path = plugin.mkPlugin({
      pname = "test",
      src = src.localFrom("~/.config/nvim/internal/test"),
      buildInputs = { "foo" },
      initialise = function() end,
      options = {},
      configurePhase = function()
        return true
      end,
      buildHook = function()
        return true
      end,
      activators = {
        events = "test",
        commands = "test",
        filetypes = "test",
        keys = "test",
      },
    })

    assert.are.same(path.dependencies, { "foo" })
    assert.are.same(path.opts, {})
    assert.are.equal(type(path.config), "function")
    assert.are.equal(type(path.build), "function")
    assert.are.equal(path.event, "test")
    assert.are.equal(path.cmd, "test")
    assert.are.equal(path.ft, "test")
    assert.are.equal(path.key, "test")
  end)
end)
