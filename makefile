.DEFAULT_GOAL := default

APP=one-login
REPO=mobee
VERSION="1.1.0"
TAG=$(VERSION)
VENDOR="com.wiser"
BUILD_DATE=$(shell date -u +%Y-%m-%dT%T%z)

# Standard labels that should be in any docker image
LABELS=--label build-date=$(BUILD_DATE) --label name=$(APP) --label version=$(VERSION)
BUILD_ARGS=$(shell cat build_args.env |sed  -e 's/^/--build-arg /' -e 's/.*\#.*//' -e 's/\n/ /')

# Install the script
/usr/local/bin/$(APP): $(APP)
	cp $(APP) /usr/local/bin

# Build the docker image
image: Dockerfile
	docker build --rm -t $(REPO)/$(APP):$(TAG) $(LABELS) $(BUILD_ARGS) .

all: image /usr/local/bin/$(APP)

clean:
	docker rmi $(shell docker images -f "label=name=$(APP)" -q)
	-rm /usr/local/bin/$(APP)

default: all

.PHONY: all clean image