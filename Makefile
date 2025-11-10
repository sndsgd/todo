SHELL := /usr/bin/env bash
CWD := $(shell pwd)
BUILD_DIR := $(CWD)/build
SRC_DIR := $(CWD)/src

GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

NPROC ?= $(shell nproc)

.DEFAULT_GOAL := help
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[33m%s\033[0m~%s\n", $$1, $$2}' \
	| column -s "~" -t

.PHONY: todo
todo: ## Show `TODO` lines in the repo
	@git grep -n TODO -- \
		':(exclude)Makefile' \
		':(exclude)./extern/*' \
		| grep -v '## Show `TODO`' \
		| grep -v '@git grep TODO' \
		| sed 's/:[^:]*TODO//' \
		| column -t -l2

.PHONY: todo-branch
todo-branch: ## Show `TODO [branch]` lines in the repo
	@git grep -n -E 'TODO[[:space:]]+\[$(GIT_BRANCH)\]' -- \
		':(exclude)Makefile' \
		':(exclude)./extern/*' \
		| sed -E 's/:[^:]*TODO[[:space:]]+\[[^]]+\]//' \
		| column -t -l2

.PHONY: aicp
aicp: ## copy an aicp command into the clipboard
	@echo -n "aicp ~.git ~build ~extern" | xclip -selection c

.PHONY: prepare-build-directory
prepare-build-directory:
	@mkdir -p "$(BUILD_DIR)"

.PHONY: clean
clean:
	@rm -rf "$(BUILD_DIR)"
