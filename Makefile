.DEFAULT_GOAL := help

.PHONY: build start stop restart attach clean clean_images clean_containers help

build: code ## Build the tddec image
	docker-compose build

start: ## Start tddec container
	docker-compose up -d

stop: ## Stop tddec container
	docker-compose down

restart: ## Restart tddec container
	docker-compose restart

attach: ## Execute bash in tddec container
	docker-compose exec tddec bash

clean: clean_images clean_containers # Clean tddec image and container

clean_images:
	docker-compose down --rmi all

clean_containers: stop
	docker-compose rm -f

code:
	wget http://media.pragprog.com/titles/jgade/code/jgade-code.tgz
	tar xzf jgade-code.tgz
	rm jgade-code.tgz

help:
	@echo "Test-Driven Development for Embedded C docker environment"
	@echo "---------------------------------------------------------"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-150s\033[0m %s\n", $$1, $$2}'
