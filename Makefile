.PHONY: bootstrap clean format help install lint post-fork sync test

bootstrap:
	bin/bootstrap.sh

clean:
	rm -rf __pycache__ .pytest_cache .venv dist build *.egg-info

format:
	black . && isort .

help:
	@echo "Available commands:"
	@echo "  bootstrap  Run bootstrap wrapper script"
	@echo "  clean      Remove build artifacts and caches"
	@echo "  format     Auto-format code"
	@echo "  help       Show this help message"
	@echo "  install    Set up local dependencies (e.g., venv, pre-commit)"
	@echo "  lint       Run all linters"
	@echo "  post-fork  Run post-fork automation"
	@echo "  sync       Run template sync script"
	@echo "  test       Run tests"

install:
	python3 -m venv .venv
	. .venv/bin/activate && pip install -r requirements.txt
	pre-commit install || true

lint:
	pre-commit run --all-files

post-fork:
	bin/post-fork.sh

sync:
	bash bin/sync-template.sh

test:
	pytest tests
