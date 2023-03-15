TESTDIR := $(shell mktemp -d /tmp/nvim.XXXXXXXX)

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
