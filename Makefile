SHELL := /usr/bin/env bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help

export SATIS_IMAGE ?= composer/satis@sha256:6bdbb1da77bfa72de8bb8f9629dc815eaad1126a2a1a0b026fb5c2c001d7b2d0
export COMPOSER_IMAGE ?= composer@sha256:aaeab4b6b031e0a88efb907f0f26b563532a644fc2f4ea0d000ecf8658f7a2b8
export REPOSITORY_URL
export GITHUB_TOKEN

REPO ?= kingletas/packages

# --- build ---

.PHONY: build
build: ## Build the Composer repository into local.d/site (REPOSITORY_URL=... to serve it elsewhere)
	@bin/build

.PHONY: check
check: build ## Build, then prove every release in it installs
	@bin/check

.PHONY: listing
listing: ## Name public module repositories satis.json does not carry, and listed ones that are not public
	@bin/listing

# --- publish ---

.PHONY: publish
publish: ## Rebuild the live repository now instead of waiting for the daily run
	@gh workflow run publish.yml --repo $(REPO)
	@echo "Started. Follow it with: gh run watch --repo $(REPO)"

.PHONY: clean
clean: ## Remove everything the build and check wrote
	@rm -rf local.d/site local.d/build local.d/check

.PHONY: help
help: ## List the targets
	@grep -hE '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'
