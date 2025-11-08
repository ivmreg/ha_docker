PROJECT_NAME=ha_docker

.PHONY: build up down logs ps

build:
	docker compose build

up:
	docker compose up --build

down:
	docker compose down --remove-orphans

logs:
	docker compose logs -f

ps:
	docker compose ps
