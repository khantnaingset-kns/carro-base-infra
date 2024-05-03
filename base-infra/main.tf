module "vpc" {
  source       = "../../modules/vpc"
  project_name = var.project_name
  vpc_name     = var.vpc_name
  environment  = var.environment
}