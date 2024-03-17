describe("lib.plugins", function()
  it("mkPlugin", function()
    local lib = require("lib.plugins")
    local plugin = lib.mkPlugin({
      pname = "editorconfig",
      src = lib.fetchFromGitHub({
        owner = "gpanders",
        repo = "editorconfig.nvim",
        rev = "5b9e303e1d6f7abfe616ce4cc8d3fffc554790bf",
      }),

      activatePhase = function()
        return {
          lazy = "test",
          enabled = "test",
          cond = "test",
          cmd = "test",
          ft = "test",
        }
      end,

      configurePhase = function()
        return {
          init = {},
          opts = {},
          config = {},
        }
      end,

      buildPhase = function()
        return {
          build = "test",
        }
      end,
    })

    assert.are.same(plugin, {
      -- src
      name = "editorconfig",
      url = "https://github.com/gpanders/editorconfig.nvim.git",
      commit = "5b9e303e1d6f7abfe616ce4cc8d3fffc554790bf",

      -- activate
      lazy = "test",
      enabled = "test",
      cond = "test",
      cmd = "test",
      ft = "test",

      -- config
      init = {},
      opts = {},
      config = {},

      -- build
      build = "test",
    })
  end)
end)
