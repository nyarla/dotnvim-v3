local M = {}

function M.setup()
  local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  local repo = "https://github.com/folke/lazy.nvim.git"
  local commit = "f918318d21956b0874a65ab35ce3d94d9057aabf"

  local exec = function(cmd, cwd)
    if cwd ~= nil then
      local out = vim.system(cmd, { text = true, cwd = cwd }):wait()
      if out.code ~= 0 then
        err(out.stderr)
      end
      return
    end

    local out = vim.system(cmd, { text = true }):wait()
    if out.code ~= 0 then
      err(out.stderr)
    end
  end

  local err = function(msg)
    vim.api.nvim_echo({
      { "Failed to initialize lazy.nvim\n" },
      { msg, "WarningMsg" },
      { "\nPress any to key exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end

  if not (vim.uv or vim.loop).fs_stat(path) then
    vim.print("git clone lazy.vim...")
    exec({ "git", "clone", "--filter=blob:none", repo, path })

    vim.print("git checkout to " .. commit .. " as current...")
    exec({ "git", "checkout", "-b", "current", commit }, path)

    vim.print("done!")
  end

  vim.opt.rtp:prepend(path)
end

return M
