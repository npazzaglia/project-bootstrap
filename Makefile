.PHONY: help install lint test format sync clean

help:
	@echo "Available commands:"
	@echo "  install    Set up local dependencies (e.g., venv, pre-commit)"
	@echo "  lint       Run all linters"
	@echo "  test       Run tests"
	@echo "  format     Auto-format code"
	@echo "  sync       Run template sync script"
	@echo "  clean      Remove build artifacts and caches"

install:
	python3 -m venv .venv
	. .venv/bin/activate && pip install -r requirements.txt
	pre-commit install || true

lint:
	pre-commit run --all-files

test:
	pytest tests

format:
	black . && isort .

sync:
	bash bin/sync-template.sh

clean:
	rm -rf __pycache__ .pytest_cache .venv dist build *.egg-info
