include .env

up:
	docker-compose up -d

push:
	docker-compose push docs

pull:
	docker-compose pull docs

login:
	docker login -u becagis -p $(DOCKER_ACCESS_TOKEN)

up-prod:
	docker compose -f docker-compose.prod.yml up docs.prod -d --force-recreate

build-prod:
	docker compose -f docker-compose.prod.yml build

publish:
	docker compose -f docker-compose.prod.yml build
	docker-compose -f docker-compose.prod.yml docs.prod
	curl -X POST $(WEB_HOOK_URL)