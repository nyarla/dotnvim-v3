describe("plugins.nvim-treesitter", function()
  it("M", function()
    local plugin = require("plugins.nvim-treesitter")

    assert.are.equal(plugin.name, "nvim-treesitter")
    assert.are.equal(plugin.url, "https://github.com/nvim-treesitter/nvim-treesitter.git")
  end)
end)
