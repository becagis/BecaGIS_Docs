include .env

# Local
	
pull:
	docker-compose pull

build:
	docker-compose build

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
	docker login -u ${DOCKER_USERNAME} -p $(DOCKER_ACCESS_TOKEN)

publish: build-prod push-prod
	$(WEB_HOOK_REQUEST)

# Windows CMD:
# git pull && git add . && git commit -m 'docs' && docker-compose --env-file ./.env.prod -f docker-compose.prod.yml build && docker-compose --env-file ./.env.prod -f docker-compose.prod.yml push && curl -X POST http://180.148.1.190:9000/api/webhooks/d67c3d36-27de-4000-983d-332db9951174
