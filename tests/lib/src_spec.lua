local src = require("lib.src")

describe("lib/src", function()
  it("fetchgit", function()
    local def = src.fetchgit({
      url = "https://github.com/nyarla/dotnvim-v3.git",
      rev = "HEAD",
    })

    assert.are.same(def, {
      kind = "git",
      data = {
        url = "https://github.com/nyarla/dotnvim-v3.git",
        rev = "HEAD",
      },
    })
  end)

  it("fetchFromGitHub", function()
    local def = src.fetchFromGitHub({
      owner = "nyarla",
      repo = "dotnvim-v3",
      rev = "HEAD",
      fetchSubmodules = false,
    })

    assert.are.same(def, {
      kind = "git",
      data = {
        url = "https://github.com/nyarla/dotnvim-v3.git",
        rev = "HEAD",
      },
    })
  end)

  it("localFrom", function()
    local def = src.localFrom("~/Development/spvm-vim-syntax")

    assert.are.same(def, {
      kind = "local",
      data = {
        path = "~/Development/spvm-vim-syntax",
      },
    })
  end)
end)
