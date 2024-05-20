module "vpc" {
  source       = "../modules/vpc"
  project_name = var.project_name
  vpc_name     = var.vpc_name
  environment  = var.environment
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.11.0"

  cluster_name                   = "${var.environment}-${var.project_name}-${var.eks_cluster_name}"
  cluster_version                = var.eks_cluster_version
  cluster_endpoint_public_access = true

  cluster_ip_family          = "ipv4"
  create_cni_ipv6_iam_policy = true

  enable_cluster_creator_admin_permissions = true

  enable_efa_support = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent    = true
      before_compute = true
      configuration_values = jsonencode({
        env = {
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnet_ids

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t2.micro"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }


}
