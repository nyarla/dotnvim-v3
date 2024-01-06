TESTDIR := $(shell mktemp -d /tmp/nvim.XXXXXXXX)
LIBC = $(shell nix eval "nixpkgs#stdenv.cc.libc.outPath" --raw)

all:
	echo hi,

.test-in-shell:
	@test -n "$(IN_NVIM_SHELL)" || (echo 'this command requires to enter nvim shell by `make shell`' >&2 ; exit 1)

shell:
	nix shell nixpkgs#luajit nixpkgs#luajitPackages.luarocks -c zsh -euo pipefail -c "\
		export IN_NVIM_SHELL=1 ; \
		luarocks --local --lua-version=5.1 install vusted RT_LIBDIR=$(LIBC)/lib; \
		export LUA_PATH=$(HOME)/.luarocks/share/lua/5.1/?.lua:$(HOME)/.luarocks/share/lua/5.1/?/init.lua ; \
		export LUA_CPATH=$(HOME)/.luarocks/lib/lua/5.1/?.so ; \
	"
