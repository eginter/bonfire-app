BASH := $(shell which bash)

#### Makefile config ####
#### NOTE: do not edit this file, override these in your env instead ####

# what flavour do we want?
FLAVOUR ?= classic
FLAVOUR_PATH ?= flavours/$(FLAVOUR)

# do we want to use Docker? set as env var:
# - WITH_DOCKER=total : use docker for everything (default)
# - WITH_DOCKER=partial : use docker for services like the DB 
# - WITH_DOCKER=easy : use docker for services like the DB & compiled utilities like messctl 
# - WITH_DOCKER=no : please no
WITH_DOCKER ?= total

# other configs
FORKS_PATH ?= forks/
MIX_ENV ?= dev
ORG_NAME ?= bonfirenetworks
APP_NAME ?= bonfire
UID := $(shell id -u)
GID := $(shell id -g)
APP_REL_CONTAINER="$(APP_NAME)_release"
WEB_CONTAINER ?= $(APP_NAME)_web
APP_REL_DOCKERFILE=Dockerfile.release
APP_REL_DOCKERCOMPOSE=docker-compose.release.yml
APP_VSN ?= `grep -m 1 'version:' mix.exs | cut -d '"' -f2`
APP_VSN_EXTRA ?= alpha
APP_BUILD ?= `git rev-parse --short HEAD`
APP_DOCKER_REPO="$(ORG_NAME)/$(APP_NAME)-$(FLAVOUR)"
DB_DOCKER_IMAGE ?= postgis/postgis:12-3.1-alpine
CONFIG_PATH=$(FLAVOUR_PATH)/config

#### GENERAL SETUP RELATED COMMANDS ####

export UID
export GID

define setup_env
	$(eval ENV_DIR := $(CONFIG_PATH)/$(MIX_ENV))
	@echo "Loading environment variables from $(ENV_DIR)"
	@$(call load_env,$(ENV_DIR)/public.env)
	@$(call load_env,$(ENV_DIR)/secrets.env)
endef
define load_env
	$(eval ENV_FILE := $(1))
	# @echo "Loading env vars from $(ENV_FILE)"
	$(eval include $(ENV_FILE)) # import env into make
	$(eval export) # export env from make
endef

pre-config: pre-init ## Initialise env files, and create some required folders, files and softlinks
	@echo "You can now edit your config for flavour '$(FLAVOUR)' in config/$(MIX_ENV)/secrets.env, config/$(MIX_ENV)/public.env and ./config/ more generally."

pre-init:
	@echo "Setting flavour to $(FLAVOUR_PATH)"
	@ln -sfn $(FLAVOUR_PATH)/config ./config
	@mkdir -p data/
	@rm -rf ./data/current_flavour
	@ln -sf ../$(FLAVOUR_PATH) ./data/current_flavour
	@mkdir -p $(CONFIG_PATH)/prod
	@mkdir -p $(CONFIG_PATH)/dev
	@touch $(CONFIG_PATH)/deps.path
	@cp -n $(CONFIG_PATH)/templates/public.env $(CONFIG_PATH)/dev/ | true
	@cp -n $(CONFIG_PATH)/templates/public.env $(CONFIG_PATH)/prod/ | true
	@cp -n $(CONFIG_PATH)/templates/not_secret.env $(CONFIG_PATH)/dev/secrets.env | true
	@cp -n $(CONFIG_PATH)/templates/not_secret.env $(CONFIG_PATH)/prod/secrets.env | true

pre-run:
	@mkdir -p forks/
	@mkdir -p data/uploads/
	@mkdir -p priv/static/data
	@ln -s data/uploads priv/static/data/ | true
	@mkdir -p data/search/dev
	@chmod 700 .erlang.cookie

init: pre-init pre-run
	@$(call setup_env)
	@echo "Light that fire... $(APP_NAME) with $(FLAVOUR) flavour in $(MIX_ENV) - docker:$(WITH_DOCKER) - $(APP_VSN) - $(APP_BUILD) - $(FLAVOUR_PATH)"
	@make --no-print-directory pre-init
	@make --no-print-directory services


help: ## Makefile commands help
	@perl -nle'print $& if m{^[a-zA-Z_-~.%]+:.*?## .*$$}' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

