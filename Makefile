##@ Help

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Build

.PHONY: build
build: ## Build the contracts
	forge build

##@ Exploit
DEBUG?=false

.PHONY: exploit
exploit: ## Run exploits. Set DEBUG to true to show traces: `make exploit DEBUG=true`.
	@if [ $(DEBUG) = true ]; then \
		forge test -vvvv; \
	else \
		forge test; \
	fi

##@ Lint

.PHONY: install
install: ## Install npm dependencies.
	npm install

.PHONY: lint
lint: ## Lint Solidity code.
	npx prettier --write 'src/**/*.sol' 'test/**/*.sol'
