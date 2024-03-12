describe("plugins.nvim-lint", function()
  it("M", function()
    local plugin = require("plugins.nvim-lint")

    assert.are.equal(plugin.name, "nvim-lint")
    assert.are.equal(plugin.url, "https://github.com/mfussenegger/nvim-lint.git")
  end)
end)
