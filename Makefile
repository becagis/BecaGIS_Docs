include .env

# Local

pull:
	docker-compose pull

up:
	docker-compose up -d

down:
	docker-compose down


# Production

up-prod:
	docker-compose --env-file ./.env.prod -f docker-compose.prod.yml up -d

down-prod:
	docker-compose --env-file ./.env.prod -f docker-compose.prod.yml down

build-prod:
	docker-compose --env-file ./.env.prod -f docker-compose.prod.yml build

push-prod:
	docker-compose --env-file ./.env.prod -f docker-compose.prod.yml push

# Deployment

login:
	docker login -u becagis -p $(DOCKER_ACCESS_TOKEN)

publish: build-prod push-prod
	$(WEB_HOOK_REQUEST)
