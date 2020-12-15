.PHONY: run

default: run

define set-default-container
	ifndef c
	c = web
	else ifeq (${c},all)
	override c=
	endif
endef

define use-env
	include .env
#	export
endef


set-container:
	$(eval $(call set-default-container))

build: set-container
	docker-compose build ${c}

run:
	docker-compose up -d --force-recreate ${c}

dev:
	docker-compose -f docker-compose.yaml up -d --force-recreate ${c}

restart: set-container
	docker-compose restart ${c}

stop: set-container
	docker-compose stop ${c}

down:
	docker-compose down

exec: set-container
	docker-compose exec ${c} /bin/bash

log: set-container
	docker-compose logs -f ${c}


#run server local
dev-local-deps:
	docker-compose -f docker-compose.yml -f docker-compose-dev.yml up -d --force-recreate db nginx

python_path = server/venv/bin/
local: dev-local-deps
	$(eval $(call use-env))
	. $(python_path)activate && IS_DEBUG=TRUE DB_HOST=localhost DB_NAME=${DB_NAME} \
	POSTGRES_USER=${POSTGRES_USER} POSTGRES_PASSWORD=${POSTGRES_PASSWORD} ./server/manage.py runserver


makemigrations:
	docker-compose exec web ./manage.py makemigrations

migrate: makemigrations
	docker-compose exec web ./manage.py migrate

collectstatic:
	docker-compose exec web ./manage.py collectstatic --noinput
	docker-compose exec web ./manage.py clear_templates_cache

build-static:
	docker-compose up --force-recreate frontend

frontend: build-static collectstatic
