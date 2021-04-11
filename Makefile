DOTFILES_SOURCES := $(shell find home -type f)
DOTFILES_TARGETS  := $(patsubst home/%, $(HOME)/%, $(DOTFILES_SOURCES))
DOTFILES_DIR := $(shell pwd)

.PHONY: all
all: install

.PHONY: install
install: configs secrets

.PHONY: update
update: git_update configs

configs: $(DOTFILES_TARGETS)

.PHONY: $(DOTFILES_SOURCES)
$(HOME)/%: home/%
	@mkdir -p "$(@D)"
	@test -e "$@" || ln -s "$(DOTFILES_DIR)/$^" "$@"

.PHONY: secrets
.ONESHELL: secrets
secrets:
	@read -p "What is your 1Password email? " op_email
	@eval $$(op signin https://my.1password.com $$op_email)
	@temp_file=`mktemp`
	@op get document "Personal GPG Keys" > $$temp_file
	@export GPG_TTY=$$(tty)
	@tar -Oxzf $$temp_file ownertrust.asc | gpg --import-ownertrust
	@tar -Oxzf $$temp_file private.asc | gpg --import
	@tar -Oxzf $$temp_file public.asc | gpg --import
	@rm $$temp_file
	@mkdir -p $(HOME)/.ssh
	@op get document "Personal SSH Keys" | tar -xzf - -C $(HOME)/.ssh
	@cat $(HOME)/.ssh/network.pub >> $(HOME)/.ssh/authorized_keys
	@chmod 0700 $(HOME)/.ssh
	@chmod 0600 $(HOME)/.ssh/*
	@op signout --account my --forget

.PHONY: git_update
git_update:
	@git pull --rebase
