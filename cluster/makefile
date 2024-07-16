TF_VAR_FILE = terraform.tfvars

.PHONY: all
all: init plan apply

.PHONY: init
init:
	terraform init

.PHONY: plan
plan:
	terraform plan -var-file=$(TF_VAR_FILE)

.PHONY: apply
apply:
	terraform apply -var-file=$(TF_VAR_FILE)

.PHONY: destroy
destroy:
	terraform destroy -var-file=$(TF_VAR_FILE)
