PROJECT_ROOT := $(shell pwd)
APP_NAME = env-go
APP_SRC := .
TEST_SRC := ./pkg/...
IMAGE_NAME := cybersamx/$(APP_NAME)

# Target setup

.PHONY: all clean build help run docker lint

all: build

##@ run: Run application

run:
	@echo "Running $(APP_NAME)..."
	go run .

##@ build: Build binary

build:
	@-echo "Building $(APP_NAME)..."
	go build -o $(APP_NAME) $(APP_SRC)

##@ docker-build: Build Docker image

docker:
	@echo "Building $(APP_NAME) docker image..."
	@docker \
		build \
		-t $(IMAGE_NAME) \
		.

##@ install: Install dependencies

install:
	@echo "Installing $(APP_NAME) dependencies..."
	go mod download

##@ lint: Run linter

lint:
	@echo "Linting $(APP_NAME)..."
	golangci-lint run -v

##@ test: Run tests

test:
	@echo "Testing $(APP_NAME)..."
	go test $(TEST_SRC) -v

##@ clean: Clean output files and build cache

clean:
	@echo "Removing files and directories..."
	@-rm -rf $(APP_NAME)
	@-$(MAKE) go-clean

go-clean:
	@echo "Cleaning build cache..."
	go clean

##@ help: Help

.PHONY: help
all: help
help: Makefile
	@echo " Usage:\n  make <target>"
	@echo
	@sed -n 's/^##@//p' $< | column -t -s ':' | sed -e 's/[^ ]*/ &/2'
