.PHONY: help bootstrap sync lint test

help:
@echo "Available targets:"
@echo "  bootstrap - Run project bootstrap script"
@echo "  sync      - Run template sync script"
@echo "  lint      - Run shellcheck on all .sh files"
@echo "  test      - Run test suite"

bootstrap:
	./bin/bootstrap.sh

sync:
	./bin/sync-template.sh

lint:
	find . -name "*.sh" | xargs shellcheck

test:
	./scripts/test-smoke.sh
