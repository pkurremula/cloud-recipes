## Comments that start with ##@ [target] [description] will be shown in help

.PHONY: apply clean destroy help init plan

PROJECT := $(shell basename "$(PWD)")
BOLD := $(shell tput bold)
RED := $(shell tput setaf 1)
GREEN := $(shell tput setaf 2)
BLUE := $(shell tput setaf 4)
RESET := $(shell tput sgr0)

##@ apply: Apply terraform

all: apply
apply: prepare init
	@echo "$(BOLD)$(BLUE)Applying Terraform modules in project $(PROJECT)...$(RESET)"
	terraform apply

##@ prep: Prepare for Terraform run

prepare:
	@echo "$(BOLD)$(GREEN)Preparing for a Terraform run in project $(PROJECT)...$(RESET)"

##@ init: Initialize terraform

init:
	@echo "$(BOLD)$(GREEN)Initializing project $(PROJECT)...$(RESET)"
	terraform init

##@ destroy: Destroy terraform

destroy: init
	@echo "$(BOLD)$(RED)Destroying resources created in project $(PROJECT)...$(RESET)"
	terraform destroy


##@ plan: Plan terraform

plan: init
	@echo "$(BOLD)$(GREEN)Planning Terraform modules in project $(PROJECT)...$(RESET)"
	terraform plan

##@ clean: Clean output files and build cache

clean:
	@echo "$(BOLD)$(RED)Removing terraform metadata in project $(PROJECT)...$(RESET)"
	@rm -rf .terraform
	@rm -f terraform.tfstate*

##@ help: Help

help: Makefile
	@echo " Usage:\n  make \033[36m<target>\033[0m"
	@echo
	@sed -n 's/^##@//p' $< | column -t -s ':' | sed -e 's/[^ ]*/ &/2'
