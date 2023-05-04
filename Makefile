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
CONTRACT?=""

.PHONY: exploit
exploit: ## Run exploits. Set CONTRACT to only run the exploit of a specific contract and DEBUG to true to show traces: `make exploit CONTRACT=RoadClosed DEBUG=true`.
	@cmd="forge test"; \
	if [ "${CONTRACT}" != "" ]; then \
		cmd="$${cmd} --match-contract ${CONTRACT}"; \
	fi; \
	if [ "${DEBUG}" = "true" ]; then \
		cmd="$${cmd} -vvvv"; \
	else \
		cmd="$${cmd} -vvv"; \
	fi; \
	eval "$${cmd}";

##@ Lint

.PHONY: install
install: ## Install npm dependencies.
	npm install

.PHONY: lint
lint: build ## Lint Solidity code.
	npx prettier --write 'src/**/*.sol' 'test/**/*.sol'
