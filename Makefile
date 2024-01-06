TESTDIR := $(shell mktemp -d /tmp/nvim.XXXXXXXX)
LIBC = $(shell nix eval "nixpkgs#stdenv.cc.libc.outPath" --raw)

all: test

test:
	@test -d $(TESTDIR)/.config || mkdir -p $(TESTDIR)/.config
	@test -d $(TESTDIR)/.cache/swap || mkdir -p $(TESTDIR)/.cache/swap
	@test -d $(TESTDIR)/.cache/backup || mkdir -p $(TESTDIR)/.cache/backup
	@test -d $(TESTDIR)/.cache/backup || mkdir -p $(TESTDIR)/.cache/backup
	@ln -sf $(shell pwd) $(TESTDIR)/.config/nvim
	@ln -sf ~/.terminfo $(TESTDIR)/.terminfo
	@ln -sf ~/.local $(TESTDIR)/.local
	@env HOME=$(TESTDIR) nvim .
	@rm -rf $(TESTDIR)

shell:
	nix shell nixpkgs#luajit nixpkgs#luajitPackages.luarocks -c zsh -euo pipefail -c "\
		export IN_NVIM_SHELL=1 ; \
		luarocks --local --lua-version=5.1 install vusted RT_LIBDIR=$(LIBC)/lib; \
		export LUA_PATH=$(HOME)/.luarocks/share/lua/5.1/?.lua:$(HOME)/.luarocks/share/lua/5.1/?/init.lua ; \
		export LUA_CPATH=$(HOME)/.luarocks/lib/lua/5.1/?.so ; \
	"
