local M = {}

local bundles = {
  library = require("plugins.library.setup"),
  filetype = require("plugins.filetypes.setup"),
  editor = require("plugins.editor.setup"),
  ui = require("plugins.ui.setup"),
  completion = {
    "lspkind",
    "vim-vsnip",
    "nvim-cmp",
    "cmp-buffer",
    "cmp-cmdline",
    "cmp-nvim-lsp",
    "cmp-path",
    "cmp-treesitter",
    "cmp-vsnip",
    "codeium",
  },
}

function M.setup(cfg)
  local spec = {}
  for _, name in pairs((cfg.use or {})) do
    local bundle = bundles[name]
    for _, plugin in ipairs(bundle) do
      table.insert(spec, require("plugins." .. plugin))
    end
  end

  require("lazy").setup({
    spec = spec,
    rocks = { enabled = false },
  })
end

return M