env.exports: ## Display the vars from dotenv files that you need to load in your environment
	@awk 'NF { if( $$1 != "#" ){ print "export " $$0 }}' $(FLAVOUR_PATH)/config/dev/*.env


#### COMMON COMMANDS ####

setup: build mix~setup js.deps.get ## First run - prepare environment and dependencies

dev: init dev.run ## Run the app in development

dev.run:
ifeq ($(WITH_DOCKER), total)
	@make --no-print-directory docker.stop.web 
	docker-compose run --name $(WEB_CONTAINER) --service-ports web
#	docker-compose --verbose run --name $(WEB_CONTAINER) --service-ports web
else
	iex -S mix phx.server
endif

doc: ## Generate docs from code & readmes
	@make --no-print-directory mix.remote~docs

recompile: ## Force the app to recompile
	@make --no-print-directory cmd cmd="mix compile --force"

dev.test: init test.env.server dev.run

dev.bg: init  ## Run the app in dev mode, as a background service
ifeq ($(WITH_DOCKER), total)
	@make --no-print-directory docker.stop.web
	docker-compose run --detach --name $(WEB_CONTAINER) --service-ports web elixir -S mix phx.server
else
	elixir --erl "-detached" -S mix phx.server
	echo Running in background...
	ps au | grep beam
endif

db.migrate: mix~ecto.migrate ## Run latest database migrations (eg. after adding/upgrading an app/extension)

db.seeds: mix~ecto.migrate mix~ecto.seeds ## Run latest database seeds (eg. inserting required data after adding/upgrading an app/extension)

db.reset: init dev.search.reset db.pre-migrations mix~ecto.reset  ## Reset the DB (caution: this means DATA LOSS)

dev.search.reset:
ifeq ($(WITH_DOCKER), no)
	echo ...
else
	@docker-compose rm -s -v search
endif
	rm -rf data/search/dev

db.rollback: mix~ecto.rollback ## Rollback previous DB migration (caution: this means DATA LOSS)

db.rollback.all: mix~"ecto.rollback --all" ## Rollback ALL DB migrations (caution: this means DATA LOSS)


#### UPDATE COMMANDS ####

update: init update.repo build update.forks update.deps mix~deps.get mix~ecto.migrate js.deps.get update.repo ## Update the dev app and all dependencies/extensions/forks, and run migrations

update.app: update.repo update.deps ## Update the app and Bonfire extensions in ./deps

update.deps: ## Update Bonfire extensions in ./deps
	@make --no-print-directory mix.remote~updates 

update.repo:
	@chmod +x git-publish.sh && ./git-publish.sh . pull

update.repo.pull:
	@chmod +x git-publish.sh && ./git-publish.sh . pull only

update.deps.bonfire: init mix.remote~bonfire.deps ## Update to the latest Bonfire extensions in ./deps 

update.deps.all: ## Update evey single dependency (use with caution)
	@make --no-print-directory update.dep~"--all"

update.dep~%: ## Update a specify dep (eg. `make update.dep~pointers`)
	@chmod +x git-publish.sh && ./git-publish.sh $(FORKS_PATH)/$* pull
	@make --no-print-directory mix.remote~"deps.update $*"

update.forks: ## Pull the latest commits from all ./forks
	@jungle git fetch || echo "Jungle not available, will fetch one by one instead."
	@chmod +x git-publish.sh && find $(FORKS_PATH) -mindepth 1 -maxdepth 1 -type d -exec ./git-publish.sh {} maybe-pull \;
# TODO: run in parallel? find $(FORKS_PATH) -mindepth 1 -maxdepth 1 -type d | xargs -P 50 -I '{}' ./git-publish.sh '{}'

update.fork~%: ## Pull the latest commits from all ./forks
	@chmod +x git-publish.sh && find $(FORKS_PATH)/$* -mindepth 0 -maxdepth 0 -type d -exec ./git-publish.sh {} pull \;

deps.get: mix.remote~deps.get mix~deps.get js.ext.deps.get ## Fetch locked version of non-forked deps

deps.clean.data: mix~bonfire.deps.clean.data

deps.clean.api: mix~bonfire.deps.clean.api

#### DEPENDENCY & EXTENSION RELATED COMMANDS ####

js.deps.get: js.assets.deps.get js.ext.deps.get

js.assets.deps.get:
	@pnpm -v || npm -g install pnpm
	@chmod +x ./assets/install.sh
	@make --no-print-directory cmd cmd=./assets/install.sh

js.ext.deps.get:
	@chmod +x ./config/deps.js.sh
	@make --no-print-directory cmd cmd=./config/deps.js.sh

deps.outdated:
	@make mix.remote~"hex.outdated --all"

dep.clean:
	make --no-print-directory cmd cmd="mix deps.clean $(dep) --build" 

dep.clone.local: ## Clone a git dep and use the local version, eg: `make dep.clone.local dep="bonfire_me" repo=https://github.com/bonfire-networks/bonfire_me`
	git clone $(repo) $(FORKS_PATH)$(dep) 2> /dev/null || (cd $(FORKS_PATH)$(dep) ; git pull)
	@make --no-print-directory dep.go.local dep=$(dep)

deps.clone.local.all: ## Clone all bonfire deps / extensions
	@curl -s https://api.github.com/orgs/bonfire-networks/repos?per_page=500 | ruby -rrubygems -e 'require "json"; JSON.load(STDIN.read).each { |repo| %x[make dep.clone.local dep="#{repo["name"]}" repo="#{repo["ssh_url"]}" ]}'

dep.go.local: 
	@make --no-print-directory dep.go.local.path dep=$(dep) path=$(FORKS_PATH)$(dep)

dep.go.local~%: ## Switch to using a local path, eg: make dep.go.local~pointers
	@make --no-print-directory dep.go.local dep="$*"

dep.go.local.path: ## Switch to using a local path, specifying the path, eg: make dep.go.local dep=pointers path=./libs/pointers
	@make --no-print-directory dep.local~add dep=$(dep) path=$(path)
	@make --no-print-directory dep.local~enable dep=$(dep) path=""

dep.go.git: ## Switch to using a git repo, eg: make dep.go.git dep="pointers" repo=https://github.com/bonfire-networks/pointers (specifying the repo is optional if previously specified)
	@make --no-print-directory dep.git~add dep=$(dep) $(repo) 2> /dev/null || true
	@make --no-print-directory dep.git~enable dep=$(dep) repo=""
	@make --no-print-directory dep.local~disable dep=$(dep) path=""

dep.go.hex: ## Switch to using a library from hex.pm, eg: make dep.go.hex dep="pointers" version="~> 0.2" (specifying the version is optional if previously specified)
	@make --no-print-directory dep.hex~add dep=$(dep) version=$(version) 2> /dev/null || true
	@make --no-print-directory dep.hex~enable dep=$(dep) version=""
	@make --no-print-directory dep.git~disable dep=$(dep) repo=""
	@make --no-print-directory dep.local~disable dep=$(dep) path=""

dep.hex~%: ## add/enable/disable/delete a hex dep with messctl command, eg: `make dep.hex.enable dep=pointers version="~> 0.2"
	@make --no-print-directory messctl args="$* $(dep) $(version)"

dep.git~%: ## add/enable/disable/delete a git dep with messctl command, eg: `make dep.hex.enable dep=pointers repo=https://github.com/bonfire-networks/pointers#main
	@make --no-print-directory messctl args="$* $(dep) $(repo) config/deps.git"

dep.local~%: ## add/enable/disable/delete a local dep with messctl command, eg: `make dep.hex.enable dep=pointers path=./libs/pointers
	@make --no-print-directory messctl args="$* $(dep) $(path) config/deps.path"

messctl~%: ## Utility to manage the deps in deps.hex, deps.git, and deps.path (eg. `make messctl~help`)
	@make --no-print-directory messctl args=$*

messctl: init 
ifeq ($(WITH_DOCKER), total)
	docker-compose run web messctl $(args)
else ifeq ($(WITH_DOCKER), easy)
	docker-compose run web messctl $(args)
else
	echo "Make sure you have compiled/installed messctl first: https://github.com/bonfire-networks/messctl"
	messctl $(args)
endif


#### CONTRIBUTION RELATED COMMANDS ####

contrib.forks: contrib.forks.publish git.publish ## Push all changes to the app and extensions in ./forks

contrib.release: contrib.forks.publish contrib.app.release ## Push all changes to the app and extensions in ./forks, increment the app version number, and push a new version/release

contrib.app.up: update.app git.publish ## Update ./deps and push all changes to the app

contrib.app.release: update.app contrib.app.release.increment git.publish ## Update ./deps, increment the app version number and push

contrib.app.release.increment: 
	@cd lib/mix/tasks/release/ && mix escript.build && ./release ../../../../ $(APP_VSN_EXTRA)

contrib.forks.publish:
	@jungle git fetch || echo "Jungle not available, will fetch one by one instead."
	@chmod +x git-publish.sh && find $(FORKS_PATH) -mindepth 1 -maxdepth 1 -type d -exec ./git-publish.sh {} \;
# TODO: run in parallel? 

git.forks.add: deps.git.fix ## Run the git add command on each fork
	find $(FORKS_PATH) -mindepth 1 -maxdepth 1 -type d -exec echo add {} \; -exec git -C '{}' add --all . \;

git.forks.status: ## Run a git status on each fork
	@jungle git status || find $(FORKS_PATH) -mindepth 1 -maxdepth 1 -type d -exec echo {} \; -exec git -C '{}' status \;

git.forks~%: ## Run a git command on each fork (eg. `make git.forks~pull` pulls the latest version of all local deps from its git remote
	@find $(FORKS_PATH) -mindepth 1 -maxdepth 1 -type d -exec echo $* {} \; -exec git -C '{}' $* \;

git.diff: ## List all diffs in forks
	@find $(FORKS_PATH) -mindepth 1 -maxdepth 1 -type d -exec echo {} \; -exec git -C '{}' --no-pager diff --color --exit-code \;

deps.git.fix: ## Run a git command on each dep, to ignore chmod changes
	find ./deps -mindepth 1 -maxdepth 1 -type d -exec git -C '{}' config core.fileMode false \;
	find ./forks -mindepth 1 -maxdepth 1 -type d -exec git -C '{}' config core.fileMode false \;

git.merge~%: ## Draft-merge another branch, eg `make git-merge-with-valueflows-api` to merge branch `with-valueflows-api` into the current one
	git merge --no-ff --no-commit $*

git.conflicts: ## Find any git conflicts in ./forks
	find $(FORKS_PATH) -mindepth 1 -maxdepth 1 -type d -exec echo add {} \; -exec git -C '{}' diff --name-only --diff-filter=U \;

git.publish:
	chmod +x git-publish.sh
	./git-publish.sh

#### TESTING RELATED COMMANDS ####

test.env:
	$(eval export MIX_ENV=test)

test.env.server: test.env
	$(eval export START_SERVER=true)

test: init test.env ## Run tests. You can also run only specific tests, eg: `make test only=forks/bonfire_social/test`
ifeq ($(WITH_DOCKER), total)
	docker-compose run web mix test $(only)
else
	mix test $(only)
endif

test.stale: init test.env ## Run only stale tests
ifeq ($(WITH_DOCKER), total)
	docker-compose run web mix test $(only) --stale
else
	mix test $(only) --stale
endif

test.remote: test.env ## Run tests (ignoring changes in local forks)
	@make --no-print-directory mix.remote~"test $(only)"

test.watch: init test.env ## Run stale tests, and wait for changes to any module's code, and re-run affected tests
ifeq ($(WITH_DOCKER), total)
	docker-compose run web mix test.watch --stale $(only)
else
	mix test.watch --stale $(only)
endif

test.interactive: init test.env ## Run stale tests, and wait for changes to any module's code, and re-run affected tests, and interactively choose which tests to run
ifeq ($(WITH_DOCKER), total)
	docker-compose run web mix test.interactive --stale $(only)
else
	mix test.interactive --stale $(only)
endif

# dev-test-watch: init ## Run tests
# 	docker-compose run --service-ports -e MIX_ENV=test web iex -S mix phx.server

test.db.reset: init db.pre-migrations ## Create or reset the test DB
ifeq ($(WITH_DOCKER), total)
	docker-compose run -e MIX_ENV=test web mix ecto.reset
else
	MIX_ENV=test mix ecto.reset
endif


#### RELEASE RELATED COMMANDS (Docker-specific for now) ####
rel.env:
	$(eval export MIX_ENV=prod)
	$(eval export)

rel.config.prepare: rel.env # copy current flavour's config, without using symlinks
	rm -rf ./data/current_flavour
	mkdir data
	@cp -rfL $(FLAVOUR_PATH) ./data/current_flavour

rel.prepare: rel.env rel.config.prepare # copy current flavour's config, without using symlinks
	@mkdir -p forks/ && mkdir -p data/uploads/ && touch data/current_flavour/config/deps.path

rel.rebuild: rel.env init rel.prepare assets.prepare ## Build the Docker image
	docker build \
		--no-cache \
		--build-arg FLAVOUR_PATH=data/current_flavour \
		--build-arg APP_NAME=$(APP_NAME) \
		--build-arg APP_VSN=$(APP_VSN) \
		--build-arg APP_BUILD=$(APP_BUILD) \
		-t $(APP_DOCKER_REPO):$(APP_VSN)-release-$(APP_BUILD) \
		-f $(APP_REL_DOCKERFILE) .
	@echo Build complete: $(APP_DOCKER_REPO):$(APP_VSN)-release-$(APP_BUILD)

rel.build: rel.env init rel.prepare assets.prepare ## Build the Docker image using previous cache
	@echo "Building $(APP_NAME) with flavour $(FLAVOUR)"
	docker build \
		--build-arg FLAVOUR_PATH=data/current_flavour \
		--build-arg APP_NAME=$(APP_NAME) \
		--build-arg APP_VSN=$(APP_VSN) \
		--build-arg APP_BUILD=$(APP_BUILD) \
		-t $(APP_DOCKER_REPO):$(APP_VSN)-release-$(APP_BUILD) \
		-f $(APP_REL_DOCKERFILE) .
	@echo Build complete: $(APP_DOCKER_REPO):$(APP_VSN)-release-$(APP_BUILD) 
	@echo "Remember to run make rel.tag.latest or make rel.push"

rel.tag.latest: rel.env ## Add latest tag to last build
	@docker tag $(APP_DOCKER_REPO):$(APP_VSN)-release-$(APP_BUILD) $(APP_DOCKER_REPO):latest

rel.push: rel.env ## Add latest tag to last build and push to Docker Hub
	@docker push $(APP_DOCKER_REPO):latest

rel.run: rel.env init docker.stop.web ## Run the app in Docker & starts a new `iex` console
	@docker-compose -p $(APP_REL_CONTAINER) -f $(APP_REL_DOCKERCOMPOSE) run --name $(WEB_CONTAINER) --service-ports --rm web bin/bonfire start_iex

rel.run.bg: rel.env init docker.stop.web ## Run the app in Docker, and keep running in the background
	@docker-compose -p $(APP_REL_CONTAINER) -f $(APP_REL_DOCKERCOMPOSE) up -d

rel.stop: rel.env ## Stop the running release
	@docker-compose -p $(APP_REL_CONTAINER) -f $(APP_REL_DOCKERCOMPOSE) stop

rel.update: rel.env update.repo.pull
	@docker-compose -p $(APP_REL_CONTAINER) -f $(APP_REL_DOCKERCOMPOSE) pull
	@echo Remember to run migrations on your DB...

rel.logs:
	@docker-compose -p $(APP_REL_CONTAINER) -f $(APP_REL_DOCKERCOMPOSE) logs

rel.down: rel.env rel.stop ## Stop the running release
	@docker-compose -p $(APP_REL_CONTAINER) -f $(APP_REL_DOCKERCOMPOSE) down

rel.shell: rel.env init docker.stop.web ## Runs a the app container and opens a simple shell inside of the container, useful to explore the image
	@docker-compose -p $(APP_REL_CONTAINER) -f $(APP_REL_DOCKERCOMPOSE) run --name $(WEB_CONTAINER) --service-ports --rm web /bin/bash

rel.shell.bg: rel.env init ## Runs a simple shell inside of the running app container, useful to explore the image
	@docker-compose -p $(APP_REL_CONTAINER) -f $(APP_REL_DOCKERCOMPOSE) exec web /bin/bash

rel.db.shell.bg: rel.env init ## Runs a simple shell inside of the DB container, useful to explore the image
	@docker-compose -p $(APP_REL_CONTAINER) -f $(APP_REL_DOCKERCOMPOSE) exec db /bin/bash

rel.db.dump: rel.env init
	docker-compose -p $(APP_REL_CONTAINER) -f $(APP_REL_DOCKERCOMPOSE) exec db /bin/bash -c "PGPASSWORD=$(POSTGRES_PASSWORD) pg_dump --username $(POSTGRES_USER) $(POSTGRES_DB)" > data/db_dump.sql

rel.db.restore: rel.env init
	cat $(file) | docker exec -i bonfire_release_db_1 /bin/bash -c "PGPASSWORD=$(POSTGRES_PASSWORD) psql -U $(POSTGRES_USER) $(POSTGRES_DB)"

#### DOCKER-SPECIFIC COMMANDS ####

services: ## Start background docker services (eg. db and search backends).
ifeq ($(MIX_ENV), prod)
	docker-compose -p $(APP_REL_CONTAINER) -f $(APP_REL_DOCKERCOMPOSE) up -d db search 
else
ifeq ($(WITH_DOCKER), no)
	@echo ....
else
	docker-compose up -d db search 
endif
endif

build: init ## Build the docker image
ifeq ($(WITH_DOCKER), no)
	@echo Skip building container...
else
	@mkdir -p deps
	docker-compose pull
	docker-compose build
endif

rebuild: init ## Build the docker image
ifeq ($(WITH_DOCKER), no)
	@echo Skip building container...
else
	@mkdir -p deps
	docker-compose build --no-cache
endif

cmd~%: init ## Run a specific command in the container, eg: `make cmd-messclt` or `make cmd~time` or `make cmd~echo args=hello`
ifeq ($(WITH_DOCKER), total)
	docker-compose run --service-ports web $* $(args)
else
	@$* $(args)
endif

shell: init ## Open the shell of the Docker web container, in dev mode
	@make cmd~bash

docker.stop.web: 
	@docker stop $(WEB_CONTAINER) 2> /dev/null || true
	@docker rm $(WEB_CONTAINER) 2> /dev/null || true

#### MISC COMMANDS ####

cmd: init 
ifeq ($(WITH_DOCKER), total)
	docker-compose run web bash -c "$(cmd) $(args)"
else
	$(cmd) $(args)
endif

cmd~%: init ## Run a specific command, eg: `make cmd~"mix deps.get"` or `make cmd~deps.update args=pointers`
	@make --no-print-directory cmd cmd="$*" $(args)

mix~%: init ## Run a specific mix command, eg: `make mix~deps.get` or `make mix~deps.update args=pointers`
	@make --no-print-directory cmd cmd="mix $*" $(args)

mix.remote~%: init ## Run a specific mix command, while ignoring any deps cloned into ./forks, eg: `make mix~deps.get` or `make mix~deps.update args=pointers`
ifeq ($(WITH_DOCKER), total)
	docker-compose run -e WITH_FORKS=0 web mix $* $(args)
else
	WITH_FORKS=0 mix $* $(args)
endif

licenses: init 
	@mkdir -p docs/DEPENDENCIES/
	@make --no-print-directory mix.remote~licenses && mv DEPENDENCIES.md docs/DEPENDENCIES/$(FLAVOUR).md

localise.extract: 
	@make --no-print-directory mix~"bonfire.localise.extract --merge"

assets.prepare:
	@cp lib/*/*/overlay/* rel/overlays/ 2> /dev/null || true

db.pre-migrations: ## Workaround for some issues running migrations
	touch deps/*/lib/migrations.ex 2> /dev/null || echo "continue"
	touch forks/*/lib/migrations.ex 2> /dev/null || echo "continue"
	touch priv/repo/* 2> /dev/null || echo "continue"

secrets:
	@cd lib/mix/tasks/secrets/ && mix escript.build && ./secrets 128 3

