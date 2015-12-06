APP = rubyonrails
MAINTAINER = dcrbsltd
NAME = $(MAINTAINER)/$(APP)
PORT = 3000
VERSION = 1
.PHONY: all build clean test tag_latest release

all: build

build:
	docker build -f Dockerfile -t $(NAME):$(VERSION) .

clean:
	@eval `docker-machine env default` ||:
	@docker kill `docker ps -a -q` ||:
	@docker rm -f `docker ps -a -q` ||:
	@docker rmi -f `docker images -q` ||:

test:
	env PORT=$(PORT) APP=$(APP) NAME=$(NAME) VERSION=$(VERSION) ./test

deploy:
	

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

docker_release: test tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! head -n 1 Changelog.md | grep -q 'release date'; then echo 'Please note the release date in Changelog.md.' && false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

release:
	@echo "Enter commit message:"
	@read REPLY; \
	echo "${DATE} - $$REPLY" >> CHANGELOG; \
	git add --all; \
	git commit -m "$$REPLY"; \
	git push