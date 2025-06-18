SHELL := /bin/bash
.ONESHELL:

.PHONY: venv activate install clean

venv:
	python3 -m venv venv

activate:
	@echo "Run 'source venv/bin/activate' to activate the virtual environment."

install: venv
	@if [ -f requirements.txt ]; then \
		echo "Installing dependencies from requirements.txt..."; \
		venv/bin/pip install -r requirements.txt; \
	else \
		echo "No requirements.txt found. Skipping dependency installation."; \
	fi

db-config:
	@echo "Loading environment variables from .env and writing to .databrickscfg..."
	@set -a; \
	echo "[DEFAULT]" > .databrickscfg; \
	echo "host = $$DB_HOST" >> .databrickscfg; \
	echo "username = $$DB_USER" >> .databrickscfg; \
	echo "token = $$DB_TOKEN" >> .databrickscfg


clean:
	rm -rf venv