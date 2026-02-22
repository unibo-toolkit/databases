DB_URL ?= postgresql://unibo_user:unibo_pass@localhost:5432/unibo_toolkit?sslmode=disable

.PHONY: help setup migrate-up migrate-down migrate-reset migrate-version create status clean

## help: Show this help message
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

## setup: Start local postgres
setup:
	docker compose up -d
	@echo "Waiting for postgres..."
	@until docker compose exec postgres pg_isready -U unibo_user; do sleep 1; done
	@echo "PostgreSQL is ready!"

## migrate-up: Apply all pending migrations
migrate-up:
	migrate -path migrations -database "$(DB_URL)" up

## migrate-down: Rollback last migration
migrate-down:
	migrate -path migrations -database "$(DB_URL)" down 1

## migrate-reset: Rollback all migrations
migrate-reset:
	migrate -path migrations -database "$(DB_URL)" down

## migrate-version: Show current migration version
migrate-version:
	migrate -path migrations -database "$(DB_URL)" version

## create: Create new migration (usage: make create name=add_indexes)
create:
	@if [ -z "$(name)" ]; then \
		echo "Error: name parameter is required. Usage: make create name=add_indexes"; \
		exit 1; \
	fi
	migrate create -ext sql -dir migrations -seq $(name)

## status: Show migration status
status:
	migrate -path migrations -database "$(DB_URL)" version

## clean: Stop and remove postgres container and volumes
clean:
	docker compose down -v

## psql: Connect to postgres with psql
psql:
	docker compose exec postgres psql -U unibo_user -d unibo_toolkit

## test-cycle: Full test cycle (reset, migrate up, migrate down, migrate up)
test-cycle:
	@echo "==> Resetting all migrations..."
	make migrate-reset || true
	@echo "\n==> Applying all migrations..."
	make migrate-up
	@echo "\n==> Checking migration version..."
	make migrate-version
	@echo "\n==> Rolling back one migration..."
	make migrate-down
	@echo "\n==> Re-applying migration..."
	make migrate-up
	@echo "\n==> Final migration version:"
	make migrate-version
	@echo "\n==> All tests passed!"
