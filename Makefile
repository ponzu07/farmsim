.PHONY: help up down npm-install npm-build npm-dev npm-test npm-run clean

help:
	@echo "Available commands:"
	@echo "  make help        - Display this help message"
	@echo "  make up          - Start development environment (docker-compose up -d)"
	@echo "  make down        - Stop development environment (docker-compose down)"
	@echo "  make npm-install - Run npm install"
	@echo "  make npm-build   - Run npm build"
	@echo "  make npm-dev     - Start development server (npm run dev)"
	@echo "  make npm-test    - Run npm test"
	@echo "  make npm-run cmd=XXX - Run specified npm command (Example: make npm-run cmd=lint)"
	@echo "  make clean       - Completely clean up containers and volumes"

up:
	docker-compose up -d

down:
	docker-compose down

npm-install:
	docker-compose exec app npm install

npm-build:
	docker-compose exec app npm run build

npm-dev:
	docker-compose exec app npm run dev

npm-test:
	docker-compose exec app npm run test

npm-run:
	@if [ -z "$(cmd)" ]; then \
		echo "Usage: make npm-run cmd=command_name"; \
		echo "Example: make npm-run cmd=lint"; \
		exit 1; \
	fi
	docker-compose exec app npm run $(cmd)

clean:
	docker-compose down -v --rmi all
	@echo "Containers, images, and volumes have been completely removed"