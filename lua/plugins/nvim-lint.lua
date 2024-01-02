local custom = {
  deadnix = require("lib.linters.deadnix"),
  textlint = require("lib.linters.textlint"),
}

vim.api.nvim_create_autocmd({ "InsertEnter", "BufWritePost", "TextChanged" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = "InsertEnter",
  config = function()
    local linters = require("lint")

    linters.linters_by_ft = {
      nix = { "statix", "deadnix" },
      markdown = { "textlint" },
    }

    for key, val in pairs(custom) do
      linters.linters[key] = val
    end

    return true
  end,
}
