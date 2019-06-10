# Calling make will requires the `user` env variables. `mode` is only required if you wished to differentiate dev environment and production env
SHELL := /bin/bash
app_dir ?= $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
uname_s := $(shell uname -s)
ifeq (${uname_s},Linux)
	runuid := $(shell id -u ${user})
	rungid := $(shell id -g ${user})
else ifeq (${uname_s},Darwin)
	user := root
endif
buildenv := app_dir=${app_dir} postfix=${mode} runuid=${runuid} rungid=${rungid}
APP_PORT := $(shell bash -c "cat .env | grep -m 1 -E '^APP_PORT' | sed -e 's/APP_PORT=//g'")
PHPMYADMIN_PORT := $(shell bash -c "cat .env | grep -m 1 -E '^PHPMYADMIN_PORT' | sed -e 's/PHPMYADMIN_PORT=//g'")
compose_cmd := ${buildenv} docker-compose -p crowddung${mode} -f docker/docker-compose.yml
ifeq (${mode},dev)
	compose_cmd += -f docker/docker-compose.dev.yml
	compose_cmd := APP_PORT=${APP_PORT} ${compose_cmd}
endif

ifeq (${phpmyadmin}, true)
	compose_cmd += -f docker/docker-compose.phpmyadmin.yml
	compose_cmd := PHPMYADMIN_PORT=${PHPMYADMIN_PORT} ${compose_cmd}
endif

firsttime:
	user=${user} mode=${mode} ./first-time.sh

up:
	${compose_cmd} up -d --build

down:
	${compose_cmd} down

downwvols:
	${compose_cmd} down -v

ps:
	${compose_cmd} ps

viewlog:
	${compose_cmd} logs -f
