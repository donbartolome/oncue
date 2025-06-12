# Makefile for Rails + Docker

# Set the default container name
SERVICE ?= web

# Compose wrapper
dc = docker compose

# Standard tasks
up:
	$(dc) up --build -d

down:
	$(dc) down

bash:
	$(dc) exec $(SERVICE) /bin/bash

test:
	$(dc) exec $(SERVICE) bin/rails test

lint:
	$(dc) exec $(SERVICE) bin/rubocop

scan:
	$(dc) exec $(SERVICE) bin/brakeman

.PHONY: up down bash test lint scan
