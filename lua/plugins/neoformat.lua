return {
  "sbdchd/neoformat",
  lazy = false,
  config = function(_)
    local formats = {
      "*.css",
      "*.go",
      "*.html",
      "*.js",
      "*.json",
      "*.lua",
      "*.nix",
      "*.pl",
      "*.pm",
      "*.scss",
      "*.t",
      "*.ts",
      "*.xml",
      "*.yaml",
      "cpanfile"
    }

    local id = vim.api.nvim_create_augroup("neo-format", {clear = true})

    vim.api.nvim_create_autocmd(
      {"BufWritePre"},
      {
        group = id,
        pattern = formats,
        command = "Neoformat"
      }
    )

    local luafmt = vim.fn["neoformat#formatters#lua#luafmt"]()
    luafmt.exe = "node"
    luafmt.args = {"~/.local/share/npm/bin/luafmt", "--stdin", "-i 2"}
    vim.g.neoformat_lua_luafmt = luafmt

    vim.g.neoformat_try_node_exe = 1
  end
}
