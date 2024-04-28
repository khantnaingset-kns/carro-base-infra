# Terraform Project README

This Terraform project is dedicated to provisioning the infrastructure for Carro Co., Ltd. It includes modules designed for managing different aspects of the infrastructure. Specifically, it contains the following modules:

- **base-infra**: This module sets up the foundational infrastructure, implementing a three-tier AWS VPC architecture. It is organized into three stages: dev, prod, and uat.

- **application**: This module focuses on provisioning HashiCorp Vault using Terraform. Like the base-infra module, it also consists of three stages: dev, prod, and uat.

## State Management

The project utilizes GitHub Actions for deployment automation. Additionally, it employs Amazon S3 and DynamoDB as a state backend for managing Terraform state files, ensuring consistency and reliability across environments.

## Local Usage

1. Clone the repository to your local environment.
2. Navigate to the `modules/base-infra` or `modules/application` directory depending on the infrastructure component you want to deploy.
3. Inside the respective directory, navigate to the desired stage (`dev`, `prod`, or `uat`).
4. Modify the Terraform configuration files (`*.tf`) according to your requirements.
5. Run `terraform init` to initialize the working directory containing Terraform configuration files.
6. Run `terraform plan` to create an execution plan.
7. If the plan looks satisfactory, execute `terraform apply` to apply the changes and provision the infrastructure.
8. Upon completion, verify that the infrastructure has been provisioned successfully.

## CI Workflow

The `.github/workflows/terraform.yml` file defines the GitHub Actions workflow for deploying the Terraform infrastructure. It automates the deployment process, ensuring consistency and reliability across environments.