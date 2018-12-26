# https://github.com/tmknom/template-terraform-module
TERRAFORM_VERSION := 0.11.10
-include .Makefile.terraform

.Makefile.terraform:
	curl -sSL https://raw.githubusercontent.com/tmknom/template-terraform-module/master/Makefile.terraform -o .Makefile.terraform

MINIMAL_DIR := ./examples/minimal
COMPLETE_DIR := ./examples/complete

GITHUB_TOKEN_OPTION := -var github_token=$${GITHUB_TOKEN}
GITHUB_ORGANIZATION_OPTION := -var github_organization=$${GITHUB_ORGANIZATION}
TERRAFORM_OPTIONS := ${GITHUB_TOKEN_OPTION} ${GITHUB_ORGANIZATION_OPTION}

terraform-plan-minimal: ## Run terraform plan examples/minimal
	$(call terraform,${MINIMAL_DIR},init)
	$(call terraform,${MINIMAL_DIR},plan,${TERRAFORM_OPTIONS}) | tee -a /dev/stderr | docker run --rm -i tmknom/terraform-landscape

terraform-apply-minimal: ## Run terraform apply examples/minimal
	$(call terraform,${MINIMAL_DIR},apply,${TERRAFORM_OPTIONS})

terraform-destroy-minimal: ## Run terraform destroy examples/minimal
	$(call terraform,${MINIMAL_DIR},destroy,${TERRAFORM_OPTIONS})

terraform-plan-complete: ## Run terraform plan examples/complete
	$(call terraform,${COMPLETE_DIR},init)
	$(call terraform,${COMPLETE_DIR},plan,${TERRAFORM_OPTIONS}) | tee -a /dev/stderr | docker run --rm -i tmknom/terraform-landscape

terraform-apply-complete: ## Run terraform apply examples/complete
	$(call terraform,${COMPLETE_DIR},apply,${TERRAFORM_OPTIONS})

terraform-destroy-complete: ## Run terraform destroy examples/complete
	$(call terraform,${COMPLETE_DIR},destroy,${TERRAFORM_OPTIONS})
